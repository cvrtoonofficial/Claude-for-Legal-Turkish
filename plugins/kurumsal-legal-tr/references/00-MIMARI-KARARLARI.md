# Mimari Kararları — Kurumsal Hukuk TR Eklentisi

Bu dosya, eklentinin **neden böyle tasarlandığını** ve hangi kararları **otonom olarak** verdiğini belgeler. Her karar `<otonom_mimari_karari>` etiketiyle işaretlidir.

---

## Karar 1 — Plugin adı: `kurumsal-legal-tr`

<otonom_mimari_karari>
**Karar:** Eklenti adı `kurumsal-legal-tr` olarak belirlendi. "corporate" yerine "kurumsal" tercih edildi (Türk hukuk terminolojisi); "tr" suffix'i, Anglo-Sakson plugin'lerinden ayırdetme amacı taşıyor.

**Alternatifler:** `corporate-legal-turkish`, `sirket-hukuk-tr`, `kurumsal-sanatci-legal`.

**Gerekçe:** Mevcut depo konvansiyonu (`ai-governance-vatandas-legal`) Türkçe terim + "legal" suffix pattern'ini benimsiyor. `kurumsal-legal-tr` aynı pattern'i sürdürüyor. "Sanatçı" suffix'i eklenmedi çünkü plugin müvekkil profilini parametre olarak alıyor (sanatçı + KOBİ + cross-border) — adda kısıtlama olmasın.

**Replace edilen:** Anthropic `corporate-legal` plugin'i. (`replaces` alanı plugin.json'da.)
</otonom_mimari_karari>

---

## Karar 2 — Modül seti: M&A + Entity Management aktif; Board pasif; Public Company kapalı

<otonom_mimari_karari>
**Karar:** İlk sürüm yalnızca **M&A** ve **Entity Management** modüllerini aktif tutuyor.

**Gerekçe:**
- **Board & Secretary** modülü pasif çünkü Türk YK tutanağı formatı (TTK m.390-391) Anglo-Sakson UWC formatından çok farklı — bu modül talep üzerine açılacak; şimdilik tek bir `board-minutes-tr` ve `written-consent-tr` skill'i içeriyor.
- **Public Company (SerPK)** kapalı çünkü Türkiye'de halka açık şirket düzenlemesi (6362 sayılı SerPK + KAP) ayrı bir uzmanlık alanı; Anthropic'in ABD SEC modeli doğrudan uygulanamaz. Türkiye'ye özel kalibre edilmiş ayrı bir plugin gerekir.

**Genişletme yolu:** Kullanıcı SPK işleri yapmaya başlarsa, ayrı bir `spk-kap-legal-tr` plugin'i geliştirilecek.
</otonom_mimari_karari>

---

## Karar 3 — Müvekkil profili: Sanatçı/yapımcı varsayılan

<otonom_mimari_karari>
**Karar:** Plugin'in varsayılan müvekkil profili **sanatçı/yapımcı/bireysel telif sahibi** olarak ayarlandı.

**Gerekçe:** Repo sahibinin pratik profili müzik sektörüne yakın (mevcut `ai-governance-vatandas-legal` plugin'inde aynı odak var; `swedish-music-law` ve `turk-hukuk-legal:sanatci-sozlesme-inceleme` skill'leri mevcut). FSEK m.48-52 telif devri ve MESAM/MSG/MÜYAP üyelik analizi varsayılan diligence kategorisinde.

**Esneklik:** Profil parametresi `cold-start-interview` ile değiştirilebilir; KOBİ veya cross-border müvekkil profili de aynı plugin'le çalışır, sadece materiality eşikleri ve sözleşme template'leri yeniden kalibre edilir.
</otonom_mimari_karari>

---

## Karar 4 — Materiality eşikleri Türk piyasasına kalibre

<otonom_mimari_karari>
**Karar:** Materiality eşikleri Türk KOBİ/orta ölçek şirket piyasasına göre belirlendi:
- Sözleşme: > 500.000 TL veya > 50.000 EUR
- Dava: > 100.000 TL veya manevi tazminat
- Change-of-control: her zaman material (eşik yok)
- FSEK m.48-52 mali hak devri: her zaman material

