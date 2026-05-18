---
name: matter-workspace
description: >
  Birden fazla AI-ile-ilgili dava/işiniz varsa her birini ayrı klasörde tutar. Orijinal
  multi-client matter-workspace'in vatandaş çevirisi: "müvekkil" değil "kendi davam".
  Tetikleyiciler: "yeni dosya/dava", "davalarımı listele", "Bank X dosyasına geç", "dosyayı kapat".
argument-hint: "[new | list | switch <slug> | close <slug> | none]"
---

# /matter-workspace

## Ne zaman çalışır

Bu eklenti birden fazla **AI ile ilgili kişisel iş**'inizi paralel takip edebilir. Her biri ayrı bir "matter" (dosya) olur. Örnekler:
- `bank-x-kredi-otomatik-karar` — Bank X otomatik kredi reddi süreci
- `suno-eserim-tecavuz` — Suno AI çıktısı eserime benzer
- `spotify-tos-2026-itiraz` — Spotify yeni TOS AI klozları
- `amuse-opt-out` — Amuse'a DSM m.4 opt-out talebi

## Dizin yapısı

```
~/.claude/plugins/config/claude-for-legal/ai-governance-legal/
├── CLAUDE.md (genel profil)
├── ai-temas-envanteri.yaml
├── sure-takvimi.yaml
└── matters/
    ├── bank-x-kredi-otomatik-karar/
    │   ├── matter.md (özet)
    │   ├── history.md (zaman çizelgesi)
    │   ├── ciktilar/
    │   ├── kanitlar/
    │   └── yazismalar/
    ├── suno-eserim-tecavuz/
    │   └── ...
    └── ...
```

## Komutlar

### `new`
İnteraktif intake:
1. Konu özet (bir cümle)
2. Slug (otomatik üretilir veya kullanıcı verir)
3. Tipi: `otomatik-karar` | `eser-tecavuzu` | `tos-itirazi` | `kvkk-sikayet` | `deepfake` | `diğer`
4. Karşı taraf (varsa)
5. Başlangıç tarihi
6. Kritik süreler

Çıktı:
- `matters/<slug>/matter.md` — özet
- `matters/<slug>/history.md` — boş zaman çizelgesi
- Alt klasörler

### `list`
Tüm aktif dosyaları gösterir:

```
| Slug | Tipi | Karşı taraf | Son aksiyon | Kalan süre | Durum |
|---|---|---|---|---|---|
| bank-x-kredi | otomatik-karar | Bank X | m.13 başvurusu | T-23 (yanıt) | açık |
| suno-tecavuz | eser-tecavuzu | Suno Inc. | ihtarname | T-3 (yanıt) | açık |
```

### `switch <slug>`
Aktif matter'ı değiştirir. Bundan sonra **bu eklentinin diğer skill'leri** bu matter klasöründe çalışır.

### `close <slug>`
Çözüldü → arşivle (silme değil)

### `none`
Practice-level moda dön — matter yok.

## Hatalar ve sınırlar

- Cross-matter context **kapalı** varsayılan — bir dosyada öğrenilen başka dosyaya sızmaz
- Avukatlık benzeri bir profesyonel ayrım değildir; kendi dosyalarınızı düzenli tutmanız içindir
