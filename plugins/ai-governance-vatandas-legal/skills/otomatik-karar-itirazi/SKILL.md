---
name: otomatik-karar-itirazi
description: >
  Bir AI sistemi sizin aleyhinize karar verdiğinde (kredi reddi, sigorta reddi, sosyal medya
  hesap kapatma, plaka tanıma cezası, vize reddi, içerik kaldırma, hesap askıya alma vb.)
  KVKK m.11/g uyarınca otomatik karar itirazı sürecini başlatır ve dilekçe taslağı üretir.
  Tetikleyiciler: "AI beni reddetti", "otomatik karar geldi", "kredim reddedildi", "hesabım
  kapandı", "AI bana ceza yazdı", "algoritmik karara itiraz", "neden bu kararı verdiler bilmiyorum".
argument-hint: "[karar tipi, veren kurum/platform — örn. 'Bank X kredi reddi']"
---

# /otomatik-karar-itirazi

## Ne zaman çalışır

Bir veri sorumlusu (banka, sigorta şirketi, sosyal medya platformu, kamu kurumu, internet servis sağlayıcı, hatta İçişleri Bakanlığı plaka tanıma sistemleri) sizin aleyhinize **AI/algoritmik karar** vermişse — ve siz bu kararın **mantığını öğrenmek, itiraz etmek veya iptal ettirmek** istiyorsanız.

## Hukuki temel ve eşik

**Birincil hak:** KVKK 6698 m.11/g — *"Kişinin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle aleyhine bir sonucun ortaya çıkmasına itiraz etme."* `[mevzuat_mcp]`

**Eşik testi — "münhasıran otomatik" mi?**

Bu kavram tartışmalıdır. Skill aşağıdaki testi uygular:

1. **Tam otomatik (eşik karşılanır):** Karar tamamen algoritma çıktısı; insan denetimi yok veya semboliktir (rubber-stamping). Banka kredi skoru otomatik reddi tipik örnektir.
2. **Hibrit (eşik tartışmalı):** İnsan inceleyici var ama AI puanına göre karar veriyor. `[doğrula]` etiketiyle bayraklanır.
3. **İnsan kararı (eşik karşılanmaz):** Esaslı insan değerlendirmesi var. m.11/g devreye girmez, ama m.11/a bilgi talebi hakkı hala var.

**Karşılaştırmalı kaynak:** ABAD SCHUFA kararı (C-634/21, 7.12.2023) bu eşiği esnetti — kredi skorlamasının kendisi "otomatik karar" sayıldı; bu yorum KVKK'da emsal değer taşır `[model bilgisi — doğrula]`. Mutlaka `yargi_mcp KVKK endpoint`'inden ilgili Kurul kararlarını ara.

**Sektörel ek katmanlar:**
- **Finans / kredi:** BDDK Yapay Zekâ Uygulamaları Rehberi (2024) — kredi reddi vakalarında ek şeffaflık yükümlülüğü `[mevzuat_mcp — kurum_yonetmelik / teblig ara]`
- **Sağlık:** Sağlık Bakanlığı dijital sağlık AI rehberi `[mevzuat_mcp — teblig ara]`
- **Sosyal medya:** EU AI Act Art. 50(2) — AI tarafından üretilmiş/işlenmiş içeriğin kullanıcıya bildirilmesi
- **Trafik / plaka tanıma:** KVKK m.5/2-ç (kamu görevi istisnası) tartışmalı — Danıştay 10. Daire içtihadına bak

## MCP araştırma stratejisi

**Çalışma sırası — atlanamaz:**

1. **`mevzuat_mcp`** — KVKK 6698 m.11, m.13, m.14 metinlerini çek (`get_mevzuat_content`).
   - Sektör spesifikse: BDDK rehberi (`search_teblig`, `search_kurum_yonetmelik` — "yapay zekâ" anahtar kelime)
   - EU AI Act Art. 50 ve 86 metnine (model bilgisi — doğrula) atıf yap; Türkçe tam metin için mevzuat_mcp'de henüz yok

2. **`yargi_mcp KVKK endpoint`** — `search_kvkk_decisions` ile:
   - "otomatik karar" anahtar kelimesi
   - "profilleme" anahtar kelimesi
   - "algoritma" anahtar kelimesi
   - Operatör veri sorumlusunun adı (banka adı, platform adı)
   - Sonuçlardan SON 24 ayda yayımlananları öncele

