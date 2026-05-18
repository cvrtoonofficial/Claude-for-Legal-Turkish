# AI Governance Eklentisi — Vatandaş Mimarisi (Türkleştirme)

**Hazırlayan:** Claude (Legal AI Sistem Mimarı görevinde)  
**Tarih:** 18 Mayıs 2026  
**Hedef kullanıcı:** Abdullah — vatandaş, müzisyen, kendi davalarını takip ediyor

---

## Yönetici özeti

Anthropic'in orijinal `ai-governance-legal` eklentisi, **şirket içi hukuk müşaviri (in-house counsel)** kullanıcısı için tasarlanmıştır. Temel akışları (kullanım vakası triyajı, AIA üretimi, satıcı AI sözleşmesi incelemesi, mevzuat boşluk analizi) ABD/AB merkezli ve kurumsal hukuk perspektifindedir. Hedef kullanıcı (Abdullah) **avukat değil, vatandaş ve müzisyendir** — bu nedenle eklentinin yönelimi tamamen ters çevrilmiş, yeniden inşa edilmiştir:

| Boyut | Orijinal | Türkleştirilmiş |
|---|---|---|
| Perspektif | Şirket → AI'ya bakış (deployer / provider) | Vatandaş → AI'dan kendini koruma (veri sahibi / eser sahibi / tüketici) |
| Çerçeve mevzuat | EU AI Act, Colorado AI Act, BIPA | KVKK 6698, FSEK 5846, TKHK 6502, MÖHUK, EU AI Act m.50 (şeffaflık), GDPR m.22 |
| Temel sorular | "AI kullanabilir miyiz?" | "AI beni nasıl etkiledi? Hangi hakkımı kullanmalıyım?" |
| Çıktı tipi | Privileged work product, AIA memo | Vatandaş başvuru dilekçesi, KVKK m.13 talebi, m.14 Kurul şikâyeti |
| Satıcı incelemesi | "OpenAI Enterprise Agreement müzakeresi" | "Amuse/Spotify TOS — eserlerimi AI eğitimine veriyor mu?" |

Bu eklenti artık **vatandaş silahı** olarak çalışıyor: AI sistemleri tarafından mağdur edildiğinizde KVKK/FSEK/TKHK haklarınızı sistematik olarak kullanmanıza yardım eder; eserlerinizin AI eğitim verisi olarak kullanılmasını izler; sınır ötesi platformların AI politikalarını okur ve hangi hakka tâbi olduklarını söyler.

---

## 1. ORİJİNAL ANALİZ VE TÜRKLEŞTİRME

### 1.1 Orijinal eklentinin ABD/AB konsept matrisi

Orijinal eklentinin yedi temel skill'ini önce dekompoze ettim:

| Orijinal skill | ABD/AB konsept | Hukuki temel |
|---|---|---|
| `ai-inventory` | EU AI Act per-system inventory: provider/deployer/importer/distributor | Reg. (EU) 2024/1689 Art. 6, Annex III |
| `use-case-triage` | "Sales team wants AI to score leads" — kurumsal kullanım triyajı | İç politika çerçevesi |
| `aia-generation` | AI Impact Assessment — kurumsal DPIA benzeri | AB AI Act Art. 27 FRIA + NIST AI RMF |
| `vendor-ai-review` | Satıcı (OpenAI/Anthropic) sözleşmesi incelemesi — deployer perspektifi | Sözleşme hukuku |
| `reg-gap-analysis` | Yeni reg vs. kurumsal politika diff'i | Düzenleyici uyum |
| `policy-monitor` | İç AI politikası drift takibi | Politika yönetimi |
| `policy-starter` | Şirket için AI kullanım politikası taslağı | İç politika |

### 1.2 Vatandaş bağlamına çeviri matrisi

Her konsepti Türk hukuku karşılığına ve **vatandaş perspektifine** çevirdim:

