---
name: eserim-ai-training
description: >
  Müzik eserleri, beste, ses kaydı, fotoğraf veya diğer eserlerinizin generatif AI sistemleri
  (Suno, Udio, Stable Audio, MusicLM, ElevenLabs, Midjourney, Stable Diffusion vb.) tarafından
  eğitim verisi olarak kullanılmış olabileceği şüphesi varsa devreye girer. FSEK m.21 işleme,
  m.25 kamuya iletim ve DSM Direktifi m.4(3) TDM opt-out çerçevesinde haklarınızı haritalar ve
  opt-out talebi veya tecavüz tespit dilekçesi taslağı üretir. Tetikleyiciler: "AI eserime
  benziyor", "Suno benim parçamı kopyalamış", "ChatGPT eserlerimi öğrenmiş", "AI eğitim verisi
  opt-out", "modelimi eğittiler mi", "ben yapmadığım ama benim tarzımda parça".
argument-hint: "[eser tanımı veya kanıt URL'si, opsiyonel --opt-out-talebi veya --tecavuz-tespit]"
---

# /eserim-ai-training

## Ne zaman çalışır

İki ayrı senaryoda devreye girer:

1. **Şüphe modu:** Eserlerinizin (özellikle Spotify, Amuse, YouTube üzerinden yayınlanmış olanlar) bir generatif AI'ın eğitim verisinde olduğundan **şüpheleniyorsanız** — emin değilsiniz ama haklarınızı önceden korumak istiyorsunuz.
2. **Tespit modu:** Bir AI çıktısının eserlerinize **açıkça benzediğini** tespit ettiyseniz (Suno ile "[tarzımda]" parça üretildi, ses klonum kullanıldı vb.).

## Hukuki temel — iki paralel eksen

### Eksen 1: Türk Hukuku — FSEK 5846

| Madde | Hak | AI eğitim verisi senaryosuna uygulama |
|---|---|---|
| m.13 | Mali hakların eser sahibine aitliği | Eserin AI eğitiminde kullanılması mali hakkın kullanımıdır |
| m.21 | İşleme hakkı | AI modelinin eseri parametrelerine "öğrenmesi" işleme sayılabilir mi? Tartışmalı `[doğrula]` |
| m.22 | Çoğaltma hakkı | Eserin eğitim veri setine kopyalanması çoğaltmadır |
| m.25 | İşaret, ses ve görüntü nakline yarayan vasıtalarla umuma iletim | AI çıktısı eseri içeriyorsa umuma iletim |
| m.42 | Meslek birliği yetkisi (MESAM) | MESAM'ın yetki alanı; bireysel takip ile çakışır mı? |
| m.52 | Mali hakların devri / kullandırılması — **yazılı şekil şartı** | "Sözleşmenin küçük yazılı bir maddesinde gizli AI eğitim izni" yazılı şekil tartışmalı |
| m.66 | Tecavüzün men'i ve önlenmesi davası | İhlal halinde dava türü |
| m.68 | Telafi (tecavüze rağmen elde edilebilir tazminat) | Tazminat hesabı |
| m.86 | Kişinin resmi ve sesi | Eğer eseriniz aynı zamanda **sesinizi** içeriyorsa ek koruma |

### Eksen 2: AB Hukuku — DSM Direktifi 2019/790

| Madde | Hak | Uygulama |
|---|---|---|
| m.3 | TDM istisnası — bilimsel araştırma | AI eğitim TDM (text and data mining) sayılır; bilimsel araştırma için izin gerekmez |
| m.4 | **TDM istisnası — genel** | AI eğitim TDM kapsamına girer **ama**: |
| m.4(3) | **Opt-out hakkı** | Hak sahibi **makine-okunabilir** şekilde opt-out beyan ettiyse TDM yapılamaz |
| m.4(4) | Makine-okunabilir tedbir | Robots.txt, ai.txt, metadata, web sayfası açıklaması — yargısal tartışma sürüyor |

**Türkiye DSM aktarımı:** Türkiye DSM'yi henüz tam aktarmamıştır. **Ancak:** AB pazarına eser dağıtan (Spotify, Apple Music, Amuse aracılığıyla AB'de erişilebilir kılınan) eserler için DSM doğrudan uygulanır — eserin **AB ülkesinde işlenmesi** (eğitim) AB hukukuna tâbidir.

### Eksen 3: Karşılaştırmalı — ABD ve ABAD içtihatı

