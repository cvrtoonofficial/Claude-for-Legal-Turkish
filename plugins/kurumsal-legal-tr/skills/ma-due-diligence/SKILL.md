---
name: ma-due-diligence
description: >
  Türk hukuku eksenli M&A due diligence — VDR (data room) belgelerini 9 kategoride
  tarayıp materiality eşiklerine göre issue extraction yapar. TTK 6102 + BK 6098 + FSEK
  5846 + SMK 6769 + KVKK 6698 + 4857 İK + VUK 213 + RKHK 4054 + MASAK çerçevesi.
  Tetikleyiciler: "diligence başlat", "VDR taraması", "data room incele", "due diligence",
  "şirket alım incele".
argument-hint: "[--vdr <path> | --category <kategori> | --materiality <eşik>]"
---

# /ma-due-diligence

## Ne zaman çalışır

Aktif bir M&A matter'ı varsa ve diligence aşamasındaysa.

## 9 Kategorili Türk hukuku diligence iskeleti

### 1. Şirketler hukuku (TTK 6102)
- Esas sözleşme + tüm değişiklikler (m.339, 452)
- YK kararları (m.390-391)
- GK tutanakları (m.413-414)
- Pay defteri + pay devirleri (m.499, 595)
- **TTK m.376 öz kaynak durumu** ⚠️ HER ZAMAN MATERIAL
- Bağımsız denetim raporları (m.397/4)
- İmza sirküleri + yetki belgeleri
- Tasfiye/birleşme kararları (m.526-548)

**MCP sorgusu:** `mevzuat_mcp:search_kanun` + `yargi_mcp:search_bedesten_unified`

### 2. Sözleşmesel yükümlülükler (BK 6098 + TBK)
- Material contract eşiğini geçen tüm sözleşmeler
- Change-of-control klozları ⚠️ HER ZAMAN MATERIAL
- Münhasırlık ve non-compete
- Garantiler ve tazminat klozları
- Cezai şart (TBK m.179-182)
- Sözleşmenin devri (BK m.83) — kişiye sıkı sıkıya bağlı haklar

### 3. Fikri ve sınai mülkiyet (FSEK 5846 + SMK 6769)

> **Sanatçı/yapımcı müvekkil profili için kritik kategori**

- Eser sahipliği kayıtları (FSEK m.1/B, m.8)
- Mali hakların devri ve lisansları (m.48-52) ⚠️ HER ZAMAN MATERIAL
- Manevi hakların durumu (m.16-19)
- İleride yapılacak eserler (m.51 — sınırlı geçerlilik)
- Marka, patent, faydalı model, tasarım, coğrafi işaret tescilleri (SMK)
- MESAM / MSG / MÜYAP / MÜYABİR / SETEM üyelikleri
- Royalty hesapları + ödeme gecikmeleri
- Yabancı platform sözleşmeleri (Amuse, Spotify, Apple Music, Epidemic Sound, Kobalt, AWAL, DistroKid, TuneCore)

**Cross-plugin:** `turk-hukuk-legal:sanatci-sozlesme-inceleme`, `turk-hukuk-legal:tecavuz-triyaj`

### 4. İş hukuku (4857 İK + 6356 STİSK + 5510 SGK)
- Açık iş davaları (arabuluculuk + İş Mahkemesi)
- Kıdem + ihbar tazminatı yükümlülükleri
- Mobbing ve sendikal hak iddiaları
- Sanatçı-yapımcı ilişkisinde **gizli iş akdi argümanı** (özellikle aylık ödeme + dağıtım kontrolü varsa)
- SGK borç durumu

**Cross-plugin:** `turk-hukuk-legal:is-davasi-arabuluculuk`

### 5. Vergi (VUK 213 + GVK 193 + KVK 5520 + KDV 3065 + ÖTV + DVK)
- Vergi inceleme raporları
- Uzlaşma tutanakları
- GİB özelgeleri (`yargi_mcp:search_gib_ozelge`)
- Açık vergi mahkemesi davaları
- Geriye dönük vergi borç durumu (E-haciz riskleri)