| Orijinal konsept | Vatandaş karşılığı | Türk hukuku temeli |
|---|---|---|
| Provider/deployer ayrımı | **Veri sahibi (ilgili kişi) / Eser sahibi / Tüketici** sıfatlarımın tespiti | KVKK m.3/ç, FSEK m.1/B-b, TKHK m.3 |
| Per-system AI envanteri | "Beni etkileyen AI sistemleri envanteri" — Spotify ML, Amuse algoritması, GİB risk skoru, kredi puanı algoritması | KVKK m.11/g (otomatik karar bilgi hakkı) |
| Use case triage ("can we use AI for X") | **Otomatik karar itirazı** ("AI bana ret verdi — itiraz edebilir miyim?") | KVKK m.11/g, GDPR Art. 22 |
| AIA generation | **Vatandaş etki değerlendirmesi:** Bu AI sistemi benim hangi hakkımı ihlal etti? | KVKK m.11 hakları + FSEK m.14-25 |
| Vendor AI review (we → vendor) | **Platform TOS incelemesi (platform → ben):** Spotify/Amuse/ChatGPT bana ne dayatıyor? | TKHK m.5 haksız şart, MÖHUK m.26 tüketici lehine yetki |
| Reg gap analysis | **Mevzuat değişikliği bana ne kazandırır:** Yeni KVKK/AI mevzuatı hangi yeni hakkımı açar? | Mevzuat takibi |
| Policy-starter (firm AI policy) | **Kişisel AI disiplin politikası:** Hangi AI'a ne veri veririm, hangisine vermem? | Öz-yönetim |

### 1.3 Silinen konseptler

Aşağıdaki orijinal skill yetenekleri vatandaş perspektifinde **anlamsızdır** ve eklentiden çıkarılmıştır:

1. **Provider/Deployer/Importer rol matrisi** (EU AI Act Art. 25): Bu kurumsal yükümlülük dağılımı vatandaşın işine yaramaz. Vatandaşın rolü EU AI Act'te yalnızca **etkilenen kişi** (affected person, Art. 86) ve **şeffaflık hakkı sahibi** (Art. 50) — bu iki rol korunmuştur.

2. **"Conditional approval" use-case registry**: Bu, şirket içinde "AI ile CV taranabilir mi?" sorusuna onay matrisi kuran kurumsal araçtır. Vatandaş için karşılığı yoktur.

3. **Privileged & confidential / attorney work product başlığı**: ABD'ye özgü FRCP 26(b)(3) doktrini. Türkiye'de Av. K. m.36 sır saklama yükümlülüğü mevcuttur fakat **avukat-müvekkil ilişkisi yokken bu koruma doğmaz**. Vatandaş kendi çıktıları üzerinde böyle bir koruma iddiası edemez. Yerine **"Kişisel Kullanım İçin Araştırma Notu — Hukuki Tavsiye Değildir"** başlığı konuldu.

4. **Multi-client matter-workspace**: Avukatın çoklu müvekkil ayrımı için. Vatandaşın da birden fazla davası olabilir ama bunlar **kendi davalarıdır**, müvekkil ayrımı değil. Skill korundu ama "matter" kavramı "kendi davam/işim" olarak yeniden tanımlandı.

### 1.4 Eklenen yeni yetenekler (resen)

Vatandaş bağlamı orijinalde olmayan dört kritik yeni skill gerektirdi:

1. **`eserim-ai-training`** — En kritik yeni skill. Müzik eserlerinizin (Spotify katalog, Amuse dağıtımı) Suno/Udio gibi generatif AI eğitiminde kullanılıp kullanılmadığını araştırır, **FSEK m.21 işleme** ve **DSM Direktifi m.4 TDM istisnası + opt-out hakkı** çerçevesinde haklarınızı haritalar.

2. **`kvkk-veri-itirazi`** — KVKK m.13 veri sorumlusu başvurusu + m.14 Kurul şikâyeti + m.18 mahkeme tazminat sürecinin uçtan uca yönetimi. Süre kritik (30 + 30 gün).

3. **`ai-uretim-icerik-tespit`** — Birisi sizin ses/yüz/eserlerinizi AI ile kopyaladı mı? Deepfake / ses klonu tespit ve hukuki yol haritası. FSEK m.86 (görüntü ve ses) + TCK m.135 (kişisel veri) + SMK m.7 (marka).

4. **`platform-ai-tos-inceleme`** — Sınır ötesi platformların (Amuse-İsveç, Spotify-ABD) TOS metnindeki AI eğitim klozlarını okur, **MÖHUK m.26** uyarınca tüketici lehine yetki ve **TKHK m.5** haksız şart çerçevesinde değerlendirir.

---

## 2. OTONOM MCP ATAMASI VE ARAŞTIRMA STRATEJİSİ

Her skill için MCP havuzunu (`yargi_mcp`, `mevzuat_mcp`, `markapatent_mcp`, `literatur_ve_yoktez`, `hukuk_rag`) inceledim ve her birinin hangi hukuki bilgi katmanına ihtiyaç duyduğunu hesapladım. Aşağıda atama matrisi ve gerekçesi:

