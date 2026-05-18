# Kurumsal Hukuk — Türk & AB Versiyonu (TR)

Anthropic `corporate-legal` eklentisinin **Türk hukukuna uyarlanmış sürümü**. M&A (birleşme/devralma) ve Entity Management (tüzel kişilik takibi) modülleriyle, **TTK 6102 + BK 6098 + FSEK 5846 + SMK 6769 + KVKK 6698 + HMK 6100** ekseninde yeniden inşa edildi. AB hukuku (GDPR, DSM Direktifi m.17-23, EU AI Act, DSA, Schrems II) ikincil katman olarak entegre edildi.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Status](https://img.shields.io/badge/durum-aktif-brightgreen.svg)
![Türkçe](https://img.shields.io/badge/dil-T%C3%BCrk%C3%A7e-red.svg)

---

## ⚠️ Önemli Yasal Uyarı

> **BU EKLENTİ HUKUKİ TAVSİYE DEĞİLDİR.**
>
> Çıktılar — sözleşme inceleme, due diligence bulgusu, kapanış checklist'i, YK kararı taslağı, dilekçe önerisi — **araştırma ve taslak** seviyesindedir. Hiçbir çıktı profesyonel hukuki görüş yerine geçmez.
>
> **Bu eklentiyi kullanırken:**
>
> - Çıktıları **baroya kayıtlı bir avukat** tarafından gözden geçirilmeden mahkemeye / Ticaret Sicili'ne / Rekabet Kurulu'na / Kurul'a sunmayın
> - Av. K. m.35 inhisar (başkası adına dilekçe yazma yasağı) ve m.36 (sır saklama) yükümlülüğüne uyun
> - Mevzuat ve içtihat **sürekli değişir** — eklenti çıktılarındaki maddeleri ve kararları **güncel kaynakla doğrulayın**
> - Eklenti, **AI halüsinasyonu** riskine karşı her atıfı `[mevzuat_mcp]`, `[yargi_mcp]` gibi kaynak etiketleriyle işaretler — etiketsiz atıflar `[model bilgisi — doğrula]` sayılır
>
> Repo sahibi ve katkıda bulunanlar, bu eklentinin kullanımından doğan **doğrudan veya dolaylı hiçbir hukuki sonuçtan sorumlu tutulamaz**. Kullanım tamamen kullanıcının kendi riskindedir.

---

## Nedir?

Bu eklenti, kurumsal hukuk işlerini Türk hukuku eksenli yapan bir Claude Code/Cowork plugin'idir. Şunları yapar:

- **M&A due diligence** — Türk şirket alım/satımlarında VDR taraması; TTK şirketler hukuku, BK sözleşmesel yükümlülük, FSEK/SMK fikri mülkiyet, 4857 iş hukuku, VUK vergi, KVKK uyumu, RKHK rekabet, MASAK uyumu kategorilerinde sistematik issue extraction
- **Material contract schedule** — Disclosure schedule oluşturma, Türk usulü "material contract" tanımı (change-of-control, münhasırlık, FSEK m.48-52 telif devri, BK m.83 sözleşmenin devri)
- **Closing checklist** — Türk kapanış adımları: Rekabet Kurulu birleşme bildirimi (Tebliğ 2010/4), Ticaret Sicil tescili (TTK m.30), MERSİS güncellemesi, VERBİS güncellemesi, sektörel onaylar (BTK/BDDK/RTÜK)
- **Entity compliance** — Türk şirket yıllık takvimi: TTK m.376 öz kaynak, m.409 olağan GK, m.397/4 bağımsız denetim, KDV/Muhtasar/Geçici Vergi/KVK Beyanları
- **Tabular review** — Batch sözleşme inceleme (örn. 30 sanatçı sözleşmesinde aynı anda change-of-control + münhasırlık + mali hak devri klozları)
- **Written consent (TTK m.390/4)** — Türk YK toplantısız karar formatı
- **Board minutes (TTK m.390-391)** — YK toplantı tutanağı Türk usulü
- **Integration management** — Kapanış sonrası entegrasyon (TTK consent, sözleşme devri, müşteri-tedarikçi bildirimleri)

---

## Hedef kullanıcı

Bu plugin **özellikle aşağıdaki profiller için** kalibre edilmiştir:

- **Sanatçı / yapımcı / bireysel telif sahibi** müvekkilleri olan avukatlar — FSEK m.48-52 telif devri, MESAM/MSG/MÜYAP üyelik analizi, yabancı platform sözleşmeleri (Amuse, Spotify, Epidemic Sound, Kobalt, AWAL)
- **KOBİ / aile şirketi** kurumsal işleri yöneten in-house veya dış avukatlar
- **Cross-border** işlemleri olan müvekkillere bakan avukatlar (Türkiye-AB ve Türkiye-3. ülke)
- **Müzik / teknoloji / IP yoğun** şirketlerin hukuk işleri

> **Not:** Bu plugin Sermaye Piyasası Kanunu (6362) altındaki halka açık şirketler için kalibre edilmemiştir; SPK/KAP modülü ayrıdır.

---

## Plugin skill envanteri (12 skill)

| Skill | Ne yapar |
|-------|----------|
| `cold-start-interview` | İlk kurulum mülakatı — büro profili, müvekkil tipi, aktif modüller |
| `customize` | Profil parçası değişikliği |
| `matter-workspace` | Çoklu müvekkil/işlem dosyası yönetimi |
| `ma-due-diligence` | Türk hukuku diligence — 9 kategori, materiality eşikleri |
| `entity-compliance-tr` | Türk şirket takvimi — 12 yıllık + 6 olay tetiklemeli yükümlülük |
| `material-contract-schedule-tr` | Disclosure schedule (Türk material contract tanımı) |
| `closing-checklist-tr` | 4 fazlı Türk kapanış checklist'i |
| `tabular-review-tr` | Batch sözleşme inceleme grid'i |
| `written-consent-tr` | TTK m.390/4 toplantısız karar |
| `board-minutes-tr` | TTK m.390-391 YK tutanağı |
| `deal-team-summary-tr` | Müvekkil/ekip brief'i |
| `integration-management-tr` | Kapanış sonrası entegrasyon |

---

## Genel mimari

```
mevzuat_mcp       ← TTK, BK, FSEK, SMK, KVKK, HMK, VUK, RKHK, MÖHUK
yargi_mcp         ← Yargıtay, Danıştay, BAM, AYM, AİHM, KVKK Kurul, Rekabet Kurulu, GİB özelge
markapatent_mcp   ← TPMK marka/patent/tasarım (FSEK + SMK için)
literatur_mcp     ← DergiPark — Türk akademik doktrin
yoktez_mcp        ← YÖK Tez — monografik doktrin
hukuk_rag         ← Büro iç sözleşme corpus
```

Her skill, hangi MCP'yi neden kullandığını `references/00-MIMARI-KARARLARI.md` dosyasındaki `<otonom_mimari_karari>` etiketleriyle gerekçelendirir.

---

## Tasarım ilkeleri

1. **Halüsinasyon önleme:** Hiçbir mevzuat maddesi veya içtihat **model bilgisinden tek başına** alınmaz; her atıf MCP teyidi ile gelir, teyit edilemezse `[doğrula]` etiketi konur.
2. **UYAP atıf standardı:** Tüm atıflar kanonik formatta (`Yargıtay 11. HD, E. ../K. ../T. ..`, `TTK m. X/Y`, `AYM, B.No: ../T. ..`).
3. **Yargı yolu disiplini:** Adli (HMK) ↔ idari (İYUK) yargı ayrımı net; cross-plugin handoff ile `turk-hukuk-legal:yargi-yolu-secimi` çağrılır.
4. **Süre disiplini:** HMK m.92-104 + adli tatil (m.102) + hak düşürücü süre vs. zamanaşımı; `turk-hukuk-legal:siure-hesap-motoru` ile çapraz hesap.
5. **Müşteri sırrı:** Av.K. m.36 — müvekkil verisi profil dosyasına yazılmaz; matter-workspace altında izole.
6. **Av.K. m.35 inhisar:** Eklenti **avukat değildir** — çıktılar "araştırma notu" + "taslak" seviyesindedir.
7. **Magesh kalkanı:** Misattributed authorship + mishandled hierarchy + fabricated citation yapısal önleme.
8. **Karşı argüman önleme:** Mahkemeye/Kurul'a sunulan her metinde önceden öngörülebilen karşı argümanlara cevap yerleştirilir (Toulmin rebuttal mantığı).

---

## Kurulum

```bash
git clone https://github.com/cvrtoonofficial/Claude-for-Legal-Turkish.git
cd Claude-for-Legal-Turkish/plugins/kurumsal-legal-tr
bash scripts/install.sh
```

Detay için `KURULUM.md`.

### Önkoşullar

- macOS / Linux (Windows → WSL)
- [Claude Code](https://docs.claude.com/claude-code) veya [Cowork](https://claude.ai)
- Türk hukuku MCP servisleri: `mevzuat_mcp`, `yargi_mcp` (zorunlu); `literatur_mcp`, `yoktez_mcp`, `markapatent_mcp`, `hukuk_rag` (tavsiye)

---

## İlk kullanım

Kurulumdan sonra Cowork'te şunu söyleyin:

```
/kurumsal-legal-tr:cold-start-interview
```

veya doğal dilde:

> "kurumsal hukuk plugin'ini kuralım"

Plugin 8-10 dakikalık bir mülakatla profilinizi öğrenecek ve `~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/CLAUDE.md` dosyasını yazacaktır.

---

## Cross-plugin handoff

| Senaryo | Bu plugin'in skill'i | Handoff edilen |
|---------|---------------------|----------------|
| Diligence'ta KVKK uyumsuzluğu | `ma-due-diligence` | `ai-governance-vatandas-legal` |
| Diligence'ta FSEK/SMK ihlali | `ma-due-diligence` | `turk-hukuk-legal:tecavuz-triyaj` |
| Sanatçı sözleşmesi batch inceleme | `tabular-review-tr` | `turk-hukuk-legal:sanatci-sozlesme-inceleme` |
| Dilekçe taslağı | her skill | `turk-hukuk-legal:dilekce-ihtarname` |
| Final .docx çıktısı | her skill | `turk-hukuk-legal:docx-uretici` |
| Yüksek riskli stres testi | her skill | `cocounsel-legal:predictive-rebuttal-engine` |

---

## Katkıda bulunma

- Hukuki içerik **Türk hukukuna uygun** olmalı
- Her atıf primary source (mevzuat veya yayımlanmış karar) ile teyit edilmeli
- Eklenen skill'ler `references/00-MIMARI-KARARLARI.md`'ye karar gerekçesiyle eklenmeli
- Müvekkil bilgisi ve müşteri sırrı **asla** repo'ya commit edilmez

---

## Kaynak ve atıf

- Orijinal eklenti şablonu: Anthropic `corporate-legal` plugin
- Türk hukuku uyarlaması: Bu repo
- Lisans: MIT

---

## İletişim

- GitHub issues: [Claude-for-Legal-Turkish/issues](https://github.com/cvrtoonofficial/Claude-for-Legal-Turkish/issues)
- Repo sahibi: [@cvrtoonofficial](https://github.com/cvrtoonofficial)
