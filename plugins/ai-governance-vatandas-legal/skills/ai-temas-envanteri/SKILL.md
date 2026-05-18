---
name: ai-temas-envanteri
description: >
  Beni etkileyen AI sistemlerini kayıt altında tutar. Orijinal EU AI Act per-system envanterinin
  vatandaş perspektifinde yeniden inşası: her sistemin beni nasıl etkilediği, hangi hakkımı
  aktive ettiği, son temasım ve bekleyen aksiyon. Tetikleyiciler: "AI envanterim", "beni
  etkileyen sistemler", "AI sistemi ekle", "sistemler listesi", "kayıt ettiğim AI'lar".
argument-hint: "[list | ekle | duzelt <id> | sinifla <id> | goster <id>]"
---

# /ai-temas-envanteri

## Ne zaman çalışır

Hayatınızda **size karar veren, sizden veri toplayan, sizi etkileyen veya eserlerinizi kullanma potansiyeli olan** AI sistemlerini sistemik bir biçimde takip etmek istiyorsanız. Orijinal EU AI Act envanterinin yerini alır — fakat "provider/deployer" değil, **"beni etkileyen sistem"** sınıflandırması yapar.

## Envanter dosyası

**Konum:** `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/ai-temas-envanteri.yaml`

**Her kayıt şu alanları taşır:**

```yaml
- id: ai-001
  sistem_adi: "Bank X kredi puanlama"
  operator: "Bank X A.Ş. (TR)"
  kategori: otomatik_karar
  etki_seviyesi: dogrudan_zarar_potansiyeli
  beni_nasil_etkiledi:
    - "Kredi başvurum reddedildi ../../2026"
    - "Skor açıklaması verilmedi"
  veri_kaynagi: "KKB üzerinden geçmiş kredi geçmişim"
  tabi_oldugu_mevzuat:
    - "KVKK 6698"
    - "BDDK 2024 AI Rehberi"
  aktif_hak:
    - "KVKK m.11/a — bilgi"
    - "KVKK m.11/g — otomatik karara itiraz"
  son_iletisim: "../../2026 — m.13 başvurusu KEP ile"
  bekleyen_aksiyon: "30 gün yanıt bekleniyor; ../../2026 son tarih"
  iliskili_dosyalar:
    - "ciktilar/2026-05-18_otomatik-karar-itirazi_bank-x.md"
  son_review: ../../2026
  sonraki_review: ../../2026
```

## Kategori taksonomisi

| Kategori | Tanım | Tipik örnek |
|---|---|---|
| `otomatik_karar` | KVKK m.11/g eşiği — münhasıran AI ile alınan karar | Banka kredi, sigorta, vize, sosyal medya hesap kapatma |
| `oneri_algoritmasi` | Beni etkileyen ama doğrudan karar değil | Spotify öneri, YouTube algoritması, Instagram feed |
| `icerik_moderasyonu` | İçeriklerimi otomatik olarak değerlendiren | YouTube Content ID, TikTok algoritması, Meta moderation |
| `profilleme` | Beni kategorize eden | Kredi skoru, reklam profili, davranış skoru |
| `ureticisi_ben_olan_egitim_verisi` | Eserlerim/verim AI eğitiminde olabilir | Suno, Udio, Stable Audio, ChatGPT, Claude |
| `deepfake_riski` | Beni taklit edebilen sistemler | ElevenLabs (ses), Sora (video), HeyGen |
| `siyaset_veya_oze_kararlar` | Yetkili otorite AI'ı | GİB risk skoru, gümrük profilleme, vize taraması |

## Etki seviyesi

- `dolayli_etki` — Var ama dolaylı (Spotify öneri)
- `dogrudan_zarar_potansiyeli` — Aleyhe karar verebilir ama henüz vermedi (kredi skoru)
- `aktif_zarar` — Aleyhe karar verdi (kredi reddi geldi, hesap kapandı)

## MCP araştırma stratejisi

1. **`hukuk_rag` (BİRİNCİL):** Envanter dosyası burada. Tüm CRUD operasyonları (list, add, edit, classify, show)

2. **`mevzuat_mcp`:** Sistem sınıflandırması için KVKK m.11 metni — "otomatik karar" tanımı

3. **`yargi_mcp` KVKK endpoint:** Sistem kategorisi netleştirme — "Bu tipte sistem için Kurul ne demiş?" sorgusu (sinifla komutu)

4. **`scheduled-tasks`:** sonraki_review tarihlerinde otomatik hatırlatma

## Komutlar

### `list` (varsayılan)
Envanter tablosu render edilir:

```
| ID | Sistem | Operatör | Kategori | Etki | Aktif Hak | Bekleyen Aksiyon | Sonraki Review |
|---|---|---|---|---|---|---|---|
| ai-001 | Bank X kredi | Bank X | otomatik_karar | aktif_zarar | m.11/g | yanıt bekleniyor (T-23) | ../../2026 |
| ai-002 | Spotify öneri | Spotify ABD | oneri_algoritmasi | dolayli | gözlem | — | ../../2026 |
```

Tablo altında özet:
- Toplam: N sistem
- Bekleyen aksiyon: N
- 30 gün içinde review: N

**Cowork artifact teklifi:** "İnteraktif dashboard'a çevireyim mi? Renk kodlu, sıralanabilir, filtrelenebilir tablo + summary stats."

### `ekle`
Interaktif intake:
1. Sistem adı
2. Operatör (kim çalıştırıyor, hangi ülke)
3. Kategori (taksonomiden)
4. Beni nasıl etkiledi (somut olay)
5. Veri kaynağı (varsa biliniyor)
6. Tabi olduğu mevzuat (KVKK / GDPR / EU AI Act / FSEK / SMK)
7. Aktif hak (KVKK kataloğundan)
8. Sonraki review tarihi

Eklerken otomatik:
- Dosya yapısı için bir ID üretir (ai-NNN)
- İlgili skill'i öneriyor: "Kategori 'otomatik_karar' — `/otomatik-karar-itirazi` ile takip ediyor musunuz?"

### `duzelt <id>`
Tek bir kayıt için tek alan değişikliği.

### `sinifla <id>`
Mevcut kaydın kategori ve hak haritasını yeniden hesaplar. yargi_mcp KVKK endpoint'inden benzer sistem tipi için Kurul kararlarını çeker, sınıflandırmayı bu içtihat ile teyit eder.

### `goster <id>`
Tam kayıt + ilişkili dosyalar + süre durumu.

## Çıktı yapısı (goster modu)

```
# AI Sistem Kaydı: ai-001
## ⚠️ Gözden geçirici notu
- Sınıflandırma kaynağı: yargi_mcp KVKK ✓ (3 emsal karar)
- Aktif hak listesi: KVKK m.11/a, m.11/g, m.11/h
- Son review: ../../2026

## Temel bilgiler
| | |
|---|---|
| Sistem adı | Bank X kredi puanlama |
| Operatör | Bank X A.Ş. |
| Yerleşim | Türkiye |
| Kategori | otomatik_karar |
| Etki seviyesi | aktif_zarar |

## Beni nasıl etkiledi
- ../../2026 — Kredi başvurum otomatik reddedildi
- ../../2026 — Açıklama talep ettim, "skor düşük" dediler
- ../../2026 — KVKK m.13 başvurusu (KEP)

## Aktif haklarım
- ☑ KVKK m.11/a — bilgi (talep edildi, yanıt bekleniyor)
- ☐ KVKK m.11/g — otomatik karara itiraz (kullanılacak)
- ☐ KVKK m.11/h — tazminat (zarar somutlaştığında)
- BDDK 2024 AI Rehberi — kredi reddi açıklama yükümlülüğü

## Süre takvimi
- ../../2026 — m.13 yanıt son tarih (KALAN: 23 gün)
- ../../2026 — yanıt yetersizse Kurul şikâyet son tarih

## İlişkili dosyalar
- ciktilar/2026-05-18_otomatik-karar-itirazi_bank-x.md
- ciktilar/2026-05-18_kvkk-m13-basvuru_bank-x.pdf

## Sonraki aksiyon
Yanıt geldiğinde değerlendirme. Yanıt yoksa → /kvkk-veri-itirazi --kurul-sikayet

## Eylem ağacı
1. Yanıt geldi → bana ilet → analiz
2. Yanıt yok ve T-7 yaklaşıyor → şikâyet hazırlığı başlat
3. Sınıflandırma güncellemesi
4. Bu kaydı kapat (sorun çözüldü)
```

## Hatalar ve sınırlar

- Envanter **sadece sizin bildiğiniz** sistemleri içerir. Görünmez algoritma sınıflandırmaları (örn. arka planda çalışan reklam profilleme) için **şüphe + KVKK m.11/a bilgi talebi** yolu kullanılır.
- Operatör bilinmiyorsa "bilinmiyor — soruşturuluyor" girilebilir.
- Sınıflandırma her zaman kesin değil; özellikle hibrit (insan + AI) sistemlerde `[doğrula]` etiketi.

## Cross-skill handoff

- Otomatik karar varsa: `/otomatik-karar-itirazi`
- Eser kullanım şüphesi: `/eserim-ai-training`
- Platform TOS yeni öğrenildiyse: `/platform-ai-tos-inceleme`
- Veri ihlal işlemi başlatılacaksa: `/kvkk-veri-itirazi`