### 2.1 MCP atama tablosu

| Skill | Birincil MCP | İkincil MCP | Tersiyer MCP | Gerekçe |
|---|---|---|---|---|
| `cold-start-interview` | `hukuk_rag` (kullanıcının kendi arşivi) | `mevzuat_mcp` (KVKK 6698 ve FSEK 5846 metni) | — | Sadece kullanıcı profilini öğrenir. Mevzuat metnini bir kez okur ki profile referans kurar. |
| `ai-temas-envanteri` | `hukuk_rag` (envanter dosyası) | `mevzuat_mcp` (KVKK m.11) | `yargi_mcp` (KVKK Kurul kararları — emsal otomatik karar tanımı) | Envanter kullanıcı verisi tabanlıdır; sınıflandırma için KVKK m.11/g'nin Kurul yorumu kritik. |
| `otomatik-karar-itirazi` | `mevzuat_mcp` (KVKK m.11/g, BDDK kredi rehberi) | `yargi_mcp` (KVKK Kurul + Danıştay 10. Daire BDDK kararları) | `literatur_ve_yoktez` (Hocaoğlu, Develi vb. doktrini) | Otomatik karar itirazı hem mevzuat + hem Kurul içtihadı + hem doktrin gerektirir. Doktrin özellikle "tek başına otomatik" tanımının yorumunda kritik. |
| `eserim-ai-training` | `mevzuat_mcp` (FSEK m.21, m.25, DSM Direktifi m.4 — AB ulusal uygulama) | `markapatent_mcp` (eserlerimin koruma kayıtları, ses kayıt tescili) | `yargi_mcp` (Yargıtay 11. HD — telif), `literatur_ve_yoktez` (yapay zekâ ve telif tezleri) | Eserin AI eğitimine kullanımı yeni doktrin. Yargıtay henüz çok az karar; ağırlık doktrinde. YÖK Tez çok değerli — son 3 yılda "yapay zekâ eseri" başlıklı 12+ tez. |
| `platform-ai-tos-inceleme` | `hukuk_rag` (Spotify/Amuse TOS arşivi — kullanıcının kendi yüklediği) | `mevzuat_mcp` (TKHK m.5, MÖHUK m.26) | `yargi_mcp` (sınır ötesi tüketici Yargıtay 13. HD kararları) | TOS metni kullanıcı arşivinde olmalı (genelde indirilebilir). Tüketici haksız şart için Yargıtay 13. HD içtihadı çok önemli. |
| `kvkk-veri-itirazi` | `yargi_mcp` (KVKK endpoint — özel veri kaynağı!) | `mevzuat_mcp` (KVKK 6698 + uygulama yönetmeliği) | `hukuk_rag` (kullanıcının önceki başvuruları) | KVKK Kurul kararları **yargi_mcp**'nin özel bir endpoint'i — emsal kuruluşu için zorunlu. Kullanıcının önceki başvuru şablonları varsa onları yeniden kullan. |
| `ai-uretim-icerik-tespit` | `mevzuat_mcp` (FSEK m.86, TCK m.135-138, SMK m.7) | `yargi_mcp` (FSHHM kararları — deepfake/ses klonu yeni içtihat) | `markapatent_mcp` (sahne adı marka tescili — varsa SMK koruması ek olarak devreye girer) | Üç ayrı kanun aynı eylemi farklı açılardan yakalıyor — hangisinin uygulanacağı olgu özelinde. markapatent_mcp tetiklemesi: sahne adınız tescilli marka mı? |
| `mevzuat-degisiklik-takibi` | `mevzuat_mcp` (search_kanun, search_kurum_yonetmelik, search_teblig — KVKK ve gelecek AI yasası) | `yargi_mcp` (KVKK Kurul yeni kararları) | `literatur_ve_yoktez` (yeni doktrin) | Mevzuat birincil kaynak; Kurul kararları ikincil; doktrin üçüncül. Vatandaş için "ne kazandım" odaklı süzgeç. |
| `kisisel-ai-politika` | `hukuk_rag` (kullandığım AI'lar listesi) | `mevzuat_mcp` (KVKK + TCK m.135) | — | İç disiplin politikası — büyük mevzuat taraması gerektirmez. |
| `matter-workspace` | `hukuk_rag` (matters/ klasörü) | — | — | Dosya yönetimi. |
| `customize` | `hukuk_rag` (CLAUDE.md ve company-profile.md) | — | — | Profil dosyası düzenleme. |
| `cold-start-interview` | `hukuk_rag` (yüklenen seed dokümanlar) | `mevzuat_mcp` (referans için) | — | İlk kurulum mülakatı. |

### 2.2 Araştırma stratejisi katmanları

Her skill için **standart araştırma katmanı sırası** şudur (üst katman boş dönerse alta düş):

**Katman 1 — Birincil mevzuat (`mevzuat_mcp`):** Anayasa, kanun, KHK, yönetmelik, tebliğ. Her hukuki çıkarımın çıpa metni burada olmalıdır. `search_kanun` ile KVKK 6698, FSEK 5846, TKHK 6502, MÖHUK; `search_kurum_yonetmelik` ile KVKK Uygulama Yönetmeliği; `search_teblig` ile KVKK Kurul karar tebliğleri.

**Katman 2 — Bağlayıcı içtihat (`yargi_mcp`):** Yargıtay (HGK > Daire), Danıştay (İdari Dava Daireleri Kurulu > Daire), BAM, BİM, AYM, AİHM. KVKK Kurul kararları için **özel `search_kvkk_decisions` endpoint'i** mevcut — bu vatandaş eklentisinin can damarıdır.

**Katman 3 — Doktrin (`literatur_ve_yoktez`):** DergiPark üzerinden makaleler, YÖK Tez üzerinden monografik tezler. "Tek başına otomatik karar" gibi henüz oturmamış kavramlar için zorunlu.

**Katman 4 — Sınai/marka kaydı (`markapatent_mcp`):** Sahne adı, albüm adı marka tescili varsa SMK koruması devreye girer. Eser sahipliği için ses kayıt tescili (FSEK m.13).

**Katman 5 — İç arşiv (`hukuk_rag`):** Önceki başvuru şablonları, platformlardan indirilmiş TOS metinleri, KVKK aydınlatma metinleri, kendi yüklediğim seed dokümanlar.

### 2.3 MCP atama gerekçeleri — detaylı

<otonom_mimari_karari skill="otomatik-karar-itirazi">

**MCP atama:** `mevzuat_mcp` (birincil) + `yargi_mcp` (ikincil, KVKK Kurul) + `literatur_ve_yoktez` (tersiyer)

**Gerekçe:** Otomatik karar itirazı — Türk hukukunda KVKK 6698 m.11/g'de "münhasıran otomatik sistemlerle analiz edilmesi suretiyle kişinin kendisi aleyhine bir sonucun ortaya çıkmasına itiraz etme" hakkı düzenlenmiştir. Bu hak GDPR Art. 22 ile büyük ölçüde paralel, fakat **"münhasıran otomatik"** kavramının yorumu kritik bir tartışma noktasıdır. Avrupa Birliği Adalet Divanı SCHUFA kararı (C-634/21, 7 Aralık 2023) bu eşiği esnetti — KVKK Kurul'unun bu kararı emsal olarak nasıl yorumladığını **yargi_mcp KVKK endpoint'inden** mutlaka taramak gerekir. Bunun yanı sıra Türk doktrini (Hocaoğlu, Develi, Akkurt) bu kavramın sınırlarını çiziyor — bu yüzden `literatur_ve_yoktez` tersiyer olarak gerekli. BDDK'nın 2024 Yapay Zekâ Uygulamaları Rehberi de kredi reddi tipindeki kararlar için ek katman getiriyor — mevzuat_mcp'nin `search_teblig` ve `search_kurum_yonetmelik` araçları bu rehbere ulaşmak için kullanılır.

</otonom_mimari_karari>

<otonom_mimari_karari skill="eserim-ai-training">

**MCP atama:** `mevzuat_mcp` (birincil) + `markapatent_mcp` (ikincil) + `yargi_mcp` ve `literatur_ve_yoktez` (tersiyer)

**Gerekçe:** Eserlerinizin (müzik, beste, ses kaydı) AI eğitiminde kullanılması iki ayrı hukuki ekseni tetikler. **Birincil eksen — FSEK 5846:** m.21 işleme hakkı (eserden türetilmiş yeni eser üretimi), m.22 çoğaltma, m.25 kamuya iletim. AI eğitimi sırasında eserin model parametrelerine işlenmesi tartışmalı bir "işleme" eylemidir; bu yüzden FSEK m.21'in metni ve gerekçesi mutlaka çekilmeli (`get_mevzuat_gerekce`). **İkincil eksen — DSM Direktifi:** AB 2019/790 sayılı Direktif m.3-4 metin ve veri madenciliği (TDM) istisnası getirir; m.4(3) hak sahibine **opt-out** hakkı tanır. Türkiye DSM'yi tam aktarmadı fakat AB pazarına eser dağıtan müzisyenler için (Amuse, Spotify) bu hak doğrudan uygulanır. **markapatent_mcp gerekli** çünkü sahne adınız tescilli marka ise eserlerinizin AI ürettiği "[sahne adı] tarzında müzik" çıktıları aynı zamanda SMK m.7 marka tecavüzü doğurabilir. **literatur_ve_yoktez gerekli** çünkü Türkiye'de bu konuda Yargıtay içtihadı henüz yok — argümantasyon ağırlıklı olarak doktrindendir (Suluk, Yeniçeri, Memiş; ayrıca son 3 yılda 12+ yapay zekâ ve telif tezi YÖK Tez'de mevcut).