3. **`yargi_mcp` BDDK karar endpoint'i** (sektör finans ise) — `search_bddk_decisions`

4. **`literatur_mcp` ve `yoktez_mcp`** — "münhasıran otomatik karar" "KVKK m.11/g" anahtar kelimeleriyle son 3 yıl doktrini:
   - `mcp__plugin_ai-governance-vatandas-legal_literatur_mcp__search_articles`
   - `mcp__plugin_ai-governance-vatandas-legal_yoktez_mcp__search_yok_tez_detailed`
   - Doktrin özellikle "münhasıran" tanımının sınırlarını çiziyor

5. **`hukuk_rag`** — Kullanıcı daha önce benzer başvuru yapmış mı? Şablon var mı?

## Akış

**Aşama 1 — Olgu intake (2 dakika, sohbet havasında, form gibi değil):**
- Kararı veren kurum/platform (banka, sigorta, sosyal medya — tam adı)
- Karar bana hangi formda iletildi (SMS, e-posta, push, mektup, ekran mesajı)
- Karar metni — varsa yapıştır; yoksa hatırladığın kadarıyla
- Tarih — ne zaman bana ulaştı? (KVKK m.13 başvuru süresi başlangıcı)
- Karar bana nasıl gerekçelendirildi? Açıklama var mı?
- Bu kararın bana zararı ne? (Kredi mahrumiyeti, hesap kapanması, ceza, vize reddi vb.) — TBK m.49 tazminat için zemin

**Aşama 2 — Sınıflandırma:**
- "Münhasıran otomatik" eşik testi (yukarıda) uygulanır
- Sektörel düzenleyici kontrolü yapılır
- Kullanıcı veri sahibi statüsü doğrulanır (KVKK m.3/ç)
- AB pazarına temas varsa GDPR m.22 paralel uygulanır

**Aşama 3 — KVKK Kurul içtihat taraması:**
- yargi_mcp KVKK endpoint'inden son 24 ay kararları çek
- Benzer sektör + benzer karar tipinde Kurul'un yaptırım uyguladığı vakaları çıkar
- Bunlar dilekçede emsal olarak kullanılır

**Aşama 4 — Karar:**
İki rotada hareket edilir, **paralel olarak**:

**Rota A — KVKK m.13 başvurusu (veri sorumlusuna):**
- Bilgi talebi (kararın mantığı — m.11/a + m.11/g)
- Otomatik karara itiraz (m.11/g)
- Tazminat talebi (varsa zarar — m.11/h)
- Veri sorumlusuna yazılı/elektronik (KEP varsa zorunlu) iletilir
- 30 günlük yanıt süresi `sure-takipcisi` agent'a kaydedilir

**Rota B — Sektörel yol (varsa):**
- Banka için: BDDK + Tüketici Hakem Heyeti (TKHK m.66)
- Sigorta için: Sigorta Tahkim Komisyonu (KKK 5684)
- Sosyal medya için: 5651 m.9 içerik kaldırma + platform iç itiraz