- **ABAD — *Pelham*** (C-476/17, 29.07.2019): Bir ses kaydından alınmış kısa örnek (2 saniyelik "sampling") çoğaltma sayılır; eser sahibinin izni gerekir `[doğrula]`
- **ABD — *Andersen v. Stability AI*** (devam ediyor): Sanatçıların telifli görsellerinin Stable Diffusion eğitiminde kullanımı davası
- **ABD — *RIAA v. Suno/Udio*** (devam ediyor): Suno ve Udio AI müzik üreticilerine karşı plak şirketleri davası
- **AB — Hamburg LG, *Robert Kneschke v. LAION*** (27.09.2024): Stok fotoğrafçının LAION eğitim veri setinden çıkarılma talebi — bilimsel araştırma TDM istisnası kabul edildi; ticari için **opt-out hakkı geçerli** `[doğrula]`

## MCP araştırma stratejisi

**Sıralı tarama (atlama yok):**

1. **`mevzuat_mcp`:**
   - `get_mevzuat_content` ile FSEK 5846 m.13, m.21, m.22, m.25, m.52, m.66, m.68, m.86 — tam metin
   - `get_mevzuat_gerekce` ile FSEK m.21 gerekçesi (eseri eğitim verisine almak "işleme" mi?)
   - DSM Direktifi için Türkiye'ye aktarım belgesi varsa `search_kanun`