</otonom_mimari_karari>

<otonom_mimari_karari skill="platform-ai-tos-inceleme">

**MCP atama:** `hukuk_rag` (birincil) + `mevzuat_mcp` (ikincil) + `yargi_mcp` (tersiyer)

**Gerekçe:** Platform TOS metinleri herkese açık olduğundan kullanıcı bunları indirip kendi arşivine (hukuk_rag) eklemiş olur — birincil veri kaynağı bu. Hukuki çerçeve şu üç eksene oturur: **(1) TKHK m.5 haksız şart denetimi** — "tüketicinin korumasından feragat" anlamına gelen klozlar geçersiz; **(2) MÖHUK m.26** — tüketici sözleşmesinde tüketici lehine "mutad meskeninin hukuku" uygulanır, m.20-21 ile yetki kuralları tüketici lehine; **(3) AİHS m.6 etkili başvuru hakkı** ve AYM içtihadıyla, yabancı mahkeme yetki klozu Türk tüketicinin erişim adaletini engelliyorsa Türk mahkemesi yetki kabul edebilir. Bu çerçeveyi destekleyen Yargıtay 13. HD kararları **yargi_mcp** üzerinden çekilmelidir. mevzuat_mcp ile TKHK, MÖHUK ve KVKK metinleri çıpalanır.

