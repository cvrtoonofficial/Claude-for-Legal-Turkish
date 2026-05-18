---
name: mevzuat-degisiklik-takibi
description: >
  Türkiye'de AI, KVKK, FSEK ve sektörel düzenleyici (BDDK, Sağlık Bakanlığı) düzenlemelerinin
  güncel halini izler ve değişikliklerin VATANDAŞA NE KAZANDIRDIĞINI raporlar. Orijinal
  reg-gap-analysis'in vatandaş çevirisi. Tetikleyiciler: "mevzuat güncellemesi", "yeni
  KVKK kararı", "AI yasası ne durumda", "hangi haklarım değişti", "yeni reg ne getirdi".
argument-hint: "[--scan-all (tüm rejimleri tara) | --specific 'rejim adı' | --since YYYY-MM-DD]"
---

# /mevzuat-degisiklik-takibi

## Ne zaman çalışır

İki kullanım modu:
1. **Pasif** — `mevzuat-degisiklik-watcher` agent'ı haftalık otomatik çalıştırır
2. **Aktif** — Kullanıcı bir düzenleyici hareketi duyduğunda elle çalıştırır

## Kapsam (CLAUDE.md'den çekilir)

| Düzenleme | Birincil kaynak | Tarama anahtarları |
|---|---|---|
| KVKK 6698 — güncelleme | mevzuat_mcp `search_kanun` | "KVKK", "6698", "kişisel veri" |
| Türk AI Kanunu | mevzuat_mcp `search_kanun`, TBMM gündemi | "yapay zekâ kanunu", "AI yasası" |
| KVKK Kurul kararları | yargi_mcp `search_kvkk_decisions` | "yapay zekâ", "otomatik karar", "profilleme" |
| EU AI Act fazları | manuel takip + literatur | "EU AI Act Türkiye etkisi" |
| DSM Direktifi aktarımı | mevzuat_mcp `search_kanun`, `search_kurum_yonetmelik` | "telif", "DSM", "metin veri madenciliği" |
| BDDK AI Rehberi | mevzuat_mcp `search_kurum_yonetmelik`, `search_teblig` | "BDDK", "yapay zekâ", "bankacılık" |
| Sağlık Bakanlığı dijital AI | mevzuat_mcp `search_kurum_yonetmelik`, `search_teblig` | "dijital sağlık", "yapay zekâ", "tıbbi karar" |
| Yargıtay FSEK yeni içtihat | yargi_mcp Yargıtay 11. HD | "FSEK", "yapay zekâ" |
| FSHHM deepfake/ses klonu | yargi_mcp `search_bedesten_unified` | "deepfake", "ses klonu", "sahte içerik" |

## MCP araştırma stratejisi

1. **`mevzuat_mcp`** (BİRİNCİL — tüm 9 mevzuat tipi paralel):
   - `search_kanun` — yeni veya güncellenmiş kanunlar
   - `search_khk` — KHK güncellemeleri (varsa)
   - `search_tuzuk` — tüzük
   - `search_kurum_yonetmelik` — sektörel düzenleyiciler
   - `search_teblig` — tebliğler
   - `search_cbk`, `search_cbyonetmelik`, `search_cbgenelge` — CB düzeyi
   - `search_within_*` — eski metin vs yeni metin diff için

2. **`yargi_mcp`:**
   - `search_kvkk_decisions` — Kurul son hafta kararları
   - Yargıtay 11. HD ve FSHHM kararları
   - BDDK kararları
   - AYM bireysel başvuru — AI ile ilgili olanlar

3. **`literatur_mcp` + `yoktez_mcp`:** Yeni doktrin yayını izleme

## Akış

### Pasif mod (agent ile haftalık)
1. Son 7 gün delta taraması
2. Materyal eşik (vatandaş için önemli mi):
   - Yeni hak yaratan ✓
   - Eski hakkı kısıtlayan ✓
   - Süre değiştiren ✓
   - Tanım değiştiren (örn. "otomatik karar" yeniden tanımlanması) ✓
   - Sadece şekli değişiklik ✗
3. Kullanıcı envanterindeki sistemlere etkisi var mı?
4. Kısa rapor (artifact)

### Aktif mod
Kullanıcı kaynak verir (URL, paste, açıklama):
1. Kaynak doğrulanır → birincil metne ulaş
2. Vatandaş etkisi analizi:
   - Yeni hak mı?
   - Yeni yükümlülük mü (vatandaşa değil, veri sorumlusuna)?
   - Süre değişikliği mi?
   - Tanım netleştirmesi mi?
3. Envanter etkisi kontrolü
4. Aksiyon önerisi

## Çıktı yapısı

```
# Mevzuat Değişikliği Raporu — ../../2026

## ⚠️ Gözden geçirici notu
- Kaynaklar: mevzuat_mcp ✓ | yargi_mcp KVKK ✓ | literatur_mcp ✓
- Tarama dönemi: [tarih aralığı]
- Bulunan değişiklikler: N (materyal: N)
- Avukat onayı: gerekli değil — bilgi raporu

## 1. Materyal değişiklikler
### 1.1 KVKK Kurul 2026/XXX sayılı karar (../../2026)
- **Ne değişti:** [açıklama]
- **Bana ne kazandırdı:** [yeni hak / argüman]
- **Hangi sistemleri etkiler:** [envanterden ai-001, ai-003]
- **Önerilen aksiyon:** [varsa]
- **Kaynak:** [yargi_mcp link]

### 1.2 [Diğer]
...

## 2. İzlemede tutulan (henüz materyal değil)
- Türk AI Kanunu — TBMM gündemi 2. okuma `[doğrula]`
- DSM Direktifi aktarım taslağı

## 3. Süre değişiklikleri
- [Eğer varsa]

## 4. Envanter etkisi
- ai-001 (Bank X) — yeni Kurul kararı emsali eklendi → /otomatik-karar-itirazi'ye yeni argüman
- ai-002 (Spotify) — etkilenmedi

## 5. Eylem ağacı
1. Hangi envanter sistemi için aksiyon güncellemesi gerekiyor?
2. Yeni başvuru/şikâyet fırsatı var mı?
3. Sadece arşivle
```

## Cross-skill handoff

- Envanter güncellemesi: `/ai-temas-envanteri sinifla <id>`
- Yeni başvuru fırsatı: `/otomatik-karar-itirazi` veya `/kvkk-veri-itirazi`
- TOS değişikliği bağlantılıysa: `/platform-ai-tos-inceleme --diff`
