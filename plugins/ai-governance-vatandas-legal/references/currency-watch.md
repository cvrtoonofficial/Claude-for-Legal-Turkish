# Currency Watch — Bu Eklenti İçin Hızla Değişen Konular

*Son güncelleme: ../../2026*

Bu eklenti şu alanlarda **hızla değişen** içerikle çalışır. Model bilgisinden tek başına atıf yapma — mutlaka mevzuat_mcp ve yargi_mcp ile teyit et.

## 1. Türk AI Kanunu (Yapay Zeka Kanunu)
- **Durum:** TBMM gündemi takip — taslak aşaması `[doğrula]`
- **Etki:** Tüm vatandaş AI etkileşimlerinin yasal çerçevesi
- **Kontrol:** `mcp__mevzuat_mcp__search_kanun "yapay zekâ"`, TBMM gündem sayfası
- **Frekans:** Aylık

## 2. KVKK 6698 Güncellemesi
- **Durum:** 2026 olası güncelleme — taslakta `[doğrula]`
- **Etki:** m.11, m.13, m.14 sürecini değiştirebilir
- **Kontrol:** `mcp__mevzuat_mcp__search_kanun "6698"` + son TBMM hareketleri
- **Frekans:** Aylık

## 3. EU AI Act Faz Geçişleri
- **Şubat 2025:** Yasak uygulamalar (Art. 5)
- **Ağustos 2025:** GPAI sağlayıcı yükümlülükleri (Art. 53-55)
- **Ağustos 2026:** Yüksek riskli sistemler ve Art. 50 şeffaflık
- **Ağustos 2027:** Tam uygulama
- **Etki:** AB pazarına eser dağıtan müzisyenler için doğrudan
- **Kontrol:** EUR-Lex (manuel WebFetch), EU AI Office bültenleri
- **Frekans:** Her büyük tarihe yaklaşırken (T-30)

## 4. DSM Direktifi Türkiye Aktarımı
- **Durum:** Devam ediyor — m.4(3) opt-out hakkı için aktarım metnindeki şekil önemli
- **Etki:** AI eğitim verisi opt-out hakkının Türk hukukundaki tam ifadesi
- **Kontrol:** `mcp__mevzuat_mcp__search_kanun "DSM"`, `search_kurum_yonetmelik "telif"`
- **Frekans:** Aylık

## 5. KVKK Kurul Kararları — AI Konulu
- **Durum:** 2024-2026 döneminde hızla artıyor
- **Etki:** Otomatik karar, profilleme, biyometrik eşiği yorumu
- **Kontrol:** `mcp__yargi_mcp__search_kvkk_decisions` haftalık
- **Frekans:** Haftalık (kvkk-kurul-kararlari-sweeper agent otomatik)

## 6. ABAD SCHUFA ve Sonrası
- **Durum:** ABAD C-634/21 (7.12.2023) — kredi skorlama Art. 22 kapsamında
- **Sonraki:** SCHUFA sonrası AB üye devlet uygulamaları + KVKK Kurul tarafından emsal alımı
- **Etki:** "Münhasıran otomatik" eşik yorumu
- **Kontrol:** Manuel + AB hukuku doktrin (literatur_mcp)

## 7. Suno/Udio/Stable Audio Davaları (ABD/AB)
- **Durum:** RIAA v. Suno + Andersen v. Stability AI devam ediyor `[doğrula]`
- **Sonraki:** ABD federal mahkeme kararları + AB Hamburg LG Kneschke sonrası kararlar
- **Etki:** AI eğitim verisi olarak telifli içerik kullanımı içtihadı (Türk mahkemelerine de yön verir)
- **Kontrol:** Manuel + literatur_mcp

## 8. BDDK Yapay Zekâ Rehberi
- **Durum:** 2024 yayımlandı; periyodik güncellemeler beklenir
- **Etki:** Banka ve finans AI tabanlı kararlar
- **Kontrol:** `mcp__mevzuat_mcp__search_kurum_yonetmelik "BDDK yapay zekâ"`
- **Frekans:** Yıllık

## 9. Sağlık Bakanlığı Dijital Sağlık AI Düzenlemeleri
- **Durum:** Devam ediyor — tıbbi karar destek sistemleri
- **Etki:** Sağlık verisi + AI tanı/tedavi önerisi
- **Kontrol:** `mcp__mevzuat_mcp__search_teblig "dijital sağlık"`
- **Frekans:** Aylık

## 10. Yargıtay 11. HD FSEK + AI İçtihatı
- **Durum:** Yeni içtihat şekilleniyor (deepfake, ses klonu, AI üretimi)
- **Etki:** FSEK m.21, m.86 yorumu
- **Kontrol:** `mcp__yargi_mcp__search_bedesten_unified "yapay zekâ FSEK"`
- **Frekans:** Aylık

## 11. AYM Bireysel Başvuru — AI Konulu
- **Durum:** Henüz az; oturmamış içtihat
- **Etki:** Anayasa m.20 özel hayat + AI; orantılılık
- **Kontrol:** `mcp__yargi_mcp__search_anayasa_unified "yapay zekâ"`
- **Frekans:** Aylık

## 12. AİHM Türkiye Aleyhindeki AI/Veri Kararları
- **Durum:** Sınırlı; *Big Brother Watch v. UK* tipinde Türkiye'ye uyarlanabilir kararlar
- **Etki:** AİHS m.8 özel hayat + AI gözetim
- **Kontrol:** Manuel + literatur_mcp

---

## Güncelleme protokolü

Bu dosya 90 günde bir gözden geçirilir. Yeni gelişme tespit edilirse:
1. İlgili konunun "Durum" alanı güncellenir
2. Etkilenen skill'in SKILL.md'sinde değişiklik gerekiyorsa not düş
3. CLAUDE.md'deki "Düzenleyici takip listesi" tablosunu güncelle