**Gerekçe:** Anglo-Sakson plugin'lerde varsayılan eşik USD bazlı ve uluslararası şirket ölçeğine kalibre (örn. $250.000+ contracts). Türk piyasasında orta ölçek müvekkil için bu eşik gereksiz yüksek; sanatçı/yapımcı için ise gereksiz kapsamlı çıktı üretir.

**Düzenlenebilir:** Eşikler `customize` skill'i ile her zaman değiştirilebilir.
</otonom_mimari_karari>

---

## Karar 5 — Atıf disiplini: Magesh anti-halüsinasyon kalkanı

<otonom_mimari_karari>
**Karar:** Tüm yargı kararı ve mevzuat atıfları MCP-doğrulamalı olacak. Doğrulanamayan atıflar `[model bilgisi — doğrula]` etiketi alacak.

**Gerekçe:** Magesh ve ark. (2025) AI hukuk araştırmasında üç hata kategorisi belirledi: (1) misattributed authorship, (2) mishandled hierarchy, (3) fabricated citation. Türk yargı pratiğinde özellikle Yargıtay HD numarası, E./K. numaraları ve karar tarihleri sıklıkla karıştırılıyor — bu hatalar bir avukatın dilekçesinde **vekâlet ücretinin reddi** sonucu doğurabilir.

**Uygulama:** Plugin her atıfı, çıktı oluştururken `yargi_mcp` veya `mevzuat_mcp` çağrısı ile doğrular; doğrulanamayanlar etiketli kalır ve kullanıcıya manuel teyit önerilir.
</otonom_mimari_karari>

---

## Karar 6 — UYAP atıf formatı zorunlu

<otonom_mimari_karari>
**Karar:** Tüm yargı kararı atıfları UYAP standardına uygun kanonik formatta olacak.

**Format örnekleri:**
- `Yargıtay 11. HD, E. 2023/1234, K. 2024/5678, T. 15.03.2024`
- `AYM, B.No: 2023/12345, T. 14.05.2024` (bireysel başvuru)
- `Türk Ticaret Kanunu (6102 sayılı), m. 376/1`
- `KVKK Kurul Kararı, 2024/123, T. 15.03.2024`

**Gerekçe:** UYAP (Ulusal Yargı Ağı Projesi) Türk yargı sisteminin elektronik altyapısı; atıflar bu sistemde indekslenebilir formatta yazılmalı. Dilekçelerin elektronik tebligata (KEP) uygunluğu için kritik.

**Cross-plugin handoff:** `turk-hukuk-legal:uyap-atif-formati` skill'i bu normalizasyonu uçtan uca yapar.
</otonom_mimari_karari>

---

## Karar 7 — Yargı yolu disiplini: Cross-plugin handoff

<otonom_mimari_karari>
**Karar:** Plugin **yargı yolu seçimi** yapmıyor — bu kararı `turk-hukuk-legal:yargi-yolu-secimi` skill'ine handoff ediyor.

**Gerekçe:** Türk hukukunda görev/yetki kuralları (HMK m.1-19, İYUK m.5, m.32, KTK m.110, MÖHUK m.26) karmaşık ve yanlış yol seçimi süre kaybı + ret riski yaratır. Bu uzmanlığı her plugin'de tekrarlamak yerine, mevcut `turk-hukuk-legal` plugin'inin yargi-yolu-secimi skill'ine merkezi handoff yapılıyor.
</otonom_mimari_karari>

---

## Karar 8 — Müşteri sırrı: Av.K. m.36 zorlama

<otonom_mimari_karari>
**Karar:** Müvekkil bilgisi **asla** profil dosyasına (`CLAUDE.md`) yazılmaz. Tüm müvekkil verisi `matter-workspace/<matter-id>/` altında izole tutulur.

**Gerekçe:** Avukatlık Kanunu (1136 sayılı) m.36 sır saklama yükümlülüğünü mutlak kılar. Profil dosyası plugin update'lerinde yeniden yazılabilir; müvekkil bilgisi orada olamaz.

**Uygulama:** `cold-start-interview` skill'i kullanıcıya hiç bir müvekkil adı sormaz; sadece pratik profili (avukat türü, müvekkil tipi vb.) sorar. Müvekkil bilgisi her yeni matter açıldığında `matter-workspace` skill'ine girilir ve oraya izole edilir.

