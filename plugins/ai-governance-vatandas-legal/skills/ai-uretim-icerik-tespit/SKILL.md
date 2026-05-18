---
name: ai-uretim-icerik-tespit
description: >
  Birisi sizin sesinizi, görüntünüzü, eserlerinizi veya sahne adınızı AI ile (deepfake,
  ses klonlama, AI müzik üretimi, AI görsel) izinsiz kopyalamış veya çoğaltmışsa devreye
  girer. FSEK m.86 (kişinin görüntü ve sesi), TCK m.135-138 (kişisel veri suçları) ve SMK
  m.7 (marka tecavüzü — sahne adı tescilliyse) üç ekseninde paralel değerlendirir.
  Tetikleyiciler: "deepfake", "sesim klonlanmış", "AI ile yüzüm kullanılmış", "AI'da
  beni gördüm", "sahte AI içerik var", "ses klonu", "AI sahnemde konuşmuş gibi yapıyor".
argument-hint: "[opsiyonel: --fsek-86 | --tck-ceza | --smk-marka | --diff-tespit]"
---

# /ai-uretim-icerik-tespit

## Ne zaman çalışır

Bir AI sistemi tarafından **sizi taklit eden / kopyalayan / sahteciliğini yapan içerik** üretilmişse:
- Sesinizin klonlanması (ElevenLabs, RVC, Tortoise tarzı modeller)
- Yüzünüzün deepfake'i (video/foto)
- Sahne adınızla AI müzik üretimi (Suno "[adınız]" parça)
- Yazılı içerikte AI sizi taklit ediyor (chatbot persona)

## Üç paralel hukuki eksen — kasıtlı tasarım

Bu durum **tek bir kanunla** çözülmez. Aynı eylem üç farklı yasal yatağa düşer; hangisinin uygulanacağı **olgu özelinde** belirlenir. Skill üçünü paralel inceler:

### Eksen 1: FSEK m.86 — Kişinin Resim ve Sesi

> *"Eser mahiyetinde olmayan her nevi fotoğraflar, resimler ve sair benzeri eserler ve hâkim hatıraları, ses ve resim röportajları sahibinin muvafakati olmadan tanıtım, satış, kira ve sair surette mevkii tedavüle konulamaz."*

**Önemi:** Eser sahipliği değil, **kişilik hakkı** boyutu. Şarkı bestelemiş olmasanız bile **sesiniz/görüntünüz** sizindir.

**Kapsam:**
- Foto, video, ses kaydı
- AI üretiminden tanınabilir derecede
- "Tanıtım, satış, kira ve sair surette mevkii tedavüle koymak" — yayınlamak, paylaşmak, kâr için kullanmak

**Yaptırım:** Tecavüzün men'i + tazminat (TBK m.49). 10 yıl zamanaşımı.

### Eksen 2: TCK m.135-138 — Kişisel Veri Suçları

| Madde | Suç | Ceza |
|---|---|---|
| m.135 | Kişisel verinin hukuka aykırı olarak kaydedilmesi | 1-3 yıl hapis |
| m.136 | Verileri hukuka aykırı verme/yayma | 2-4 yıl hapis |
| m.137 | Nitelikli haller (kamu görevlisi, suiistimal) | Ağırlaştırılmış |
| m.138 | Verileri yok etmeme | 1-2 yıl hapis |

**Önemi:** Ses ve görüntü KVKK m.3 ve TCK m.135 kapsamında **biyometrik kişisel veridir** (özel nitelikli) `[yargi_mcp KVKK Kurul ile doğrula]`. İzinsiz AI üretim çıktısı bu suçların maddi unsurunu oluşturur.

**Yol:** Cumhuriyet Başsavcılığına şikâyet/suç duyurusu. Müşteki sıfatı.

### Eksen 3: SMK m.7 + m.29 — Marka Tecavüzü (Koşullu)

**Önkoşul:** Sahne adınız veya albüm/parça adınız **TPMK'da tescilli marka** olmalı.

**markapatent_mcp ile kontrol:**
1. `search_trademarks` — Abdullah adı / sahne adı taraması
2. `get_trademark_details` — tescil durumu, sınıflar, koruma kapsamı

Eğer tescilli → SMK m.7/2(b) "ortalama tüketici nezdinde karıştırılma" testi devreye girer. AI üretimi "[sahne adı] tarzında müzik" yayını marka tecavüzü oluşturabilir.

**Yaptırım:** Tecavüzün men + tazminat (SMK m.149-150). 5 yıl zamanaşımı (SMK m.157).

### Ek eksen — KVKK Yolu

Sesin/görüntünün AI eğitim verisi olarak kullanılması ise → `/kvkk-veri-itirazi`. Tek başına AI çıktısı varsa → bu skill.

## MCP araştırma stratejisi