**Aşama 5 — Çıktı:**
- KVKK m.13 başvuru dilekçesi tam metni (DOCX uretici skill'i ile)
- Hukuki temel haritası (hangi madde, hangi içtihat)
- Süre takvimi (sure-takipcisi'ye eklenecek girdiler)
- Plan B: yanıt yetersiz olursa → `/kvkk-veri-itirazi --kurul-sikayet` skill'ine devir
- Plan C: Kurul kararı olumsuz olursa → idare mahkemesinde iptal davası

## Çıktı yapısı

```
# KİŞİSEL KULLANIM İÇİN ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR

## ⚠️ Gözden geçirici notu
- Kaynaklar: yargi_mcp KVKK ✓ (N karar tarandı) | mevzuat_mcp ✓ (KVKK m.11, m.13, m.14)
- Okuma: kullanıcının paylaştığı karar metni + N emsal Kurul kararı
- Doğrulama bayraklı: [N kalem]
- Güncellik: KVKK Kurul son karar tarihi ../../2026
- Avukat onayı: KVKK m.13 başvurusu için gerekli değil; m.14 Kurul şikâyeti için tavsiye edilir; m.18 mahkeme tazminatı için ZORUNLU TAVSİYE

## 1. Sınıflandırma
- Karar tipi: [otomatik / hibrit / insan]
- KVKK m.11/g eşik testi: [karşılandı / tartışmalı / karşılanmadı]
- Tabi olduğu rejim: KVKK (+ BDDK / GDPR / EU AI Act 50)

## 2. Aktif haklarınız
- m.11/a bilgi talebi: ✓
- m.11/g otomatik karara itiraz: ✓ (eşik karşılandı)
- m.11/h tazminat talebi: [varsa]
- DSM m.22 paralel (AB temas): [varsa]

## 3. KVKK Kurul içtihatı
- Emsal 1: [karar no, tarih, özet, kullanım]
- Emsal 2: [...]

## 4. Başvuru dilekçesi taslağı
[Tam metin]

## 5. Süre takvimi (sure-takipcisi'ye kaydet)
- ../../2026 — başvuru gönderim
- ../../2026 — yanıt son tarih (30 gün)
- ../../2026 — yanıt yetersiz → Kurul'a şikâyet son tarih (30 gün daha)

## 6. Yanıt geldiğinde ne yapacaksın?
- Olumlu → arşivle, durum kapanır
- Olumsuz/yetersiz/yanıt yok → `/ai-governance-legal:kvkk-veri-itirazi --kurul-sikayet`
- Tazminat değerlendirme → `/turk-hukuk-legal:dilekce-ihtarname` ile dava dilekçesi

## 7. Eylem ağacı
1. [Önerilen] m.13 başvurusunu KEP ile veri sorumlusuna gönder
2. Süre 30 günden ileri kaydedildi
3. Daha fazla bilgi → [3 soru]
4. Bekleyip izle → arşive kaydet
5. Başka → bana söyle
```

## Karşı argüman önleme

Skill aşağıdaki karşı argümanlara **önceden** cevap yerleştirir (turk-hukuk-legal:karsi-arguman-onleme entegrasyonu):

1. **"Bu karar münhasıran otomatik değildi"** → Veri sorumlusundan ek bilgi talebi (m.11/a) ile insan denetiminin gerçek mahiyeti sorulur.
2. **"KVKK m.5/2-ç kamu görevi istisnası uygulanır"** → İstisna dar yorumlanır; AYM içtihadında orantılılık testi uygulanır.
3. **"Sözleşmede genel rıza var"** → KVKK m.5/1 açık rıza tanımı + m.6 özel nitelikli verilerde ek koşullar.
4. **"AB üyesi olmadığımız için GDPR uygulanmaz"** → KVKK ile GDPR paralel hükümleri + AB pazarına ürün/hizmet sunan platforma karşı GDPR m.3(2)/(a)-(b) etki ülkesi prensibi.

## Hatalar ve sınırlar

- Bu skill **avukat tutmadan da** kullanılabilir (KVKK m.13 ve m.14 başvurusu bizzat yapılabilir, vekil zorunlu değil).
- m.18 tazminat davası için **mahkemede vekil tavsiye edilir** — özellikle istinaf aşamasında.
- Kararı veren kurum kamu kuruluşu ise yargı yolu farklı: idari yargı (İYUK), KVKK paralel olarak uygulanabilir.
- Sosyal medya hesabı kapatılmasında **5651 sayılı Kanun m.9** ve platform iç prosedürü de paralel devreye girer.
- Çıktı dilekçesi **DOCX**'e dökülmek istenirse `/turk-hukuk-legal:docx-uretici` çağrılır.

## Cross-skill handoff

- `--kurul-sikayet` ile çağrılırsa → `/ai-governance-legal:kvkk-veri-itirazi --kurul-sikayet` skill'ine
- Tazminat zemini varsa → `/turk-hukuk-legal:dilekce-ihtarname` (dava dilekçesi)
- DOCX format isterseniz → `/turk-hukuk-legal:docx-uretici`
- Süre takibi → otomatik olarak `sure-takipcisi` agent'a kaydedilir
- Marka taklit yönü varsa (örn. AI üretilmiş içerikte sahne adınız kullanılmışsa) → `/ai-governance-legal:ai-uretim-icerik-tespit`
