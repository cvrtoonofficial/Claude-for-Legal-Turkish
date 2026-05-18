---
name: deal-team-summary-tr
description: >
  M&A işleminin durum brief'i — müvekkil yönetimi (exec summary), iç ekip (working summary)
  veya yatırımcı için farklı altitude'larda özet üretir. Diligence + closing + risk
  bulgularını entegre eder. Tetikleyiciler: "deal team brief", "müvekkili bilgilendir",
  "yatırımcı brief", "ekip özeti", "işlem durumu".
argument-hint: "[--audience exec|team|investor|board | --since <tarih>]"
---

# /deal-team-summary-tr

## Audience'lar (4 hedef kitle)

### 1. `exec` (varsayılan) — Müvekkil yönetimi (CEO, CFO, GC)
- 1 sayfa
- Bullet point
- Risk skoru (yüksek/orta/düşük) + critical path
- "Karar gerektiren konular" başlığı en üstte

### 2. `team` — İç deal team (hukuk + finans + ops)
- 3-5 sayfa
- Tüm açık iş kalemleri
- Sorumlu + deadline
- Diligence bulgularının iç linkleri

### 3. `investor` — Yatırımcı brief
- 2 sayfa
- Materiality eşiklerine göre filtrelenmiş
- Müvekkil sırrı **hiç açılmadan** sunulan rapor
- Sadece "anlaşmaya etki edebilecek" bulgular

### 4. `board` — Müvekkil YK / GK için brief
- Resmi format (TTK m.516 yıllık faaliyet raporuna kaynaklık edebilir)
- İmza alanları
- Karar gerektiren konular ayrıştırılmış

## Standart format (exec için)

```
[İŞLEM ADI] — DEAL BRIEF
Tarih: DD.MM.YYYY  |  Faz: Faz [1/2/3/4]
─────────────────────────────────────────────

DURUM ÖZETİ (3 cümle)

[Müvekkil] tarafından [karşı taraf] satın alma işlemi, [faz] aşamasında.
İmza için [N] gün kaldı. Kapanış [hedef tarih]te.

KRİTİK YOL (T-N gün)

🔴 [Yüksek risk madde] — T-N gün
🟡 [Orta risk madde] — T-M gün
🟢 [Düşük risk madde] — bilgi notu

KARAR GEREKTİREN

1. [Madde] — kim onaylar / kim karar verir
2. [Madde] — ...

ÖNE ÇIKAN BULGULAR

1. **[Kategori]:** [bulgu özeti] → öneri
2. **[Kategori]:** [bulgu özeti] → öneri

AÇIK İŞ KALEMLERİ ÖZET

- Diligence: %X tamamlandı
- Closing checklist: %Y tamamlandı
- Rekabet Kurulu bildirimi: [durum]
- Sektörel onaylar: [durum]
- KVKK audit: [durum]

SONRAKİ ADIM (T+1 hafta)

[Somut, sorumlulu, deadline'lı]

─────────────────────────────────────────────
Sorumlular:
[Hukuk] — [ad]
[Finans] — [ad]
[Hazırlayan] — Claude (yapay zekâ asistan) — [kullanıcı] talimatıyla
```

## Materiality filtresi

Her audience için farklı eşik:

| Audience | Materiality eşiği |
|----------|------------------|
| exec | yüksek + critical path |
| team | yüksek + orta + ilgili düşük |
| investor | yüksek (sadece anlaşmaya etki eden) |
| board | yüksek + critical path + onay gereken |

## Müvekkil sırrı (Av.K. m.36)

`investor` audience'ında müvekkil bilgisinin sızması olmaz:
- Müvekkil verisi maskelenir
- Hassas finansal veriler bandı aralık ifadelerle gösterilir
- Üçüncü taraf bilgisi (banka, mali müşavir, danışman adı) saklı tutulur

## Cross-plugin handoff

- Süre hesaplama: `turk-hukuk-legal:siure-hesap-motoru`
- Atıf normalizasyonu: `turk-hukuk-legal:uyap-atif-formati`
- Final .docx (UYAP formatlı): `turk-hukuk-legal:docx-uretici`

## Final çıktı

- `outputs/deal-brief-YYYY-MM-DD-[audience].docx`
- `outputs/deal-brief-YYYY-MM-DD-[audience].md`
- Excel link (varsa material-contract-schedule, entity-compliance tracker'a)