1. **`mevzuat_mcp`:**
   - FSEK m.86 tam metni + gerekçesi
   - TCK m.135-138 tam metni + gerekçesi
   - SMK 6769 m.7, m.29, m.149, m.150, m.157
   - KVKK m.6 (özel nitelikli veri) + m.5 (rıza)

2. **`yargi_mcp`:**
   - FSHHM kararları — deepfake ve ses klonu son 3 yıl
   - Yargıtay 11. HD — FSEK m.86 içtihadı
   - Yargıtay Ceza Genel Kurulu — TCK m.135 yorumu
   - **Bu alan çok yeni** — içtihat sınırlı, doktrin ağırlıklı

3. **`markapatent_mcp` (KOŞULLU):** Sahne adınız tescilli mi?
   - `search_trademarks` — adınızla, sahne adınızla
   - Tescilli ise SMK eksen aktive

4. **`literatur_mcp` + `yoktez_mcp`:**
   - "deepfake" "ses klonu" "yapay zekâ taklit"
   - YÖK Tez'de **son 2 yıl 8+ tez** bu konuda mevcut

5. **`hukuk_rag`:**
   - Önceki ihtarname/dilekçe şablonları
   - Sahne adı kayıt belgeleri (varsa)

## Akış

### Aşama 1 — Olgu intake
- Hangi platform/yer'de AI içerik tespit edildi
- İçerik linki + ekran görüntüsü + timestamp (delil)
- Sizden ne kullanıldı (ses / yüz / sahne adı / kombinasyon)
- Üretici (eğer biliniyorsa) — kişi / hesap / AI platform
- Erişim seviyesi (herkese açık / sınırlı)

### Aşama 2 — Delil tespit (kritik)
**HMK m.400 delil tespiti talebi** gerekli olabilir. Skill bunu hatırlatır:
- AI içeriği indir + hash al + tarihli ekran görüntüsü
- Noterde **tespit tutanağı** (web sitesinin tarihli ve şifresiz tespiti — TBK m.6 ispat)
- Bilgi belgenin saklanması zorunlu

### Aşama 3 — Üç eksen paralel analiz

**FSEK m.86 analizi:**
- Tanınabilirlik testi — ortalama dinleyici/izleyici sizi tanıyor mu?
- "Mevkii tedavüle koyma" var mı? (yayın, satış, kira)
- Muvafakat var mı?

**TCK m.135-138 analizi:**
- Maddi unsur — kişisel veri (ses/görüntü) kaydedilmiş/yayılmış mı?
- Manevi unsur — kasıt
- Cezai sorumluluk eşiği — şikâyete bağlı suç mu?

**SMK m.7 analizi (sahne adı tescilli ise):**
- Marka kullanım eylemi var mı?
- Ortalama tüketici karıştırma testi
- Mal/hizmet aynılığı / benzerliği

### Aşama 4 — Yol haritası

Üç eksen birlikte değerlendirilir; **en güçlü eksen birincil yol** olarak seçilir:

**Senaryo A — Güçlü tanınma + ticari kullanım:**
- Birincil: FSEK m.86 tecavüzün men + tazminat
- İkincil: TCK m.135 şikâyet (cezai baskı)
- Üçüncül (tescilli ise): SMK m.7 marka

**Senaryo B — Sahne adı tescilli + AI içerik o adda satılıyor:**
- Birincil: SMK m.7+m.29 marka tecavüzü
- İkincil: FSEK m.86
- Üçüncül: TCK m.135

**Senaryo C — Sadece eğitim verisi şüphesi (çıktı yok):**
- → `/eserim-ai-training` skill'ine devir

### Aşama 5 — Çıktı

Eylem menüsü:
1. **Noter ihtarnamesi** → `/turk-hukuk-legal:ihtarname-fsek-smk` (FSEK m.86 + SMK m.7 birleşik)
2. **Platform içerik kaldırma bildirimi** → `/turk-hukuk-legal:icerik-kaldirma-bildirim`
3. **Savcılığa suç duyurusu** → bu skill'in `--tck-ceza` argümanı
4. **FSHHM tedbir + men davası** → `/turk-hukuk-legal:dilekce-ihtarname`
5. **HMK m.400 delil tespit** mahkeme talebi

## Çıktı yapısı

