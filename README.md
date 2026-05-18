# Claude for Legal — Türkçe Eklentiler

Anthropic'in `claude-for-legal` eklenti ailesinin **Türk hukukuna ve Türkçe uygulamaya uyarlanmış** sürümleri. Her eklenti Türk mevzuatına (KVKK, FSEK, TBK, TKHK, MÖHUK, SMK, HMK, TCK, İYUK), Türk içtihatına (Yargıtay, Danıştay, AYM, KVKK Kurul) ve Türk yargı pratiğine göre yeniden inşa edilmiştir.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Status](https://img.shields.io/badge/durum-aktif-brightgreen.svg)](#)
[![Türkçe](https://img.shields.io/badge/dil-Türkçe-red.svg)](#)

---

## ⚠️ Önemli Yasal Uyarılar

> **BU REPO HUKUKİ TAVSİYE DEĞİLDİR.**
>
> Buradaki eklentiler — skill'ler, dilekçe şablonları, ihtarname formatları, hukuki argüman önerileri — **bilgilendirme ve araştırma** amaçlıdır. Hiçbir çıktı profesyonel hukuki görüş yerine geçmez.
>
> **Bu eklentileri kullanırken:**
> - Çıktıları **baroya kayıtlı bir avukat** tarafından gözden geçirilmeden mahkemeye/Kurul'a/savcılığa sunmayın
> - **Avukat ile çalışmanız zorunlu olan** işlerde (Av. K. m.35 inhisarı: başkası adına dilekçe yazma; istinaf duruşması; sigorta tahkim limiti üstü) profesyonel destek alın
> - Mevzuat ve içtihat **sürekli değişir** — eklenti çıktılarındaki maddeleri ve kararları **güncel kaynakla doğrulayın**
> - Eklenti, **AI sistemlerinin halüsinasyonu** riskine karşı her atıfı `[mevzuat_mcp]`, `[yargi_mcp]` gibi kaynak etiketleriyle işaretler — etiketsiz atıflar `[model bilgisi — doğrula]` sayılır
>
> Repo sahibi ve katkıda bulunanlar, bu eklentilerin kullanımından doğan **doğrudan veya dolaylı hiçbir hukuki sonuçtan sorumlu tutulamaz**. Kullanım tamamen kullanıcının kendi riskindedir.

---

## Mevcut eklentiler

| Eklenti | Açıklama | Hedef kullanıcı | Durum |
|---|---|---|---|
| [`ai-governance-vatandas-legal`](./plugins/ai-governance-vatandas-legal) | AI sistemlerine karşı vatandaş haklarını koruma — KVKK m.11/g otomatik karar itirazı, FSEK m.21 + DSM m.4 opt-out, deepfake/ses klonu hukuki yol haritası, platform TOS tüketici denetimi | Vatandaş (avukat değil) | ✅ v1.0.0 |

*Yeni eklentiler bu listeye eklenecek.*

---

## Genel mimari

Tüm eklentiler aşağıdaki Türk hukuku MCP havuzunu **otonom olarak** kullanır:

```
mevzuat_mcp       ← KVKK, FSEK, TKHK, MÖHUK, sektörel düzenleyiciler
yargi_mcp         ← Yargıtay, Danıştay, BAM, AYM, AİHM, KVKK Kurul, BDDK, Rekabet
markapatent_mcp   ← TPMK marka/patent/tasarım tescil + bülten
literatur_mcp     ← DergiPark hukuki makaleler
yoktez_mcp        ← YÖK Ulusal Tez Merkezi (monografik doktrin)
hukuk_rag         ← Kullanıcının iç arşivi (TOS metinleri, başvuru şablonları, seed dokümanlar)
```

Her skill, hangi MCP'yi neden kullandığını **gerekçelendirir** (her plugin'in `references/00-MIMARI-KARARLARI.md` dosyasındaki `<otonom_mimari_karari>` etiketleri).

---

## Tasarım ilkeleri

Tüm eklenti bu prensiplere uyarak yazıldı:

1. **Halüsinasyon önleme:** Hiçbir mevzuat maddesi veya içtihat **model bilgisinden tek başına** alınmaz; her atıf MCP teyidi ile gelir, teyit edilemezse `[doğrula]` etiketi konur.
2. **Yargı yolu disiplini:** İdari yargı (İYUK) ile adli yargı (HMK) ayrımı her skill'de katıdır; yargı yolu seçimi en üstte yapılır (`turk-hukuk-legal:yargi-yolu-secimi` skill'i bu ayrımı yönetir).
3. **Süre disiplini:** Türk hukuku hak düşürücü süreleri sıkı uygular; her eklenti `sure-takipcisi` benzeri bir mekanizmayla süre takibi yapar.
4. **Avukat sınırı:** Av. K. m.35 inhisar ve m.36 sır saklama yükümlülüğü — eklenti **avukat değildir**, ürettiği çıktılar "araştırma notu" seviyesindedir.
5. **Karşı argüman önleme:** Mahkemeye/Kurul'a sunulan her metinde önceden öngörülebilen karşı argümanlara cevap yerleştirilir.
6. **Kişisel veri korunması:** TCK m.135-138 + KVKK m.4-5 — kişisel veri AI'a gönderilmeden önce **anonimleştirme uyarısı** verilir.

