---
name: platform-ai-tos-inceleme
description: >
  Sınır ötesi dijital platformların (Amuse İsveç, Spotify ABD, Apple Music, Epidemic Sound,
  Kobalt, AWAL, YouTube, Meta, X, ChatGPT, Claude, Grok, Gemini, Suno, Udio) Kullanım
  Koşulları / TOS / Sözleşmelerinde yer alan AI ile ilgili klozları VATANDAŞ TÜKETİCİ
  perspektifinden inceler. TKHK m.5 haksız şart, MÖHUK m.26 tüketici lehine yetki ve FSEK
  m.52 yazılı şekil çerçevesinde değerlendirir. Tetikleyiciler: "Spotify TOS değişti",
  "Amuse'da yeni madde gördüm", "ChatGPT şartlarını oku", "bu platform AI eğitimi yapıyor mu",
  "TOS analizi", "kullanıcı sözleşmesi incele", "AI maddesi haksız mı".
argument-hint: "[platform adı veya TOS dosyası, opsiyonel --diff (TOS değişikliği karşılaştır)]"
---

# /platform-ai-tos-inceleme

## Ne zaman çalışır

Bir sınır ötesi platformun TOS / Kullanım Koşulları / Privacy Policy / AI Addendum metnini **tüketici (siz)** perspektifinden incelemek istiyorsanız. Orijinal `vendor-ai-review` skill'inden farkı: oradaki perspektif "biz şirketiz, satıcıdan ne istiyoruz" idi; buradaki perspektif **"ben tüketiciyim, platform bana ne dayatıyor ve buna karşı koruma haklarım neler"**.

## Hukuki çerçeve — üç eksenli inceleme

### Eksen 1: TKHK 6502 — Tüketici Haksız Şart Denetimi