```
# KİŞİSEL KULLANIM İÇİN ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR
# AI Üretimi İçerik Tespiti: [özet]
# Tarih: ../../2026

## ⚠️ Gözden geçirici notu
- Kaynaklar: mevzuat_mcp 3 kanun ✓ | yargi_mcp FSHHM + Yargıtay 11. HD + CGK N karar | markapatent_mcp [tescil kontrolü: var/yok] | yoktez_mcp N tez
- Güçlü eksen: [FSEK m.86 / TCK m.135 / SMK m.7]
- Avukat onayı: ihtarname için tavsiye edilir; ceza şikâyeti için gerekli değil; dava için ZORUNLU TAVSİYE

## 1. Olgu özeti
- AI içeriği lokasyonu: [URL]
- Üretici: [bilinen/bilinmeyen]
- Kullanım: [ses / yüz / sahne adı / kombinasyon]
- Tanınabilirlik: [yüksek / orta / düşük]
- Yayın kapsamı: [herkese açık / sınırlı / silinmiş]
- Delil durumu: [arşivlendi / arşivlenmeli — HMK m.400]

## 2. Üç eksen analizi

### Eksen 1 — FSEK m.86 (kişinin görüntü ve sesi)
- Tanınabilirlik: ✓ / ✗
- Muvafakat: ✗ (yok)
- Sonuç: [tecavüz var/yok/tartışmalı]
- Yargıtay 11. HD emsali: [karar — özet]

### Eksen 2 — TCK m.135-138 (kişisel veri suçları)
- Maddi unsur (kayıt/yayma): ✓ / ✗
- Manevi unsur (kasıt): değerlendirme
- Sonuç: [suç var/yok/tartışmalı]
- CGK emsali: [karar — özet]

### Eksen 3 — SMK m.7 (sahne adı marka tescil kontrolü)
- markapatent_mcp sonucu: [tescilli / değil]
- Eğer tescilli: marka tecavüzü ✓ / ✗
- Sonuç: [uygulanabilir / uygulanamaz]

## 3. Önerilen birincil yol
[Hangi eksen, neden bu, ne tipte aksiyon]

## 4. Eylem ağacı
1. [Önerilen] Delil tespit + noter tutanağı (HMK m.400)
2. Noter ihtarnamesi (FSEK m.86 + uygunsa SMK m.7) → `/turk-hukuk-legal:ihtarname-fsek-smk`
3. Platform içerik kaldırma → `/turk-hukuk-legal:icerik-kaldirma-bildirim`
4. Savcılığa şikâyet (TCK m.135) → `/ai-governance-legal:ai-uretim-icerik-tespit --tck-ceza`
5. FSHHM tedbir ve men davası → `/turk-hukuk-legal:dilekce-ihtarname`
6. KVKK boyutu (eğitim verisi şüphesi) → `/ai-governance-legal:eserim-ai-training`
7. Sadece izle (tedbir alındıysa)

## 5. Süre takvimi (sure-takipcisi'ye)
- ../../2026 — delil tespit yapılmalı (acil)
- ../../2026 — noter ihtarnamesi gönderim
- ../../2026 — yanıt son tarihi (7 gün ihtarnamede tipik)
- ../../2026 — TCK m.135 dava zamanaşımı (8 yıl TCK m.66 + uzatma) — kontrol et
```

## Karşı argüman önleme

1. **"Sadece tarz/stil taklit ettim, kişiniz değil"** → Tanınabilirlik testi objektiftir; tarz benzerliği + bağlamsal işaret (sahne adı, lirikal motif) tanınabilirliği oluşturabilir
2. **"AI ürünü sanat eseridir, koruma altında"** → AI ürünü Türk hukukunda eser sayılsa bile (FSEK m.1/B-b "eser sahibi" şartı), **temelinde kullanılan ses/görüntünüz haksız fiildir**
3. **"Kamuya açık veri kullandım"** → Kamuya açık olması KVKK m.5'i bertaraf etmez (yeniden işleme); FSEK m.86 muvafakat şartı kalkmaz
4. **"Eğlence/parodi amaçlı, ticari değil"** → FSEK m.86'da ticari amaç şartı yok; "mevkii tedavüle koyma" geniş yorumlanır; parodi istisnası AB DSM m.17(7) Türkiye'de tam aktarılmadı

## Hatalar ve sınırlar

- Türk içtihadı yeni — argümantasyon ağırlıklı doktrin
- ABD/AB derdest deepfake davaları (örn. *Tennessee ELVIS Act*) yön gösteriyor — model bilgisi etiketli atıf
- Platformlar (TikTok, Instagram, YouTube) genelde **iç bildirim mekanizmaları** ile hızlı kaldırma yapar; hukuki yola gitmeden önce bu denenir
- Ses klonu için **iz bırakmama** sorunu: AI üretiminin tespit edilebilirliği teknik analiz gerektirebilir (audio forensics)

## Cross-skill handoff

- Eğitim verisi şüphesi: `/ai-governance-legal:eserim-ai-training`
- TOS analizi (platform üzerinde içerik): `/ai-governance-legal:platform-ai-tos-inceleme`
- KVKK yolu: `/ai-governance-legal:kvkk-veri-itirazi`
- Noter ihtarnamesi: `/turk-hukuk-legal:ihtarname-fsek-smk`
- İçerik kaldırma bildirimi: `/turk-hukuk-legal:icerik-kaldirma-bildirim`
- Dava dilekçesi: `/turk-hukuk-legal:dilekce-ihtarname`
- DOCX: `/turk-hukuk-legal:docx-uretici`
- Süre takibi: `sure-takipcisi`