---

## Kurulum

Her eklenti kendi `KURULUM.md` ve `scripts/install.sh` dosyasını barındırır. Tek bir eklentiyi kurmak için:

```bash
git clone https://github.com/cvrtoonofficial/Claude-for-Legal-Turkish.git
cd Claude-for-Legal-Turkish/plugins/<eklenti-adı>
bash scripts/install.sh
```

Detay için ilgili eklentinin README'sine bakın.

### Önkoşullar

- macOS / Linux (Windows için WSL gerekir)
- [Claude Code](https://docs.claude.com/claude-code) veya [Cowork](https://claude.ai) kurulu
- Türk hukuku MCP servisleri: `mevzuat_mcp`, `yargi_mcp`, `literatur_mcp`, `yoktez_mcp` (Türkçe Hukuk MCP topluluk projeleri)

### MCP servislerini nasıl elde ederim?

Bu eklentiler aşağıdaki MCP servislerine bağımlıdır. Henüz tüm servisler resmi olarak yayımlanmamış olabilir:

- **mevzuat_mcp / yargi_mcp:** Türkiye'de açık-kaynak topluluk tarafından bakılır
- **literatur_mcp / yoktez_mcp:** DergiPark ve YÖK Tez taraması
- **markapatent_mcp:** TPMK bülten ve marka/patent tescil
- **hukuk_rag:** Kişisel arşiv için RAG (Retrieval-Augmented Generation)

Bu servisler kurulu değilse eklenti çalışır ama atıflar `[model bilgisi — doğrula]` etiketi alır.

---

## Katkıda bulunma

Bu repo şu an aktif geliştirme aşamasındadır. PR'lar açıktır ama:

- Hukuki içerik **Türk hukukuna uygun** olmalı, yabancı doktrin Türkleştirilerek getirilmeli
- Her atıf primary source (mevzuat veya yayımlanmış karar) ile teyit edilmeli
- Eklenen skill'ler `04-DOGRULAMA-RAPORU.md` benzeri statik tutarlılık testinden geçirilmeli
- Avukat olmayan kullanıcılara hitap eden çıktıların **avukat sınırı** uyarısı taşıması zorunlu

PR açmadan önce ilgili eklentinin `references/00-MIMARI-KARARLARI.md` dosyasını okuyun.

---

## Kaynak ve atıf

- Orijinal eklenti şablonu: Anthropic `claude-for-legal` plugin ailesi
- Türk hukuku uyarlaması: Bu repo

Bu repo, Anthropic'in resmî eklenti deposunun değil, **bağımsız bir uyarlamadır**. Anthropic herhangi bir destek vermez; sorularınız için bu repo'nun [issues](https://github.com/cvrtoonofficial/Claude-for-Legal-Turkish/issues) sekmesini kullanın.

---

## Lisans

[MIT License](./LICENSE) — bu eklentileri herhangi bir amaçla (ticari dahil) kullanabilir, değiştirebilir, dağıtabilirsiniz. Tek koşul: lisans metnini dahil edin.

**Hukuki uyarı, lisanstan bağımsız olarak geçerlidir** — MIT lisans size kodu kullanma izni verir; ürettiği hukuki çıktıların sorumluluğunu kaldırmaz.

---

## İletişim

- GitHub issues: [Claude-for-Legal-Turkish/issues](https://github.com/cvrtoonofficial/Claude-for-Legal-Turkish/issues)
- Repo sahibi: [@cvrtoonofficial](https://github.com/cvrtoonofficial)