| Madde | Konu | TOS denetimi |
|---|---|---|
| m.3 | Tüketici tanımı | Müzisyen-bireysel platform kullanıcısı tüketici sayılır mı? (KSE'ye dahil değilse evet) |
| m.5 | **Haksız şart** | Tüketicinin korumasından feragat eden tüm klozlar geçersiz |
| m.5/3 | Müzakere edilmemiş şartlar | "Tek tıklamayla kabul" haksız şart varsayımı |
| m.66 | Tüketici hakem heyeti | Parasal sınır altı uyuşmazlıklarda zorunlu |

**Klasik TOS haksız şartları:**
- Tek taraflı değişiklik hakkı (önbildirim ve tüketici fesih hakkı tanınmadan)
- "Tüm dünya hakları, tüm zaman dilimleri, tüm yöntemler" tipi sınırsız mali hak devri
- "Hizmeti istediğimiz zaman, sebep göstermeksizin sonlandırabiliriz"
- "İçerik kaldırma kararımız nihaidir, itiraz yolu yoktur"
- "Verilerinizi geliştirme amacıyla kullanmaya devam edebiliriz"
- "AI eğitim verisi olarak kullanım hakkı yan ürün olarak verilmiştir"

### Eksen 2: MÖHUK — Sınır Ötesi Yetki ve Uygulanacak Hukuk

| Madde | Konu | Uygulama |
|---|---|---|
| m.20 | Sözleşmeye uygulanacak hukuk seçimi | Tarafların seçim hakkı vardır ama **tüketici sınırı** vardır |
| m.21 | Sözleşme yapılma usulü ve geçerliliği | Yerel formalitelere uyumluluk gerekiyorsa Türk hukuku |
| m.26 | **Tüketici sözleşmeleri** | **(1)** Mutad meskenin hukukunun emredici hükümlerinin tanıdığı koruma seviyesinden mahrum bırakılamaz; **(2)** Tüketici, mutad meskeninin mahkemesinde de dava açabilir |
| m.43 | Yetki sözleşmesinin geçerliliği | Tüketici aleyhine yapılan münhasır yetki klozları geçersiz |

**Pratik sonuç:** Amuse İsveç'te kurulu, "Stockholm mahkemeleri münhasıran yetkilidir" demiş olsa bile, Türk tüketici Türkiye'de dava açabilir; uygulanacak hukuk olarak Türk emredici hükümleri lehe ise uygulanır.

### Eksen 3: AİHS m.6 + AYM içtihatı

Etkili başvuru hakkı (AİHS m.6) tüketiciye **erişim adaleti** garantisi verir. Yabancı mahkeme yetki klozu Türk tüketicinin **fiilen** erişimini engelliyorsa (masraf, dil, mesafe) Türk mahkemesi bu klozu **uygulanmaz** sayar — AYM bireysel başvuru ile bu hak korunabilir. AİHM içtihatı (örn. *Naït-Liman v. Switzerland*, B. No. 51357/07) bu konuda yol gösterici.

### Ek eksen — sözleşme bazlı

- **FSEK m.52:** Eserin mali haklarının devri/lisansı **yazılı şekil** + **mali hakların ayrı ayrı sayımı** + **süre/yer/içerik sınırı** gerektirir. "Tek tıkla kabul" TOS'larda bu şartlar tartışmalı.
- **KVKK m.5/1 açık rıza:** "Belirli bir konuya ilişkin, bilgilendirilmiş ve özgür irade ile" — TOS gömülü rıza KVKK Kurul içtihadında zayıf.

## MCP araştırma stratejisi

1. **`hukuk_rag` (BİRİNCİL):** Platform TOS arşivi. Kullanıcının yüklediği versiyonlar burada. Yoksa yükleme talebi.

2. **`mevzuat_mcp`:**
   - TKHK 6502 m.5, m.66
   - MÖHUK m.20, m.26, m.43
   - FSEK m.52, m.42
   - KVKK m.5

3. **`yargi_mcp`:**
   - Yargıtay 13. HD kararları — tüketici haksız şart içtihadı
   - AYM bireysel başvuru — sınır ötesi sözleşme erişim adaleti
   - AİHM emsaller (manuel referans; mevzuat_mcp'de yok)
   - **Önceki sınır ötesi platform davaları** — varsa

4. **`literatur_mcp` + `yoktez_mcp`:** Tüketici hukuku, sınır ötesi tüketici uyuşmazlığı doktrini

## Akış

### Aşama 1 — TOS metin alımı
- Kullanıcı TOS metnini paylaşmış mı? (Yapıştırma, dosya, URL)
- Yoksa hukuk_rag'de versiyon var mı? (Önceden indirilmiş)
- Yoksa kullanıcıya: "Lütfen [platform]'un güncel TOS sayfasından metni indirin ve paylaşın — link: [resmi link]"
- **Kritik:** Sadece İngilizce orijinal TOS okunur; Türkçe tercüme platformun resmi belgesi değildir.

### Aşama 2 — Diff modu (TOS değişikliği)
`--diff` argümanı ile çalıştırılırsa:
- Eski versiyon (hukuk_rag) + yeni versiyon (kullanıcı yüklemesi)
- Madde madde fark çıkar
- **AI ile ilgili klozlardaki** her değişikliği işaretle
- Yeni eklenen AI klozları → "AI eğitim verisi", "machine learning", "model training", "automated systems", "algorithmic decision" anahtarları taranır

### Aşama 3 — Kloz-kloz haksız şart denetimi
TKHK m.5 çerçevesinde her kloz aşağıdaki testlerden geçer:

1. **Müzakere edildi mi?** "Tek tıkla kabul" hayır → haksız şart varsayımı
2. **Tüketici aleyhine dengesizlik yaratıyor mu?** Evet → haksız şart
3. **Açık ve anlaşılır mı?** Hayır → haksız şart (m.5/4)
4. **Yasal asgari hakka aykırı mı?** Evet → haksız şart

### Aşama 4 — AI klozları detay analizi

Aşağıdaki kloz tiplerini özel olarak ara:

| Kloz tipi | Türkçe karşılığı | Hukuki sorun |
|---|---|---|
| "We may use Your Content to train our AI models" | "Verilerinizi AI eğitiminde kullanabiliriz" | FSEK m.52 yazılı şekil + ayrı sayım eksikliği; KVKK m.5 açık rıza yetersizliği |
| "By accepting, you grant a perpetual royalty-free license" | "Kabul ile süresiz telif ücretsiz lisans veriyorsunuz" | FSEK m.52 süre sınırsızlığı problematik; m.51 ileride yapılacak eserler sınırı |
| "We may share aggregated/anonymized data with AI partners" | "Anonim/toplu veriyi AI ortaklarımızla paylaşabiliriz" | KVKK m.28 anonim veri istisnası — gerçekten anonim mi? Yeniden tanımlama riski |
| "Our AI systems may make automated decisions affecting your account" | "AI sistemlerimiz hesabınızla ilgili otomatik karar verebilir" | KVKK m.11/g uyarınca itiraz hakkı tanınmalı |
| "Content removal decisions are final" | "İçerik kaldırma kararlarımız nihaidir" | AB AI Act Art. 50 + KVKK m.11/g aykırı |
| "You waive any class action rights" | "Toplu dava hakkınızdan feragat ediyorsunuz" | TKHK m.5 + Anayasa m.36 |
| "Disputes shall be resolved in [foreign jurisdiction]" | "Uyuşmazlıklar [yabancı] yetkili mahkemede çözülür" | MÖHUK m.26(2) — tüketici Türkiye'de de dava açabilir |
| "Governing law: California / Delaware / Swedish" | "Uygulanacak hukuk: [yabancı]" | MÖHUK m.26(1) — Türk emredici hükümleri korunur |

### Aşama 5 — Aktif aksiyon önerileri

İncelemeden çıkan haksız şartlar için aksiyon menüsü:

1. **Platforma itiraz / opt-out talebi** (yumuşak yol)
2. **KVKK m.13 başvurusu** (kişisel veri boyutu varsa)
3. **Tüketici Hakem Heyeti** (parasal sınır altı)
4. **Tüketici Mahkemesi** (parasal sınır üstü)
5. **Sınır ötesi sözleşme fesih davası** — `/turk-hukuk-legal:sinirostesi-sozlesme-fesih`
6. **Toplu hareket** — diğer kullanıcılarla birlikte; **DUR — bu eklenti tavsiye etmez, hukuki tavsiye gerektirir**

## Çıktı yapısı

```
# KİŞİSEL KULLANIM İÇİN ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR
# Platform: [adı] | TOS versiyonu: [tarih] | Tarih: ../../2026

## ⚠️ Gözden geçirici notu
- Kaynaklar: hukuk_rag [TOS dosya] | mevzuat_mcp TKHK + MÖHUK + FSEK | yargi_mcp Yargıtay 13. HD N karar
- Diff modu: [evet — N değişiklik bulundu / hayır]
- Avukat onayı: tüketici hakem heyeti için gerekli değil; tüketici mahkemesi davası için TAVSİYE EDİLİR

## 1. Platform kimliği
- Ad, hukuki bağlam: [örn. Amuse — Amuse AB, İsveç merkezli]
- Kullanıcı statüsü: tüketici (TKHK m.3) — gerekçe
- Sözleşme tipi: hizmet / lisans / dağıtım / karma

## 2. AI klozları haritası
| Kloz | Metin (özet) | Hukuki sorun | Şiddet |
|---|---|---|---|
| 5.3(a) | "AI eğitim verisi olarak kullanım" | FSEK m.52, KVKK m.5 | 🔴 |
| 7.1 | "Otomatik içerik kaldırma — nihai" | KVKK m.11/g | 🔴 |
| 12.2 | "Stockholm yetkili" | MÖHUK m.26(2) — Türk mahkemesi yetki kabul edebilir | 🟡 |
| ... | ... | ... | ... |

## 3. Haksız şart denetimi (TKHK m.5)
[Madde madde]

## 4. Sınır ötesi yetki analizi (MÖHUK m.26)
- Platform yerleşim ülkesi: [İsveç / ABD / ...]
- Yetki klozu: [metin]
- Türk tüketici davası açabilir mi? — Evet/Hayır + gerekçe
- AİHM/AYM erişim adaleti riski: [değerlendirme]

## 5. Hak ihlali olarak işaretlenen klozlar
- 🔴 Şart X — KVKK m.11/g'ye aykırı — itiraz edilebilir
- 🔴 Şart Y — FSEK m.52'ye aykırı — AI eğitim klozu yazılı şekil + ayrı sayım eksikliği
- 🟠 Şart Z — TKHK m.5(2) — müzakere edilmemiş

## 6. Eylem ağacı
1. [Önerilen] Platforma yazılı opt-out + bilgi talebi → [taslak]
2. KVKK m.13 başvurusu (kişisel veri boyutu) → `/kvkk-veri-itirazi --bilgi-talebi`
3. Eser sahipliği boyutu → `/eserim-ai-training --opt-out-talebi`
4. Tüketici Hakem Heyeti başvurusu → [taslak]
5. Sınır ötesi sözleşme fesih → `/turk-hukuk-legal:sinirostesi-sozlesme-fesih`
6. Sadece arşivle, izle → ai-temas-envanteri'ne kaydet
```

## Karşı argüman önleme

1. **"Sözleşmede yetki klozu var, Türkiye yetkili değil"** → MÖHUK m.26(2); AYM ve AİHM içtihadı erişim adaleti
2. **"Kabul ettiniz, geri dönüş yok"** → TKHK m.5 haksız şart geçersizliği yargısal olarak tespit edilir
3. **"İngilizce metin, anlamamış olabilirsiniz"** → TKHK m.5(4) açıklık ve anlaşılırlık; tüketicinin anlamaması platform aleyhinedir
4. **"Anonim veri kullandık, KVKK kapsam dışı"** → KVKK Kurul içtihadında gerçek anonimleştirme testi sıkı; yeniden tanımlanabilir veri anonim sayılmaz

## Hatalar ve sınırlar

- Platform TOS'larının **gerçek mahkeme uygulaması** ülkeye göre değişir; her ülkenin tüketici koruma seviyesi farklıdır.
- AB üyesi platformlar (Amuse-İsveç, Spotify-İsveç) için GDPR + AB Tüketici Hakları Direktifi paralel uygulanır.
- ABD merkezli platformlar (Apple, Google, Meta) için sınır ötesi icra zordur ama Türk mahkemesi kararı **AB-İsveç-Türkiye New York Sözleşmesi** ve Türkiye-ABD ikili düzenlemeleriyle icra edilebilir; tatbikat zor.
- **Sosyal medya ve plak/yapımcı sözleşmeleri için ek skill:** `/turk-hukuk-legal:sanatci-sozlesme-inceleme`, `/anthropic-skills:swedish-music-law` (İsveçli platform için)

## Cross-skill handoff

- KVKK boyutu: `/ai-governance-legal:kvkk-veri-itirazi`
- Eser sahipliği boyutu: `/ai-governance-legal:eserim-ai-training`
- Otomatik karar boyutu: `/ai-governance-legal:otomatik-karar-itirazi`
- Genel sözleşme analizi: `/turk-hukuk-legal:sozlesme-inceleme`
- Sanatçı sözleşmesi özel: `/turk-hukuk-legal:sanatci-sozlesme-inceleme`
- İsveç şirketleri için: `/anthropic-skills:swedish-music-law`
- Sınır ötesi fesih stratejisi: `/turk-hukuk-legal:sinirostesi-sozlesme-fesih`
- TOS değişikliği watcher: `tos-degisiklik-watcher` agent (haftalık otomatik)
