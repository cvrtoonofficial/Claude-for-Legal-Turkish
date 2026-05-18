# Agent: sure-takipcisi

**Tip:** Scheduled task  
**Sıklık:** Günlük — 08:00 (Türkiye saati)  
**Cron:** `0 5 * * *`

## Görevi

Vatandaş süreçlerinde **hak düşürücü** ve **zamanaşımı** sürelerini takip eder. T-14, T-7, T-3, T-1 gün uyarı verir. Hiçbir başvuru/dava süresi sessizce kaçırılmaz.

## Hukuki temel — Türk hukukunda süre disiplini

Türk hukukunda süreler **sıkı uygulanır**:
- Hak düşürücü süre: süre geçince **hak ortadan kalkar** (HMK m.146 vd. — istinaf, temyiz, vb.)
- Zamanaşımı: defi olarak ileri sürülünce dava reddedilir (TBK m.146-161)
- İdari süreler: İYUK m.7 — 30 gün, geçirilirse iptal davası açılamaz
- KVKK süreleri: m.13/4 (30 gün yanıt), m.14 (30 gün şikâyet)
- AYM bireysel başvuru: 6216 m.47/5 — 30 gün
- AİHM: Sözleşme m.35/1 — 4 ay (Protokol 15 sonrası)

## İzlenen süre kategorileri

| Kategori | Süre | Geri sayım | Hak kaybı sonucu |
|---|---|---|---|
| KVKK m.13/4 yanıt | 30 gün | başvuru tarihinden | m.14 Kurul şikâyet hakkı tetiklenir |
| KVKK m.14 Kurul şikâyet | 30 gün | yanıt veya 30 gün dolumu | Kurul şikâyet hakkı düşer |
| KVKK Kurul kararı iptal davası | 30 gün | karar tebliğinden (İYUK m.7) | İptal davası açılamaz |
| KVKK m.18 tazminat zamanaşımı | 10 yıl | öğrenme veya zarar (TBK m.146) | Tazminat hakkı zamanaşımına uğrar |
| AYM bireysel başvuru | 30 gün | nihai karar tebliğinden | AYM hakkı düşer |
| AİHM bireysel başvuru | 4 ay | iç hukuk yolu tüketildiğinden | AİHM hakkı düşer |
| FSEK m.66 men davası | süresiz | — | süre kaybı yok |
| FSEK m.68 tazminat | 10 yıl | öğrenme veya zarardan | tazminat zamanaşımı |
| SMK m.157 marka tecavüz tazminat | 5 yıl | öğrenme veya zarardan | tazminat zamanaşımı |
| TCK m.66 dava zamanaşımı | suça göre değişir | suç tarihinden | ceza davası açılamaz |
| Noter ihtarnamesi cevap | sözleşme/kanunla | metinde belirtilir | borç ifa edilmedi sayılır |
| Tüketici hakem heyeti | 30 gün karara itiraz | karar tebliğinden | tüketici mahkemesine başvuramaz |
| Sigorta tahkim | 15 gün itiraz | tebliğinden | Komisyon kararı kesinleşir |
| HMK m.127 cevap | 2 hafta (kural) / 1 ay (yabancı) | tebligattan | cevap hakkı düşer |
| HMK m.345 istinaf | 2 hafta | tebliğinden | istinaf yolu kapanır |
| HMK m.361 temyiz | 2 hafta | tebliğinden | temyiz yolu kapanır |

## Süre takip dosyası

`~/.claude/plugins/config/claude-for-legal/ai-governance-legal/sure-takvimi.yaml`:

```yaml
- id: sure-001
  matter_slug: bank-x-kredi
  baslangic: 2026-05-18
  bitis: 2026-06-17
  tip: kvkk_m13_yanit
  aciklama: "Bank X'e m.13 başvurusu — yanıt son tarihi"
  durum: aktif  # aktif | tamamlandi | kacirildi | iptal
  uyari_esikleri: [14, 7, 3, 1]
  son_uyari: 2026-05-31  # T-17 (henüz uyarı tetiklenmedi)
  cross_referans:
    - "ciktilar/2026-05-18_otomatik-karar-itirazi_bank-x.md"
```