**Hook:** `musteri-sirri-prehook` her çıktıda müvekkil bilgisinin doğru izole edildiğini kontrol eder.
</otonom_mimari_karari>

---

## Karar 9 — Cross-plugin handoff: turk-hukuk-legal merkezi

<otonom_mimari_karari>
**Karar:** Plugin, Türk hukukunun ortak işlevlerini (dilekçe formatı, atıf formatı, süre hesabı, .docx üretimi, sözleşme inceleme) `turk-hukuk-legal` plugin'ine handoff ediyor.

**Handoff matrisi:**
| Tetikleyici | Bu plugin'in skill'i | Handoff |
|-------------|---------------------|---------|
| Diligence'ta KVKK uyumsuzluğu | `ma-due-diligence` | `ai-governance-vatandas-legal:kvkk-veri-itirazi` |
| Diligence'ta FSEK/SMK ihlali | `ma-due-diligence` | `turk-hukuk-legal:tecavuz-triyaj` |
| Sanatçı sözleşmesi batch inceleme | `tabular-review-tr` | `turk-hukuk-legal:sanatci-sozlesme-inceleme` |
| Dilekçe taslağı | her skill | `turk-hukuk-legal:dilekce-ihtarname` |
| Süre hesabı | her skill | `turk-hukuk-legal:siure-hesap-motoru` |
| Final .docx | her skill | `turk-hukuk-legal:docx-uretici` |
| Atıf normalizasyonu | her skill | `turk-hukuk-legal:uyap-atif-formati` |
| Yüksek riskli dilekçe stres testi | her skill | `cocounsel-legal:predictive-rebuttal-engine` |

