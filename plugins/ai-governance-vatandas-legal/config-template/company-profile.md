# Vatandaş Profili — Abdullah

*Bu dosya `claude-for-legal` ailesinin tüm eklentileri tarafından okunur. Tek yerden değişir, her yerde geçerlidir.*

*Hedef konum: `~/.claude/plugins/config/claude-for-legal/company-profile.md`*

---

## Kim olduğum

**Statü:** Vatandaş (avukat **değilim**). Kendi davalarımı ve hukuki işlerimi takip ediyorum.

**Asıl uğraşım:** Müzisyen / sanatçı. Türkiye'de yerleşik, sınır ötesi dijital platformlar (Amuse-İsveç, Spotify-ABD, Apple Music, Epidemic Sound, YouTube, BandLab vb.) üzerinden eser dağıtımı yapan/yapmış kişi.

**Hukuki rolüm:**
- **Müvekkil/davacı** sıfatıyla kendi davalarımı takip ediyorum (HMK m.71 — kendi davasını asil sıfatıyla takip hakkı)
- **Veri sahibi (ilgili kişi)** sıfatıyla KVKK m.3/ç ve GDPR Art. 4(1) kapsamında haklarımı kullanıyorum
- **Eser sahibi** sıfatıyla FSEK 5846 m.1/B-b kapsamında manevi ve mali haklarımı koruyorum
- **Tüketici** sıfatıyla TKHK 6502 m.3 ve MÖHUK m.26 kapsamında sınır ötesi platformlarla ilişkilerimi yönetiyorum

**Adım:** Abdullah  
**E-posta:** theakambio@gmail.com

---

## Yetki ve sınır

Avukat değilim. Bu nedenle:

1. **Kendi adıma** her türlü hukuki işlem yapabilirim — KVKK başvurusu, Kurul'a şikâyet, dilekçe (HMK m.71), ihtarname (notere doğrudan).
2. **Başkası adına** hukuki danışmanlık veremem (Av. K. m.35 inhisar).
3. **Belirli işlerde mecburi vekil**: Bölge Adliye Mahkemesi nezdinde istinaf duruşmasında, sigorta tahkim ihtilaflarında belirli dosya üstü ücretlerde vekil zorunluluğu olabilir — dosya özelinde değerlendir.
4. **Mahkemeye sunulacak nihai metinlerin** baroya kayıtlı bir avukatın gözünden geçirilmesi ihtiyatlı olur — özellikle istinaf, temyiz ve AYM/AİHM başvurularında.

Bu eklenti çıktıları **araştırma notu** seviyesindedir; nihai mahkeme/kurul başvurularında bir hukuk profesyoneli tarafından gözden geçirilmesi tavsiye edilir.

---

## Çıktı başlığı kuralı (work-product header override)

Orijinal eklentinin "PRIVILEGED & ATTORNEY WORK PRODUCT" başlığı bana **uygulanmaz** — bu ABD avukat-müvekkil ayrıcalığı (FRCP 26(b)(3)) doktrinidir, Türkiye'de Av. K. m.36 sır saklama yükümlülüğü ile karşılanır ve **avukat-müvekkil ilişkisi yokken doğmaz**.

Tüm çıktılarda aşağıdaki başlık kullanılır:

> **KİŞİSEL KULLANIM İÇİN ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR**  
> **Hazırlayan:** Claude (yapay zekâ asistan) — kullanıcı talimatıyla, kullanıcının kendi davası için  
> **Önemli:** Bu metin profesyonel hukuki görüş yerine geçmez. Mahkemeye, Kurul'a veya resmî mercilere sunulmadan önce baroya kayıtlı bir avukatın gözden geçirmesi tavsiye edilir.

---

## Hukuki temas ettiğim alanlar

| Alan | Durum | İlgili eklenti |
|---|---|---|
| FSEK / telif / müzik eseri hakları | aktif | `turk-hukuk-legal`, `ai-governance-legal` |
| Sınır ötesi dağıtım/yayın sözleşmeleri (Amuse, Spotify vb.) | aktif | `turk-hukuk-legal`, `ai-governance-legal` |
| KVKK / kişisel veri / otomatik karar | aktif | `ai-governance-legal`, `turk-hukuk-legal` |
| Vergi (KDV, GV, BSMV) | dönemsel | `turk-hukuk-legal` |
| Trafik kazası tazminatı | dönemsel | `turk-hukuk-legal` |
| MESAM royalty / meslek birliği | olası | `turk-hukuk-legal` |
| **AI sistemlerinin verilerimi/eserlerimi kullanması** | **yeni ve büyüyen — odak** | **`ai-governance-legal`** |

---

## Yargı yolu varsayılanları

- **Adli yargı (hukuk):** Asliye Hukuk Mahkemesi / Fikri ve Sınai Haklar Hukuk Mahkemesi (FSEK m.76, SMK m.156)
- **Adli yargı (ceza):** Asliye Ceza / Ağır Ceza (FSEK m.71, TCK m.135-138)
- **İdari yargı:** İdare Mahkemesi (KVKK Kurul kararı iptali için Ankara İdare Mahkemesi)
- **KVKK:** m.13 veri sorumlusu başvurusu (30 gün yanıt) → m.14 Kurul şikâyeti (30 gün başvuru) → m.18 mahkemede tazminat
- **Tüketici hakem heyeti:** TKHK m.66 parasal sınır altı
- **AYM:** Bireysel başvuru (6216 sayılı Kanun), iç hukuk yolu tüketildikten sonra 30 gün
- **AİHM:** Strasbourg, AYM dahil tüm iç yollar tüketildikten sonra 4 ay (Protokol 15 sonrası)

---

## Genel atıf disiplini

Tüm Türk hukuku atıfları **`uyap-atif-formati`** skill standartlarında verilir:
- Mevzuat: "KVKK 6698 m.11/g (RG 7.4.2016, S.29677)"
- Yargıtay: "Yargıtay 11. HD, E. 2022/XXXX, K. 2023/XXXX, ../../2023"
- KVKK Kurul: "KVKK Kurul, ../../2023 tarih, 2023/XXXX sayılı karar"
- AYM: "AYM, B. No: 2023/XXXX, ../../2024"
- AİHM: "AİHM, [Davacı] v. Türkiye, B. No: XXXXX/XX, ../../2024"

Model bilgisinden hiçbir atıf yapılmaz — her atıf yargi_mcp, mevzuat_mcp veya literatur_mcp'den teyit edilir; teyit edilemiyorsa `[model bilgisi — doğrula]` etiketi ile geçilir.