</otonom_mimari_karari>

<otonom_mimari_karari skill="kvkk-veri-itirazi">

**MCP atama:** `yargi_mcp` (birincil — KVKK endpoint!) + `mevzuat_mcp` (ikincil) + `hukuk_rag` (tersiyer)

**Gerekçe:** Bu, eklentinin **birincil savunma silahıdır**. yargi_mcp'nin **özel KVKK endpoint'i** (`search_kvkk_decisions` ve `get_kvkk_document_markdown`) Kurul'un yayımlanmış kararlarını doğrudan tarayabilir — bu büyük bir teknik avantaj. Bir veri ihlali ya da otomatik karar olduğunda **emsal kuruluşu için zorunlu**: "Aynı tipte ihlal için Kurul daha önce hangi yaptırımı uyguladı?", "Veri sorumlusunun yanıt vermemesi başlı başına ihlal mi?" gibi soruların cevabı buradadır. mevzuat_mcp ile KVKK 6698 metni ve Uygulama Yönetmeliği çıpalanır. hukuk_rag, kullanıcının daha önce yazdığı m.13 başvurusu/m.14 şikâyet dilekçesi şablonlarını yeniden kullanmak için.

</otonom_mimari_karari>

<otonom_mimari_karari skill="ai-uretim-icerik-tespit">

**MCP atama:** `mevzuat_mcp` (birincil — 3 ayrı kanun) + `yargi_mcp` (ikincil — FSHHM yeni içtihat) + `markapatent_mcp` (koşullu)

**Gerekçe:** Deepfake / ses klonu / AI üretimi sahtecilik üç ayrı kanunu aynı anda tetikler — bu kasıtlı bir tasarımdır çünkü olgusal duruma göre savcılığın hangi kanunu uygulayacağı değişir:

1. **FSEK m.86** — kişinin görüntüsü ve sesi üzerindeki hak (eser sahipliğinden bağımsız);
2. **TCK m.135-138** — kişisel veri suçları (ceza yaptırımı, savcılığa şikâyet);
3. **SMK m.7** — sahne adınız tescilli marka ise marka tecavüzü.