2. **`yargi_mcp`:**
   - `search_bedesten_unified` veya `search` ile "yapay zekâ" + "FSEK" anahtar kelimeleri — son 3 yıl
   - Yargıtay 11. HD (FSEK fıkrası) kararları — telif tecavüzü içtihadı
   - FSHHM (Fikri ve Sınai Haklar Hukuk Mahkemesi) kararları
   - ABAD kararları için manuel referans (mevzuat_mcp'de yok)

3. **`literatur_mcp` + `yoktez_mcp`:**
   - "yapay zekâ" "telif" "eser" anahtar kelimeleri
   - Son 3 yıl tezleri **çok önemli** — bu konuda Türkiye'de 12+ yapay zekâ ve telif başlıklı YÖK Tez mevcut
   - Suluk, Memiş, Yeniçeri, Akkurt gibi yazarların DergiPark makaleleri
   - **Doktrin ağırlıklı** çünkü Türk içtihadı henüz oturmamış

4. **`markapatent_mcp`:**
   - Sahne adınız tescilli marka mı? (SMK m.7 ek koruma)
   - Eser adınız (albüm/parça) marka olarak tescilli mi?
   - AI çıktısı sahne adınızı içeriyorsa marka tecavüzü ek argümanı

5. **`hukuk_rag`:**
   - Spotify, Amuse, Apple Music, Epidemic Sound TOS arşivleri — AI eğitim klozları
   - Önceki opt-out talepleri varsa şablon

## Akış

### Şüphe modu

**Aşama 1 — Eser envanteri:** Hangi eserlerin AI eğitiminde olabileceği belirlenir:
- Spotify katalogu (Amuse / DistroKid / TuneCore dağıtımı)
- YouTube — özellikle herkese açık yüklemeler
- SoundCloud
- BandCamp
- Bireysel web sitesi
- Sample paketleri (Splice, Loopmasters, Sounds.com)

**Aşama 2 — Platform tarafı — TOS analizi:**
- Her platformun AI eğitim klozunu hukuk_rag'den çek
- Yoksa kullanıcıdan güncel TOS'u indirmesini iste
- `/platform-ai-tos-inceleme` skill'ine devir
- Hangi platform AI eğitime izin veriyor, hangisi opt-out sunuyor

**Aşama 3 — AI tarafı — eğitim verisi şüphesi:**
- AI sağlayıcısının (Suno, OpenAI, Anthropic vb.) açıkladığı eğitim veri kaynakları
- Şüphe varsa bilgi talebi (KVKK m.11/a — kişisel veri ise; FSEK m.21 — eser ise)

**Aşama 4 — Opt-out talebi taslağı:**
- DSM m.4(3) gereği makine-okunabilir opt-out
- Her platform için ayrı talep
- Talep şu unsurlardan oluşur:
  1. Eser sahibi kimliği (Abdullah, sahne adı, MESAM üyelik no varsa)
  2. Eser listesi (Spotify URI'leri, ISRC kodları)
  3. Talep: bu eserlerin (a) TDM eğitim verisi olarak kullanılmaması, (b) varsa eğitim setinden çıkarılması, (c) AI üretim çıktılarında kullanılmaması
  4. Hukuki temel: FSEK m.21, m.52 + DSM m.4(3)
  5. Yanıt süresi: 30 gün
  6. Sonuçlar: yanıt yoksa veya yetersizse FSEK m.66 men davası

### Tespit modu

**Aşama 1 — Benzerlik analizi:**
- Sunulan AI çıktısı ile orijinal eseriniz arasında karşılaştırma:
  - Melodi (notalar, ritim)
  - Sözler (lirikal benzerlik)
  - Ses kaydı (timbre, vokal karakteristikleri)
  - Tarz/stil (FSEK m.2 — "tarz" eser sayılmaz; ancak "tanınabilir karakter" sayılabilir)
- **Eşik:** Yargıtay 11. HD içtihadında "ortalama dinleyici" testi `[yargi_mcp ile doğrula]`

**Aşama 2 — Olası yollar:**
- **Yol A — FSEK m.66 men davası:** Tecavüzün önlenmesi, AI çıktısının kaldırılması
- **Yol B — FSEK m.68 tazminat:** Hesaplama: gerçek zarar veya elde edilmiş kazanç veya farazi bedel (3 kat'a kadar)
- **Yol C — TCK m.71 (FSEK cezai):** Savcılığa şikâyet (manevi hak ihlali halinde)
- **Yol D — SMK m.29:** Sahne adı taklit edilmişse marka tecavüzü

**Aşama 3 — Cross-skill devir:**
- Önce noter ihtarnamesi → `/turk-hukuk-legal:ihtarname-fsek-smk`
- Cevap yetersizse → `/turk-hukuk-legal:dilekce-ihtarname` (FSHHM dava dilekçesi)
- Eğer platformlardan kaldırma → `/turk-hukuk-legal:icerik-kaldirma-bildirim`
- Sınır ötesi (Suno ABD'de) → `/turk-hukuk-legal:sinirostesi-sozlesme-fesih` benzeri yapıda strateji

## Çıktı yapısı

```
# KİŞİSEL KULLANIM İÇİN ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR
# Eser Sahibi: Abdullah | Tarih: ../../2026

## ⚠️ Gözden geçirici notu
- Kaynaklar: mevzuat_mcp FSEK ✓ | yargi_mcp Yargıtay 11. HD N karar | yoktez_mcp N tez | literatur_mcp N makale | markapatent_mcp [sahne adı kontrolü]
- Mod: [şüphe / tespit]
- AB temas: [evet — eserlerim Spotify üzerinden AB pazarında / hayır]
- Avukat onayı: opt-out talebi için gerekli değil; FSHHM davası için ZORUNLU TAVSİYE

## 1. Olgu özeti
- AI sistemi: [Suno / Udio / Stable Audio / diğer]
- İddia edilen ihlal: [eğitim verisi / çıktı benzerliği / her ikisi]
- Eserim (etkilenen): [liste — ISRC, Spotify URI varsa]
- AB pazarı temas: [var/yok]

## 2. Hukuki çerçeve
### Türk hukuku (FSEK)
- m.21 işleme: [uygulanır mı, doktrin tartışması]
- m.22 çoğaltma: [eğitim setine kopyalama]
- m.25 umuma iletim: [çıktı yayını]
- m.52 yazılı şekil: [platform sözleşmesindeki kloz geçerli mi]

### AB hukuku (DSM)
- m.4(3) opt-out: [bildirildi mi, makine-okunabilir formatta mı]
- Hamburg LG Kneschke kararı: [emsal değer]

### İçtihat
- Yargıtay 11. HD: [N karar — özet]
- KVKK Kurul (varsa veri sahipliği yönü): [N karar]

## 3. Aktif haklarınız
- [m.21 izin talebi - opt-out]
- [m.66 men - tecavüz tespit edilirse]
- [m.68 tazminat - hesaplama]
- [m.86 ses/görüntü - ek koruma]
- [SMK m.29 marka - sahne adı tescilliyse]

## 4. Eylem planı

### Senaryo: opt-out modunda
1. Her platform için DSM m.4(3) opt-out talebi → [taslak metin]
2. Süre takibi: 30 gün yanıt
3. Yanıt yetersiz → FSHHM tedbir + men davası

### Senaryo: tecavüz tespit modunda
1. Delil tespit: AI çıktısı arşivlenmeli (URL + ekran görüntüsü + timestamp)
2. Noter ihtarnamesi → `/turk-hukuk-legal:ihtarname-fsek-smk`
3. Yanıt 7 gün
4. Yanıt yetersiz → FSHHM tecavüzün men + tazminat davası
5. Manevi hak ihlali → Cumhuriyet Başsavcılığına FSEK m.71 şikâyet

## 5. Dilekçe / talep taslağı
[Mod'a göre — opt-out talebi veya ihtarname özeti]

## 6. Süre takvimi (sure-takipcisi)
- ../../2026 — opt-out talebi gönderim
- ../../2026 — yanıt son tarihi
- ../../2026 — yanıt yetersiz → ihtarname ile sonraki aşama

## 7. Eylem ağacı (Decision tree)
1. [Önerilen] Tüm platformlara opt-out talebi → `/eserim-ai-training --opt-out-talebi`
2. Tespit edilen AI çıktısına karşı ihtarname → `/turk-hukuk-legal:ihtarname-fsek-smk`
3. Delil tespit talebi (HMK m.400) → mahkemeden tespit istemi → `/turk-hukuk-legal:dilekce-ihtarname`
4. MESAM bilgilendirme (m.42 meslek birliği) → MESAM'a şikâyet
5. Sosyal medya kampanyası ile baskı (yasal değil; PR yolu) — DUR — bu eklenti tavsiye etmez (hakaret/iftira riski)
```

## Karşı argüman önleme

Skill aşağıdaki karşı argümanlara önceden cevap yerleştirir:

1. **"AI eğitimi 'fair use' / TDM istisnası"** → Türk hukukunda fair use yok; FSEK m.30-46 sınırlı istisnalar listesi (eğitim verisi için açık istisna yok). DSM m.4 ticari TDM için **opt-out hakkı** vardır.
2. **"Platform sözleşmesinde izin verdiniz"** → FSEK m.52 yazılı şekil + mali hakların **ayrı ayrı sayılması**; "tüm türev kullanımlara izin" şeklindeki genel kloz Yargıtay 11. HD içtihadında geçersiz `[doğrula]`.
3. **"Eseriniz AI'da kullanıldığını ispatlayamazsınız"** → İspat yükü dengeli — AI sağlayıcısının eğitim veri kaynaklarını açıklama yükümlülüğü (EU AI Act Art. 53 GPAI üreticileri için "training data summary"), KVKK m.11/a benzeri şeffaflık talebi.
4. **"AI çıktısı yeni ve özgün eserdir"** → FSEK m.21 işleme ve m.6 işlenme eseri tartışması; izinsiz türev hâlâ tecavüzdür.
5. **"Sınır ötesi — ABD/AB'de dava açın"** → MÖHUK m.20 + AİHS m.6 etkili başvuru hakkı; eserin **Türkiye'den de dinlenebilmesi** Türk mahkemesi yetkisini oluşturur (FSEK m.76 mülki yetki).

## Hatalar ve sınırlar

- Türk içtihadı bu alanda çok yeni — argümantasyon ağırlıklı doktrin ve karşılaştırmalı kaynak.
- ABD/AB derdest davaların (Andersen, RIAA, Kneschke) sonuçları Türk yorumunu da etkileyecektir; `mevzuat-degisiklik-takibi` agent'ı bu kararları izler.
- **MESAM yetki ile bireysel yetki sınırı:** MESAM üye iseniz bazı haklar MESAM tarafından kullanılır — `turk-hukuk-legal:meslek-birligi-yetki` ile doğrulayın.
- Çıktının ihtarname formatına çevrilmesi için `/turk-hukuk-legal:ihtarname-fsek-smk`; mahkeme dilekçesi için `/turk-hukuk-legal:dilekce-ihtarname`.

## Cross-skill handoff

- TOS analizi: `/ai-governance-legal:platform-ai-tos-inceleme`
- Marka boyutu: `/ai-governance-legal:ai-uretim-icerik-tespit --smk-marka`
- Noter ihtarnamesi: `/turk-hukuk-legal:ihtarname-fsek-smk`
- FSHHM dava dilekçesi: `/turk-hukuk-legal:dilekce-ihtarname`
- DOCX format: `/turk-hukuk-legal:docx-uretici`
- Süre takibi: otomatik `sure-takipcisi` agent kaydı