**Gerekçe:** DRY (Don't Repeat Yourself) — Türk hukuku ortak işlevleri tek bir merkezi plugin'de bakım edilebilir; her plugin'in kendi versiyonunu tutmak versiyon kayması yaratır.
</otonom_mimari_karari>

---

## Karar 10 — Agresif ton: HMK m.29 sınırı içinde

<otonom_mimari_karari>
**Karar:** Plugin "agresif — müvekkil hakkı sıkı korunur" tonunu varsayılan yapıyor.

**Sınırlar:**
- HMK m.29 dürüstlük kuralı — bilerek yanlış beyan, gizleme, geciktirme yasaktır
- HMK m.50 yasak deliller
- Av.K. m.34 dürüstlük + güven yükümlülüğü
- TBK m.49 vd. haksız fiil — eklenti çıktısı haksız fiile sebebiyet vermez

**Uygulama:**
- Sözleşme inceleme: deviation'lar **alternatif metin** ile birlikte gelir (sadece flag değil)
- Dilekçe: rakip iddialar **ezilir**, ancak gerçek olgu çarpıtması yapılmaz
- Müzakere: ilk teklif daima maksimum talep edilebilir hakla; geri çekilme alanı önceden tanımlı
- İhtarname: cezai sorumluluk + haksız fiil tazminatı **gerektiğinde** açıkça uyarılır
- Cross-border: yabancı mahkeme yetki klozu **daima itiraz noktası** (MÖHUK m.47 + TKHK m.3)

**Düzenlenebilir:** Ton parametresi `customize` ile "dengeli" veya "ihtiyatlı"ya çekilebilir.
</otonom_mimari_karari>

---

## Karar 11 — Materiality için Türk şirketler hukuku özel kuralları

<otonom_mimari_karari>
**Karar:** Türk şirketler hukukuna özgü şu olaylar **her zaman material** kabul edildi:

1. TTK m.376 öz kaynak kaybı (sermayenin yarısının veya 2/3'ünün karşılıksız kalması)
2. Olağan GK gecikmesi (TTK m.409 — 3 ay)
3. Bağımsız denetim atama eksikliği (TTK m.397/4)
4. VERBİS kayıt eksikliği (KVKK m.16)
5. Ticaret Sicil tescili gecikmesi (TTK m.30)

**Gerekçe:** Bu olaylar Türk şirketler hukukunda **hak düşürücü** sonuçlar doğurur (örn. TTK m.376 üst başlığında "sermayenin kaybı, borca batık olma durumu" — şirket iflas başvurusuna gidebilir). Anglo-Sakson eşdeğeri yoktur; bu nedenle Anthropic corporate-legal default'ları yetmez.
</otonom_mimari_karari>

---

## Karar 12 — AB hukuku katmanı: ikincil, Türk paraleli üzerinden

<otonom_mimari_karari>
**Karar:** AB hukuku ikincil katman olarak entegre edildi. Şu AB düzenlemeleri Türk paralelleri üzerinden işleniyor:

| AB | Türk paraleli |
|----|--------------|
| GDPR 2016/679 | KVKK 6698 |
| DSM 2019/790 m.17-23 | FSEK 5846 |
| EU AI Act 2024/1689 | KVKK + 6502 TKHK |
| DSA 2022/2065 | 5651 sayılı Kanun |
| Schrems II / SCC | KVKK m.9 |
| EUMR 139/2004 | RKHK 4054 + Tebliğ 2010/4 |

**Gerekçe:** Türk hukuku çoğu zaman AB direktiflerini iç hukuka aktarmıştır; Türk müvekkilin AB iştiraki varsa ya da AB platformuyla sözleşmesi varsa, AB hukukunu da doğrudan uygulamak gerekebilir. Plugin önce Türk paralelini kontrol eder, gerektiğinde AB seviyesine yükselir.
</otonom_mimari_karari>

---

## Karar 13 — Tabular review skill'i: sanatçı sözleşmeleri için optimize

<otonom_mimari_karari>
**Karar:** `tabular-review-tr` skill'i sanatçı/yapımcı müvekkil profili için aşağıdaki standart kolon setiyle optimize:

| Kolon | Açıklama |
|-------|----------|
| Doküman | Sözleşme adı |
| Tarihler | İmza + yürürlük + bitiş |
| Mali hak devri | FSEK m.48-52 (var/yok + kapsam) |
| Manevi hak | FSEK m.16-19 (saklı/devredilmiş) |
| Münhasırlık | Var/yok + süre |
| Change of control | Var/yok + bildirim süresi |
| Tahkim/yetki | MÖHUK m.47 — geçerli mi |
| Süre/fesih | Otomatik yenileme + fesih hakkı |
| Royalty | Oran + hesap yöntemi |

**Gerekçe:** Sanatçı sözleşmesi inceleme Türk müzik sektöründe sıklıkla yapılan bir işlem; Anglo-Sakson default'ları (commercial-legal:tabular-review) bu sektöre uygun kolon ön-tanımlama içermiyor.
</otonom_mimari_karari>

---

## Karar 14 — Skill envanteri minimum 12

<otonom_mimari_karari>
**Karar:** İlk sürüm 12 skill içeriyor:
1. cold-start-interview
2. customize
3. matter-workspace
4. ma-due-diligence
5. entity-compliance-tr
6. material-contract-schedule-tr
7. closing-checklist-tr
8. tabular-review-tr
9. written-consent-tr
10. board-minutes-tr
11. deal-team-summary-tr
12. integration-management-tr

**İleride eklenecek (v2.0 roadmap):**
- `spk-kap-legal-tr` (ayrı plugin — SerPK)
- `rekabet-kurulu-bildirim-tr` (Tebliğ 2010/4 birleşme bildirim taslağı)
- `siyaset-bagisi-tr` (TTK + Siyasi Partiler Kanunu)
- `vergi-uyusmazligi-tr` (zaten turk-hukuk-legal'da var — handoff)
- `whistleblower-iste-bildirim` (AB 2019/1937 Türkiye'ye geldiğinde)
</otonom_mimari_karari>

---

## Magesh raporu için statik tutarlılık kontrolleri

Bu eklentinin **her sürümünde** aşağıdaki testler manuel yapılır:

- [ ] Tüm SKILL.md'lerde `[mevzuat_mcp]`, `[yargi_mcp]` etiketleri var
- [ ] UYAP atıf formatı CLAUDE.md'de tanımlı
- [ ] Müvekkil bilgisi profil dosyasında yok
- [ ] HMK m.29 dürüstlük sınırı her skill'de işaretli
- [ ] Cross-plugin handoff matrisi güncel
- [ ] Av.K. m.35 inhisarı tüm çıktı uyarılarında var
- [ ] AB hukuku katmanı Türk paralelleriyle eşleştirilmiş

---

*Bu dosya plugin'in **mimari bellek**'idir. Yeni bir tasarım kararı verildiğinde buraya `<otonom_mimari_karari>` etiketiyle eklenir.*
