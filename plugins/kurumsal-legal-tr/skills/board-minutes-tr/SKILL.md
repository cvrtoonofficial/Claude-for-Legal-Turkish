---
name: board-minutes-tr
description: >
  TTK m.390-391 uyarınca yönetim kurulu toplantı tutanağı — Türk usulü format.
  Hazır bulunanlar listesi, gündem, müzakere özeti, karar metni, imzalar. Noter onayı
  gerekip gerekmediği değerlendirilir. Tetikleyiciler: "YK tutanağı", "toplantı tutanağı",
  "board minutes", "yönetim kurulu kararı".
argument-hint: "[--meeting-date <DD.MM.YYYY> | --type olağan|olağanüstü]"
---

# /board-minutes-tr

## Hukuki dayanak

**TTK m.390** — Yönetim kurulu toplantıları ve karar nisapları
**TTK m.391** — Yönetim kurulu kararının batıl olması halleri
**TTK m.392** — Bilgi alma ve inceleme hakkı

## Toplantı tipleri

- **Olağan YK toplantısı** — Esas sözleşmede belirtilen periyotta
- **Olağanüstü YK toplantısı** — Acil durumlar
- **Komite toplantısı** — Denetim komitesi, ücret komitesi vb.

## Standart format

```
[ŞİRKET ADI]
YÖNETİM KURULU TOPLANTI TUTANAĞI

Toplantı Tarihi: DD.MM.YYYY
Toplantı Saati: HH:MM
Toplantı Yeri: [Adres / Online]
Toplantı Türü: Olağan / Olağanüstü
Karar No: YYYY/NN

I. HAZIR BULUNANLAR

Yönetim Kurulu Üyeleri:
- [Ad SOYAD] (Başkan) — [katıldı/katılmadı/online]
- [Ad SOYAD] (Üye)    — [katıldı/katılmadı/online]
- [Ad SOYAD] (Üye)    — [katıldı/katılmadı/online]

Davetli (varsa):
- [Ad SOYAD] (CFO)
- [Ad SOYAD] (Hukuk Müşaviri)

II. TOPLANTI NİSABI

Yönetim Kurulu üye tam sayısı: N
Toplantıda hazır bulunan: M
Toplantı nisabı: [TTK m.390 — yarıdan bir fazla] sağlanmıştır.

III. GÜNDEM

1. [Gündem maddesi]
2. [Gündem maddesi]
...

IV. MÜZAKERE VE KARAR

GÜNDEM MADDESİ 1: [Konu]

Müzakere: [Özet — kim ne dedi]

KARAR: [Karar metni]

Karar nisabı: [TTK m.390 — toplantıda hazır bulunanların çoğunluğu]
Lehte: M üye  | Aleyhte: 0  | Çekimser: 0

GÜNDEM MADDESİ 2: ...

V. KAPANIŞ

Gündemde başka madde olmadığından, toplantı saat HH:MM'de sona ermiştir.

İmzalar:
___________________
[Ad SOYAD] (Başkan)

___________________
[Ad SOYAD] (Üye)

___________________
[Ad SOYAD] (Üye)
```

## Noter onayı gereken haller

Bazı YK kararları **noter onayı** veya **ek formalitelere** tabidir:

- Esas sözleşme değişikliği önerisi → GK'ya sunulacak → ardından TTK m.452
- Sermaye artışı → GK'da onay sonrası Ticaret Sicil tescili (TTK m.456)
- YK üye değişikliği → Ticaret Sicil tescili 15 gün içinde (TTK m.359)
- Tasfiye kararı → tescil + ilan (TTK m.526 vd.)

Plugin gerekirse "noter onayı gerekiyor mu" şeklinde uyarı verir.

## TTK m.391 batıl karar halleri

Plugin tutanağı üretirken şu kontroller yapılır:

- Çağrı usulü uygun mu (TTK m.390/1)
- Toplantı nisabı sağlandı mı
- Karar nisabı doğru mu
- Üyelerin oy hakkı kısıtlamaları (TTK m.393 — çıkar çatışması)
- Kararın konusu kanuna/esas sözleşmeye aykırı mı

Aykırı olabilecek bir karar tespit edilirse **kırmızı uyarı** verilir.

## Cross-plugin handoff

- Tescil + ilan → `closing-checklist-tr` faz 3
- Atıf normalizasyonu → `turk-hukuk-legal:uyap-atif-formati`
- Final .docx → `turk-hukuk-legal:docx-uretici`
- Yüksek riskli karar (sermaye artışı, esas sözleşme değişikliği) → `cocounsel-legal:predictive-rebuttal-engine` ile stres testi

## MCP kaynakları

- TTK m.390-393 detay: `mevzuat_mcp:get_mevzuat_madde_tree`
- Yargıtay TTK m.391 emsali: `yargi_mcp:search_bedesten_unified`

## Final çıktı

- `outputs/yk-tutanagi-YYYY-MM-DD.docx` (UYAP formatlı)
- Karar defterine yapıştırma talimatı