### 6. KVKK uyumu (KVKK 6698 + GDPR 2016/679)
- VERBİS kayıt durumu (m.16)
- Veri envanteri (Sicil + iç)
- Aydınlatma metni ve açık rıza altyapısı
- Veri ihlali bildirimleri (m.12/5 — 72 saat)
- Yurt dışı aktarım (Schrems II + KVKK m.9)
- Özel nitelikli veri işleme (m.6)

**Cross-plugin:** `ai-governance-vatandas-legal:kvkk-veri-itirazi`

### 7. Rekabet hukuku (RKHK 4054)
- Birleşme/devralma bildirim eşiği kontrolü (2024 sayılı Tebliğ — 2010/4 güncellenmiş hali)
- Açık Rekabet Kurulu soruşturmaları
- Dikey/yatay anlaşma riskleri
- Hâkim durum kötüye kullanımı izleri

**MCP sorgusu:** `yargi_mcp:search_rekabet_kurumu_decisions`

### 8. MASAK uyumu (5549 sayılı Kanun)
- Suç gelirlerinin aklanması iç düzenlemeleri
- Şüpheli işlem bildirim altyapısı
- Mali Suçlar Araştırma Kurulu (MASAK) için ön rapor

### 9. Sektörel düzenleme (uygulanabilirse)
- **RTÜK** — Yayıncılık, dijital yayın platformu
- **BTK** — Elektronik haberleşme, internet servis
- **BDDK** — Bankacılık, ödeme hizmetleri
- **EPDK** — Enerji
- **TPMK** — Marka/patent (FSEK + SMK için)

## Çıktı formatı

Her kategori için ayrı bir markdown rapor + birleştirilmiş özet:

```
## Kategori X — [İsim]

### Önemli bulgular (Materiality: Yüksek)
- **Bulgu 1:** [açıklama]
  - Belge: [VDR yol]
  - Hukuki dayanak: [MCP atıfı]
  - Risk: [yüksek/orta/düşük]
  - Önerilen aksiyon: [somut]

### Orta materiality bulguları
- ...

### Bilgi amaçlı (düşük materiality)
- ...

### Cross-plugin handoff
- [Diğer plugin'in skill'ine yönlendirme]
```

## Materiality eşikleri (varsayılan)

| Kategori | Eşik |
|----------|------|
| Sözleşmesel | > 500.000 TL veya > 50.000 EUR |
| Dava | > 100.000 TL veya manevi tazminat |
| Change-of-control | Her zaman material |
| FSEK m.48-52 mali hak devri | Her zaman material |
| TTK m.376 öz kaynak kaybı | Her zaman material |
| KVKK özel nitelikli veri | Her zaman material |
| Rekabet Kurulu birleşme eşiği aşımı | Her zaman material |

## Magesh anti-halüsinasyon kalkanı

Her atıf MCP teyidi alır. Atıf doğrulanamadıysa `[model bilgisi — doğrula]` etiketi konur ve müvekkilden manuel teyit istenir.

## Cross-plugin handoff matrisi

| Bulgu tipi | Handoff |
|-----------|---------|
| KVKK uyumsuzluğu | `ai-governance-vatandas-legal:kvkk-veri-itirazi` |
| FSEK/SMK ihlali | `turk-hukuk-legal:tecavuz-triyaj` + `turk-hukuk-legal:ihtarname-fsek-smk` |
| Sanatçı sözleşmesi sorunu | `turk-hukuk-legal:sanatci-sozlesme-inceleme` |
| Açık iş davası | `turk-hukuk-legal:is-davasi-arabuluculuk` |
| Vergi uyuşmazlığı | `turk-hukuk-legal:vergi-uyusmazligi-analiz` |
| Cross-border sözleşme | `turk-hukuk-legal:sinirostesi-sozlesme-fesih` |
| Yüksek riskli işlem (PAC-7) | `cocounsel-legal:predictive-rebuttal-engine` |

## Final çıktı

- Markdown rapor (`outputs/diligence-rapor-YYYY-MM-DD.md`)
- Sözleşme özet tablosu (`outputs/material-contracts.xlsx`)
- Cross-plugin handoff için JSON manifest

`turk-hukuk-legal:docx-uretici` ile UYAP-formatlı .docx üretilebilir.