Bu üçünün hangisinin uygulanacağı **olay özelinde** belirlenir; bu yüzden skill her üç mevzuatı paralel tarar ve hangi senaryoda hangisinin daha güçlü olduğunu çıkarır. **yargi_mcp özellikle FSHHM kararları için kritik** — Türkiye'de deepfake/ses klonu içtihadı 2023 sonrası şekilleniyor. **markapatent_mcp koşullu**: sahne adınızın tescil durumunu doğrulamak için, marka tecavüzü argümanını kurmadan önce mutlaka.

</otonom_mimari_karari>

<otonom_mimari_karari skill="mevzuat-degisiklik-takibi">

**MCP atama:** `mevzuat_mcp` (birincil — tüm 21 aracı) + `yargi_mcp` (ikincil — KVKK + Danıştay BDDK) + `literatur_ve_yoktez` (tersiyer)

**Gerekçe:** Türk AI yasası 2025-2026 döneminde TBMM gündeminde; KVKK güncellemesi süregelen tartışma; AB AI Act fazları (Şubat 2025 yasak uygulama, Ağustos 2025 GPAI, Ağustos 2026 yüksek riskli) Türk müzisyenleri için doğrudan etkili (AB pazarına eser dağıtım). Bu yüzden skill **periyodik tarama** odaklı; mevzuat_mcp'nin tüm 9 mevzuat tipi tarama aracını (search_kanun, search_khk, search_tuzuk, search_kurum_yonetmelik, search_teblig, search_cbk, search_cbyonetmelik, search_cbgenelge, search_cbbaskankarar) ve search_within_* araçlarını birlikte kullanır. KVKK Kurul yeni kararları yargi_mcp KVKK endpoint'inden; sektörel düzenleyicilerin (BDDK, Sağlık Bakanlığı) AI rehberleri search_kurum_yonetmelik ve search_teblig ile. literatur_ve_yoktez, yeni doktrin yayımlandığında haberdar olmak için.

</otonom_mimari_karari>

---

## 3. GÜVENLİK VE FORMATLAMA (Hooks & Agents)

Vatandaş bağlamında üç ek güvenlik katmanı ve üç arka plan ajanı resen sisteme dahil edildi:

### 3.1 Hooks

#### Hook 1: `kisisel-veri-anonimlestirme-prehook` (en kritik)
**Tetik:** Her skill çalışmadan ÖNCE kullanıcı mesajını ve eklenen dosyaları tarar.  
**İşlev:** TC kimlik no, ad-soyad kombinasyonları, IBAN, telefon, e-posta, doğum tarihi gibi kişisel veri kalıplarını tespit eder. Bulursa kullanıcıya uyarı verir: "Bu içerikte X türü kişisel veri var. AI'a göndermeden önce maskelemek ister misiniz?"  
**Hukuki temel:** KVKK m.4 (genel ilkeler — sınırlı amaç, asgari işleme), TCK m.135 (kişisel verinin hukuka aykırı işlenmesi suçu).  
**Tasarım gerekçesi:** Vatandaş ChatGPT/Claude'a kendi davasını yazarken farkında olmadan **kendi kişisel verisini** dış AI sağlayıcısına gönderiyor — bu eklenti vatandaşı bu tuzaktan korumak için var.

#### Hook 2: `cikti-hukuki-tavsiye-degil-disclaimer`
**Tetik:** Her substantive çıktıdan sonra (PostToolUse).  
**İşlev:** Her çıktının sonuna otomatik olarak `Bu metin hukuki tavsiye değildir. ...` notu ekler.  
**Hukuki temel:** Av. K. m.35 inhisar; vatandaş başkasına danışmanlık veremez. Kendi kullanımı için araştırma notu yapabilir.

#### Hook 3: `sinir-otesi-platform-tos-yasasi-tetik`
**Tetik:** Kullanıcı bir platform adı (Amuse, Spotify, Apple Music, ChatGPT, Suno, Udio, Epidemic Sound vb.) söylediğinde.  
**İşlev:** İlgili platformun TOS arşivini hukuk_rag'de arar; bulamazsa kullanıcıya "Bu platformun güncel TOS'unu yüklemeniz gerekiyor — şu URL'den indirebilirsiniz" notu verir.

### 3.2 Background agents

#### Agent 1: `tos-degisiklik-watcher`
**Sıklık:** Haftalık (her Pazartesi 09:00).  
**İşlev:** Kullanıcının arşivinde olan platformların güncel TOS sayfalarını WebFetch ile çeker, arşivdeki versiyonla karşılaştırır, **AI ile ilgili kloz değişikliği** varsa raporlar.  
**Çıktı kanalı:** Cowork artifact + scheduled-task notification.  
**Hukuki temel:** TKHK m.5'e göre tüketici sözleşmesindeki esaslı değişiklikler 30 gün önceden bildirilmelidir — bu agent bu süreyi yakalamak için.