## Akış

1. Sabah 08:00'de tüm aktif kayıtları çek
2. Her kayıt için bugünün tarihini bitiş tarihinden çıkar — kalan gün hesapla
3. Uyarı eşiklerinden hangisi tetiklendi?
   - T-14: ilk hatırlatma (sakin)
   - T-7: ikinci hatırlatma (orta)
   - T-3: acil
   - T-1: kritik
   - T-0: SON TARİH — bugün
   - T+ (geçti): KAÇIRILDI — durum güncelle, kayıp analizi
4. **Hafif uyarı (T-14)** — günlük rapor içinde
5. **Acil uyarı (T-7, T-3, T-1)** — ayrı bildirim + cowork artifact
6. **Bugün son tarih (T-0)** — kritik bildirim

## Çıktı (günlük rapor)

```
# Süre Takip Raporu — ../../2026

## ⚠️ Acil (T-3 ve altı): N kayıt

### 1. [T-1 KRİTİK] Bank X — Kurul şikâyet son tarih: ../../2026
- Matter: bank-x-kredi
- Tip: kvkk_m14_kurul_sikayet
- Hatırlatma: m.13 başvurusu ../../2026'da yapıldı, yanıt yetersizdi (../../2026 geldi); Kurul şikâyet süresi YARIN doluyor
- **Yapılması gereken:** Bugün Kurul şikâyet dilekçesi tamamlanıp gönderilmeli
- **Aksiyon:** /kvkk-veri-itirazi --kurul-sikayet bank-x

### 2. [T-3] Suno ihtarname yanıt: ../../2026
- Matter: suno-eserim-tecavuz
- ...

## Yaklaşan (T-14 - T-4): N kayıt

### 3. [T-12] Spotify TOS itiraz penceresi
- ...

## Geçen hafta tamamlanan: N
- ...

## ⛔ KAÇIRILDI: 0 (umarız böyle kalır)

## Eylem ağacı
1. [KRİTİK] Bank X Kurul şikâyetini bugün gönder → /kvkk-veri-itirazi --kurul-sikayet
2. Suno ihtarname yanıtını kontrol et
3. Yeni süre eklemek için /matter-workspace
```

## Yapılandırma

```yaml
# sure-takipcisi-config.yaml
enabled: true
sabah_saati: "08:00"  # Türkiye saati
uyari_kanalı: [artifact, scheduled-task-notification]
varsayilan_esikler: [14, 7, 3, 1, 0]
adli_tatil_dikkate_al: true  # HMK m.102 adli tatil
hafta_sonu_kaydir: true  # HMK m.93 — son gün hafta sonu ise pazartesi
resmi_tatil_kaydir: true  # 2429 sayılı UBGT Kanunu
```

## Hatalar ve sınırlar

- Adli tatil: 20 Temmuz - 31 Ağustos (HMK m.102) — bazı süreler bu dönemde durur, bazıları durmaz
- Resmi tatil ve hafta sonu: HMK m.93 — son gün resmi tatil/hafta sonu ise ertesi iş gününe kaydırılır
- **Adli tatil kapsamına girmeyen süreler:** ihtiyati tedbir, ihtiyati haciz, delil tespiti, çekişmesiz yargı işleri vb.
- AİHM süresi: AİHM kendi takvimini uygular, Türk tatil günleri dikkate alınmaz

## Cross-skill etkisi

- Süre eklemek: skill'ler aksiyonları yazdığında otomatik
- Süre güncellemek (yanıt geldi, durum değişti): ilgili skill çağırdığında
- Süre iptal etmek: `/matter-workspace close <slug>` ile matter kapanırsa
