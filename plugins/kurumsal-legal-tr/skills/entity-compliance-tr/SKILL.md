---
name: entity-compliance-tr
description: >
  Türk şirketleri için yıllık ve olay-tetiklemeli uyum takvimi tutar — TTK m.376 öz kaynak,
  m.409 olağan GK, m.397/4 bağımsız denetim, KDV/Muhtasar/Geçici Vergi/KVK, VERBİS,
  MERSİS, Ticaret Sicil. 30/60/90 gün uyarı sistemi. Tetikleyiciler: "entity compliance",
  "şirket takvimi", "yıllık dosyalama", "GK ne zaman", "VERBİS güncelle".
argument-hint: "[--init <entity> | --report | --upcoming <gün> | --health]"
---

# /entity-compliance-tr

## Ne yapar

Şirket(ler) için **uyum takvimi** tutar — yıllık tekrar eden ve olay tetiklemeli yükümlülükleri tracker dosyasında saklar, yaklaşan deadline'ları raporlar.

## Tracker dosyası

`~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/entity-compliance-tracker.yaml`

```yaml
entities:
  - id: muvekkil-1
    name: "[müvekkil — anonimleştirilmiş]"
    legal_form: "anonim_sirket"  # veya: limited, kollektif, komandit, kooperatif
    cira_esigi: ">= 100m_TL"  # bağımsız denetim için (TTK m.397/4)
    incorporation_date: 2020-03-15
    fiscal_year_end: 12-31
    obligations:
      - type: olagan_gk
        mevzuat: TTK m.409
        deadline: 03-31  # her yıl
        status: pending
      - type: ttk_376_kontrolu
        mevzuat: TTK m.376
        deadline: bilanço çıkarımında
        status: not_applicable  # öz kaynak yeterli
      ...
```

## Yıllık Tekrar Eden Yükümlülükler

| Yükümlülük | Mevzuat | Son tarih |
|-----------|---------|-----------|
| Olağan Genel Kurul | TTK m.409 | Faaliyet dönemini izleyen 3 ay (genelde 31 Mart) |
| TTK m.376 öz kaynak kontrolü | TTK m.376 | Her bilanço çıkarımında |
| Bağımsız denetim atama | TTK m.397/4 + Bakanlar Kurulu eşik | GK'da yıllık |
| Yıllık faaliyet raporu | TTK m.516 | GK'dan önce |
| Kurumlar Vergisi Beyannamesi | KVK m.14 | 30 Nisan |
| KDV Beyannamesi | KDVK m.41 | Her ayın 28'i |
| Muhtasar ve Prim Hizmet Beyannamesi | VUK + 5510 | Her ayın 26'sı |
| Geçici Vergi | GVK Mük. m.120 | Çeyrek dönem +14 gün |
| Damga Vergisi | DVK | İşlem anında |
| VERBİS güncelleme | KVKK m.16 + Yönetmelik | Yıllık veya değişiklikte |
| BAĞ-KUR / SGK bildirimi | 5510 | Aylık |
| MERSİS bilgi güncelleme | TTK m.24 | Değişiklikte 15 gün içinde |

## Olay Tetiklemeli Yükümlülükler

| Olay | Yapılması gereken | Mevzuat |
|------|---------------------|---------|
| Sermaye artışı/azaltışı | GK kararı + Ticaret Sicil tescili | TTK m.456, 473 |
| Esas sözleşme değişikliği | GK + tescil + Türkiye Ticaret Sicil Gazetesi | TTK m.452 |
| YK üye değişikliği | Tescil 15 gün içinde | TTK m.359 |
| Adres değişikliği | MERSİS + tescil | TTK m.40 |
| Pay devri (LLC) | Pay defteri + GK onayı (esas sözleşme aksini öngörmemişse) | TTK m.595 |
| Tasfiye kararı | GK + tasfiye memuru tayini + tescil + üç ilan | TTK m.526-548 |

## Komutlar

### `--init <entity>` — Yeni şirket ekle

Plugin sorar:
- Şirket adı + ticaret sicil no
- Hukuki tipi (AŞ, Ltd., kooperatif vb.)
- Kuruluş tarihi
- Faaliyet dönemi sonu (genelde 31 Aralık)
- Yıllık ciro (bağımsız denetim eşiği için)
- Bağlı bulunduğu Ticaret Sicil Müdürlüğü

Sonra şirketin hukuki tipine göre **otomatik yükümlülük listesi** oluşturur.

### `--report` — Tam rapor

Tüm yükümlülükleri, sonraki deadline'ları, geciken yükümlülükleri raporlar.

### `--upcoming <gün>` — Yaklaşan deadline'lar

Önümüzdeki N gündeki deadline'ları gösterir (örn. `--upcoming 30`).

### `--health` — Sağlık kontrolü

Tüm şirketler için kritik kontroller:
- TTK m.376 öz kaynak durumu
- Olağan GK gecikmesi
- Bağımsız denetim ataması eksik
- VERBİS güncel mi
- Vergi borcu var mı (GİB özelgesi gerektirebilir)

## Uyarı eşikleri

- T-90 gün: bilgi notu
- T-30 gün: uyarı
- T-7 gün: kritik uyarı
- T-0 (deadline): final uyarı
- Geciken: sürekli flag

## MCP entegrasyonu

- TTK madde sorguları: `mevzuat_mcp:search_within_kanun`
- Yargıtay TTK m.376 emsali: `yargi_mcp:search_bedesten_unified`
- GİB özelgesi: `yargi_mcp:search_gib_ozelge`

## Cross-plugin handoff

- Açık vergi davası → `turk-hukuk-legal:vergi-uyusmazligi-analiz`
- KVKK ihlali → `ai-governance-vatandas-legal:kvkk-veri-itirazi`
- GK gecikmesi → `turk-hukuk-legal:dilekce-ihtarname` (genel kurul davası)

## Final çıktı

- Markdown rapor (`outputs/entity-compliance-YYYY-MM-DD.md`)
- CSV export (`outputs/entity-compliance.csv`)
- Calendar export (`outputs/entity-compliance.ics`)