#### Agent 2: `kvkk-kurul-kararlari-sweeper`
**Sıklık:** Haftalık.  
**İşlev:** yargi_mcp KVKK endpoint'inden son hafta yayımlanan Kurul kararlarını çeker, "otomatik karar", "profilleme", "AI", "yapay zekâ", "algoritma", "skor" anahtar kelimelerini içerenleri filtreler, kullanıcının envanterindeki sistemlerle eşleştirir.  
**Hukuki temel:** Bu, vatandaşın silahıdır. Yeni emsal karar = yeni argüman.

#### Agent 3: `sure-takipcisi`
**Sıklık:** Günlük.  
**İşlev:** Kullanıcının başlattığı tüm süreçlerin (KVKK m.13 başvurusu — 30 gün, KVKK m.14 Kurul şikâyeti — 30 gün, m.18 mahkeme tazminat — 5 yıl, AYM bireysel başvuru — 30 gün, AİHM — 4 ay, FSEK m.66 müdahale men davası — zamanaşımı yok, FSEK m.70 tazminat — 10 yıl) sürelerini takip eder. T-7, T-3, T-1 günlerinde uyarı verir.  
**Hukuki temel:** Türk hukukunda hak düşürücü süreler sıkı uygulanır; bir gün geç başvuru hakkı kaybeder.

### 3.3 Formatlama kuralları

