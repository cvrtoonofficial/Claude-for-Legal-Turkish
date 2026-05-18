---
name: matter-workspace
description: >
  Çoklu müvekkil/işlem dosyası yönetimi — yeni matter aç, mevcut matter'ları listele,
  aktif matter'ı değiştir, matter kapat. Tetikleyiciler: "yeni dosya aç", "yeni matter",
  "müvekkil listele", "dosyayı kapat", "aktif matter değiştir".
argument-hint: "[--new | --list | --switch <id> | --close <id> | --detach]"
---

# /matter-workspace

## Ne yapar

Müvekkil bilgisi ve dava/işlem verisini **izole edilmiş bir dizinde** tutar. Av.K. m.36 sır saklama yükümlülüğüne uygun: müvekkil verisi profile dosyasına yazılmaz; her matter ayrı bir alt-dizindedir.

## Dizin yapısı

```
~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/matters/
├── _log.yaml                    (matter envanteri)
├── _active.txt                  (şu an aktif matter ID)
└── <matter-id>/
    ├── matter.md                (matter özeti)
    ├── history.md               (kronolojik olay defteri)
    ├── parties.yaml             (taraflar)
    ├── deadlines.yaml           (kritik süreler)
    ├── documents/               (yüklenen sözleşme/belge)
    ├── diligence/               (diligence çıktıları)
    ├── closing/                 (kapanış belgeleri)
    └── outputs/                 (dilekçe, ihtarname, brief)
```

## Komutlar

### `--new` — Yeni matter aç

Plugin sorar:
1. Matter adı (örn. "Yapımcı X'in Y şirketi alımı")
2. Müvekkil adı / TCKN / VKN
3. Karşı taraf adı
4. İşlem türü (M&A, sözleşme inceleme, dava, ihtarname vb.)
5. Yetkili mahkeme (cross-plugin: `turk-hukuk-legal:yargi-yolu-secimi`)
6. Müvekkil amacı
7. Kritik süreler
8. Risk profili (düşük/orta/yüksek)
9. Müvekkil bütçesi (opsiyonel)

Matter ID otomatik üretilir: `YYYY-MM-DD-<slug>` (örn. `2026-05-19-yapimci-x-alim`).

### `--list` — Tüm matter'ları listele

`_log.yaml`'dan tüm aktif ve kapalı matter'ları gösterir:

```
ID                              | Tip      | Müvekkil | Durum    | Son güncelleme
2026-05-19-yapimci-x-alim       | M&A      | [maskeli]| aktif    | 2 gün önce
2026-04-12-sozlesme-fesih       | Dava     | [maskeli]| kapalı   | 5 gün önce
```

> **Not:** Müvekkil adı varsayılan olarak maskelenir (kullanıcı `--reveal` ile açabilir).

### `--switch <id>` — Aktif matter'ı değiştir

`_active.txt`'i günceller. Sonraki tüm skill çağrıları bu matter'a yazar.

### `--close <id>` — Matter kapat

- Kapanış tarihi `matter.md`'ye yazılır
- `_log.yaml`'da `status: kapalı` olur
- Yedek alınır (`backups/` altına)
- Dizin korunur (5 yıl saklanmalı — Av.K. m.37 + KVKK m.7)

### `--detach` — Practice-level çalışma

Aktif matter'dan çık. Plugin matter olmadan da çalışır (sadece genel danışma için).

## Cross-plugin handoff

- Matter açıldığında `turk-hukuk-legal:matter-intake` skill'i de çağrılabilir (paralel dosya)
- Süre takvimi `turk-hukuk-legal:siure-hesap-motoru` ile hesaplanır
- Yargı yolu seçimi `turk-hukuk-legal:yargi-yolu-secimi` ile yapılır

## Müşteri sırrı (Av.K. m.36)

- Müvekkil adı, TCKN/VKN sadece matter dizininde tutulur
- Her çıktıda müvekkil adı `[müvekkil]` placeholder olarak gösterilebilir (`--anonymize` flag'i ile)
- `musteri-sirri-prehook` her çıktıda izolasyonu doğrular