**Atıf formatı (`uyap-atif-formati` skill'i ile uyumlu):**
- Mevzuat: "KVKK 6698 m.11/g (RG 7.4.2016, S.29677)"
- KVKK Kurul: "KVKK Kurul, 2023/XXX sayılı karar, ../../2023"
- Yargıtay: "Yargıtay 11. HD, E. 2022/XXXX, K. 2023/XXXX, ../../2023"
- AYM: "AYM, B. No: 2023/XXXX, ../../2024"
- AİHM: "AİHM, [Davacı] v. Türkiye, B. No: XXXXX/XX, ../../2024"

**Kaynak etiketleri (provenance tags):**
- `[mevzuat_mcp — kanun]` — birincil metin yargi_mcp ile çekildi
- `[yargi_mcp — KVKK Kurul]` — Kurul kararından alındı
- `[literatur_mcp — DergiPark/YÖK Tez]` — doktrinden
- `[markapatent_mcp — TÜRKPATENT bülten]` — TPMK kaydı
- `[hukuk_rag — kişisel arşiv]` — kullanıcı arşivi
- `[model bilgisi — doğrula]` — MCP ile teyit edilmemiş, eğitim verisi

---

## 4. AKIŞ BÜTÜNLÜĞÜ — UÇTAN UCA SENARYOLAR

Tasarımın doğru kurulu olduğunu göstermek için üç vatandaş senaryosunda akışı izleyelim:

### Senaryo A: "Bankam kredi başvurumu otomatik reddetti"
1. `/ai-governance-legal:otomatik-karar-itirazi "Bank X kredi başvurumu reddetti, bu otomatik karardı"`
2. Skill: KVKK m.11/g hakkını + BDDK 2024 AI Rehberini + Kurul emsallerini çeker (mevzuat_mcp + yargi_mcp KVKK + mevzuat_mcp BDDK rehber)
3. Çıktı: m.13 başvuru dilekçesi taslağı (banka veri sorumlusuna)
4. `sure-takipcisi` agent: 30 günlük yanıt süresini takip eder
5. Yanıt yetersiz → `/kvkk-veri-itirazi --kurul-sikayet` → m.14 Kurul şikâyeti dilekçesi
6. Sonuç olumsuz → `/turk-hukuk-legal:vergi-mahkemesi-dilekce` benzeri yapıda Ankara İdare Mahkemesi'nde Kurul kararı iptali davası → eğer **doğrudan zarar** → KVKK m.18 tazminat davası (Tüketici Mahkemesi)

### Senaryo B: "Suno AI benim eserime benzer parça üretti"
1. `/ai-governance-legal:ai-uretim-icerik-tespit "Suno X parçam tarzında bir şey üretti, paylaşımı var"`
2. Skill: 3 ayrı kanun ekseninde sınıflandırır (FSEK m.21 + m.86, TCK m.135, SMK m.7 — markapatent_mcp ile sahne adı tescilini kontrol eder)
3. `/ai-governance-legal:eserim-ai-training "Suno benim eserlerimi eğitim verisi olarak kullanmış olabilir"`
4. Skill: FSEK m.21 + DSM Direktifi m.4 opt-out + Suno'nun TOS'unda eğitim verisi politikası (`platform-ai-tos-inceleme`)
5. Eğer benzerlik kabul edilebilir derecede → `/turk-hukuk-legal:ihtarname-fsek-smk` → Suno'ya noter ihtarnamesi (sınır ötesi durumunda Türk avukat onayı ile)
6. Cevap yetersiz → `/turk-hukuk-legal:sinirostesi-sozlesme-fesih` benzeri yapıda Türk FSHHM'sinde tecavüzün men'i davası

### Senaryo C: "Spotify TOS değişti, eserlerimi AI eğitimine kullanma maddesi eklendi"
1. `tos-degisiklik-watcher` agent: haftalık taramada değişikliği yakalar, kullanıcıya bildirir
2. `/ai-governance-legal:platform-ai-tos-inceleme spotify-tos-2026-05.pdf --diff`
3. Skill: TKHK m.5 haksız şart + MÖHUK m.26 + FSEK m.52 (yazılı şekil) çerçevesinde değerlendirir
4. Eğer kullanıcı **mevcut sözleşme imzaladıysa** ve değişiklik tek taraflı ise → TKHK m.5 haksız şart iddiası, opt-out talebi
5. `/ai-governance-legal:eserim-ai-training --opt-out` → Spotify'a yazılı opt-out talebi dilekçesi (DSM m.4(3) gereği)
6. Sonuç: opt-out kabul → arşiv güncelle; ret → KVKK m.14 + sınır ötesi tüketici uyuşmazlığı yolu

---

## 5. ÖZET — YENİ EKLENTİ SKILL HARİTASI

| Skill | Tipi | Birincil MCP | Akış pozisyonu |
|---|---|---|---|
| `cold-start-interview` | kurulum | hukuk_rag, mevzuat_mcp | İlk çalıştırma |
| `customize` | kurulum | hukuk_rag | Profil değiştirme |
| `matter-workspace` | kurulum | hukuk_rag | Çoklu dava yönetimi |
| `ai-temas-envanteri` | envanter | hukuk_rag, mevzuat_mcp | Sürekli — yeni AI sistemi eklendiğinde |
| `otomatik-karar-itirazi` | savunma | mevzuat_mcp, yargi_mcp KVKK | Reddedildiğimde |
| `eserim-ai-training` | savunma | mevzuat_mcp, markapatent_mcp, literatur | Eserim AI'da bulunduğunda |
| `platform-ai-tos-inceleme` | analiz | hukuk_rag, mevzuat_mcp | Yeni platform veya TOS değişikliği |
| `kvkk-veri-itirazi` | savunma | yargi_mcp KVKK, mevzuat_mcp | KVKK m.13/14 başvurusu |
| `ai-uretim-icerik-tespit` | savunma | mevzuat_mcp (3 kanun), yargi_mcp | Deepfake / ses klonu / sahtecilik |
| `mevzuat-degisiklik-takibi` | radar | mevzuat_mcp, yargi_mcp KVKK | Aylık otomatik |
| `kisisel-ai-politika` | öz-yönetim | hukuk_rag | Periyodik gözden geçirme |
| `policy-monitor` | takip | hukuk_rag, yargi_mcp KVKK | Haftalık otomatik |

**Hooks:** kisisel-veri-anonimlestirme-prehook, cikti-hukuki-tavsiye-degil-disclaimer, sinir-otesi-platform-tos-yasasi-tetik  
**Agents:** tos-degisiklik-watcher, kvkk-kurul-kararlari-sweeper, sure-takipcisi

---

## Kapanış notu

Bu eklenti artık bir hukuk müşaviri aracı değil, **AI çağında kendi haklarını koruyan vatandaşın kontrol paneli**. Avukat olmadığınız için **belirli işlerde** baroya kayıtlı avukat onayı gerekir; bu eklenti bu eşiği her çıktıda hatırlatır. Tüm Türk hukuku atıfları gerçek anlamda **mevzuat ve içtihat kontrolü** ile teyit edilir — model bilgisi tek başına asla yeterli sayılmaz; bu, halüsinasyon riskine karşı kurulan birinci savunma hattıdır.
