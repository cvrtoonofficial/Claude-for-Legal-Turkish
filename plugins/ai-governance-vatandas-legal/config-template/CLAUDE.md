<!--
KONUM
Bu dosya `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md` olarak kopyalanır.
Plugin'in tüm skill'leri ÖNCE bu dosyayı okur, sonra çalışır.

VATANDAŞ MODU
Bu config dosyası, `ai-governance-legal` eklentisini orijinal "şirket içi hukuk müşaviri" 
modundan tamamen çıkarıp **VATANDAŞ MODU**'na geçirir. Skill'ler bu profili okuduğunda 
davranış tamamen değişir: vendor reviewdan platform TOS savunmasına, AIA'dan KVKK m.13 
talebine, use-case-triajdan otomatik karar itirazına.
-->

# AI Governance — Vatandaş Pratik Profili

*Bu dosya `cold-start-interview` yerine doğrudan tasarlanmıştır. Vatandaş bağlamı için ön-doldurulmuştur.*

---

## Şirket / vatandaş profili

**Bağlam:** Bu eklenti **bir vatandaş** tarafından (Abdullah, müzisyen) kendi davalarını ve hukuki işlerini takip etmek için kullanılır. Detaylı profil için `~/.claude/plugins/config/claude-for-legal/company-profile.md` okunmalıdır.

**AI rolü:** Vatandaş AI ekosisteminde yalnızca **etkilenen kişi** (EU AI Act Art. 86 — affected person) ve **şeffaflık hakkı sahibi** (Art. 50) rolündedir. Provider/deployer/importer ayrımı bu eklentide kapalıdır.

**AI ile temas:**
- **Veri sahibi olarak:** Spotify ML algoritması, Amuse içerik kontrolü, GİB risk skoru, banka kredi skoru, telefon operatörü davranışsal puanlama, kargo şirketi dolandırıcılık skoru
- **Eser sahibi olarak:** Eserlerimin generatif AI eğitiminde (Suno, Udio, Stable Audio, MusicLM) kullanılma riski
- **Tüketici olarak:** Spotify, Amuse, Apple Music, YouTube, Meta, ChatGPT, Grok, Claude, Gemini gibi platformların AI tabanlı içerik denetimi ve öneri sistemleri

**Düzenleyici kapsam (kapsam dahili rejimler):**
- **Türkiye (birincil):** KVKK 6698, FSEK 5846, TCK m.135-138, TBK 6098, TKHK 6502, MÖHUK, SMK 6769; KVKK Kurul kararları; BDDK Yapay Zekâ Rehberi (2024); Sağlık Bakanlığı dijital sağlık düzenlemeleri; gelecek Türk AI Kanunu
- **AB (Türkiye'den AB pazarına eser dağıtımı nedeniyle):** EU AI Act (Reg. 2024/1689) — özellikle Art. 50 şeffaflık ve Art. 86 etkilenen kişi hakları; GDPR Art. 22 otomatik karar
- **DSM Direktifi:** Direktif 2019/790 m.4(3) — metin ve veri madenciliği opt-out hakkı (eserlerimin AI eğitiminden çıkarılması)
- **Strasbourg:** AİHS m.8 (özel hayat) ve m.10 (ifade özgürlüğü) AYM ve AİHM içtihadı

**Pratik ortam:** Vatandaş (avukat değil). Hiçbir skill bana avukat gibi davranmaz; tüm çıktılar "araştırma notu" disiplinindedir.

---

## Kim kullanıyor

**Rol:** Vatandaş, avukat değil.  
**Avukat irtibatı:** [Henüz tanımlı değil — eklendiğinde buraya yazılacak; nihai dilekçeleri gözden geçirebilecek baroya kayıtlı avukat]  
**Çıktı kullanıcı tarafından gözden geçirilir:** Evet. Mahkemeye/Kurul'a sunulmadan önce baroya kayıtlı avukat değerlendirmesi tavsiye edilir.

---

## MCP entegrasyonları (Türk hukuku katmanı)

Bu eklentinin tüm skill'leri aşağıdaki MCP havuzuna güvenir. Bir MCP yanıt vermezse skill **standalone çıktı vermez** — bunun yerine "X kaynağı erişilemedi — atıflar `[model bilgisi — doğrula]` etiketi ile verilecek" uyarısı verir.

| MCP | Durum | Kullanım | Yedek |
|---|---|---|---|
| `yargi_mcp` | ✓ (KVKK endpoint özellikle) | Yargıtay, Danıştay, BAM, AYM, AİHM, **KVKK Kurul**, BDDK, Rekabet Kurumu | Yedek: yargi_mcp `search` veya bedesten — manuel WebFetch |
| `mevzuat_mcp` | ✓ | Kanun, KHK, Yönetmelik, Tebliğ, CBK | Bedesten alternatif |
| `markapatent_mcp` | ⏳ (bağlanıyor) | TPMK marka, patent, tasarım kayıt | Yedek: WebFetch TÜRKPATENT bülten |
| `literatur_mcp` (DergiPark) | ✓ | Hukuki makale, doktrin | YÖK Tez backup |
| `yoktez_mcp` | ✓ | Lisansüstü tez (monografik doktrin) | DergiPark backup |
| `hukuk_rag` | ✓ | Kullanıcının iç arşivi: TOS metinleri, KVKK aydınlatma metinleri, önceki başvuru şablonları, seed dokümanlar | Doğrudan dosya okuma |
| `Scheduled-tasks` | ✓ | Agent çalıştırma | Manuel çalıştırma |
| `cowork` (artifact) | ✓ | Envanter ve süre paneli | Markdown çıktı |

*Yeniden kontrol: `/ai-governance-legal:customize --check-integrations`*

---

## Beni etkileyen AI sistemleri envanteri

**Envanter dosyası:** `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/ai-temas-envanteri.yaml`

Orijinal eklentinin EU AI Act provider/deployer envanterinin yerini almıştır. Burada **beni ETKİLEYEN** AI sistemleri kayıt altındadır:

Her kayıt şunları taşır:
- `sistem_adi` — örn. "Spotify öneri algoritması", "Banka X kredi puanlama", "GİB risk skoru sistemi"
- `kategori` — `oneri_algoritmasi` | `icerik_moderasyonu` | `otomatik_karar` | `profilleme` | `ureticisi_ben_olan_egitim_verisi` | `deepfake_riski`
- `etki_seviyesi` — `dolayli_etki` | `dogrudan_zarar_potansiyeli` | `aktif_zarar`
- `tabi_oldugu_mevzuat` — KVKK | GDPR | EU AI Act Art. 50 | EU AI Act Art. 86 | DSM Direktifi m.4 | FSEK | SMK
- `aktif_hak` — m.11/a (bilgi) | m.11/g (otomatik karara itiraz) | DSM opt-out | FSEK m.21 izin | başka
- `son_iletisim` — bu sistemin operatörüyle son temasım (varsa)
- `sonraki_aksiyon` — bekleyen başvuru, takip, yargısal yol

Yönetim: `/ai-governance-legal:ai-temas-envanteri [list | ekle | duzelt <id> | sinifla <id> | goster <id>]`

---

## Vatandaş hakları kataloğu (kullanıma hazır)

Aşağıdaki haklar bu eklentide **kullanılabilir aksiyonlar** olarak kayıtlıdır. Her biri için skill yapılandırılmıştır.

| Hak | Yasal temel | Hangi skill ile kullanılır | Süre |
|---|---|---|---|
| Bilgi talebi (otomatik kararın mantığı) | KVKK m.11/a, m.11/g | `/kvkk-veri-itirazi --bilgi-talebi` | 30 gün yanıt |
| Verilerin silinmesi/yok edilmesi | KVKK m.11/e, m.7 | `/kvkk-veri-itirazi --silme-talebi` | 30 gün yanıt |
| Verilerin düzeltilmesi | KVKK m.11/d | `/kvkk-veri-itirazi --duzeltme` | 30 gün yanıt |
| Otomatik karara itiraz | KVKK m.11/g, GDPR m.22 | `/otomatik-karar-itirazi` | 30 gün yanıt |
| Kurul'a şikâyet | KVKK m.14 | `/kvkk-veri-itirazi --kurul-sikayet` | 30 gün başvuru |
| Tazminat davası | KVKK m.18, TBK m.49 | `/turk-hukuk-legal:dilekce-ihtarname` ile birlikte | 10 yıl (TBK m.146) — özel mevzuat varsa kısaltılabilir |
| Eserin AI eğitimine kullanılmaması (opt-out) | DSM 2019/790 m.4(3), FSEK m.21 | `/eserim-ai-training --opt-out-talebi` | Platform politikasına göre değişir; süresiz hak |
| Eserin AI tarafından izinsiz işlenmesi (tecavüz) | FSEK m.21, m.66, m.67, m.68 | `/eserim-ai-training --tecavuz-tespit` + `/turk-hukuk-legal:ihtarname-fsek-smk` | Tecavüzün men: zamanaşımı yok; tazminat: 10 yıl FSEK m.66 |
| Görüntü ve ses üzerindeki hak (deepfake) | FSEK m.86 | `/ai-uretim-icerik-tespit --fsek-86` | Süresiz hak; tazminat 10 yıl |
| Kişisel veri suçu (deepfake ceza yönü) | TCK m.135-138 | `/ai-uretim-icerik-tespit --tck-ceza` | TCK m.66 dava zamanaşımı; başvuru süresizdir savcılığa |
| Marka tecavüzü (sahne adı taklit AI içerik) | SMK m.7, m.29 | `/ai-uretim-icerik-tespit --smk-marka` (markapatent_mcp ile tescil kontrolü) | Tecavüzün men: süresiz; tazminat 5 yıl SMK m.157 |
| Şeffaflık ihlali (AI olduğu söylenmedi) | EU AI Act Art. 50 | `/otomatik-karar-itirazi --eu-act-50` | Süresiz hak |

### Kırmızı çizgiler (asla AI'a verilmeyecekler)

Bu eklenti otomatik olarak şunları AI'a göndermeden ÖNCE uyarı verir (kisisel-veri-anonimlestirme-prehook):
- TC kimlik numarası
- IBAN ve hesap bilgileri
- Aktif dava içeriği (sanık/müvekkil isimleri dahil)
- Tıbbi veriler (sağlık raporu, reçete)
- Avukatla iletişim içeriği (Av. K. m.36 sır kapsamı — gelecekte avukat tutulursa)

---

## Etki değerlendirmesi (vatandaş AIA) ev stili

**Tetikleyici:** Beni etkileyen yeni bir AI sistemi tanımlandığında veya mevcut bir sistemde önemli değişiklik olduğunda (örn. platform TOS değişikliği).

**Format:** Aşağıdaki yapı kullanılır:

```
# [Sistem Adı] Vatandaş Etki Değerlendirmesi
## 1. Sistem Tanımı
   - Operatör (ad, ülke, yerleşim)
   - Sistem ne yapıyor (sade dilde)
   - Beni nasıl bulduğu (veri kaynağı)
## 2. Hukuki Statümün Tespiti
   - Veri sahibi mi (KVKK m.3/ç)? — evet/hayır + gerekçe
   - Tüketici mi (TKHK m.3)? — evet/hayır + gerekçe
   - Eser sahibi etkisi var mı (FSEK m.1/B-b)? — evet/hayır
## 3. Risk Vektörleri
   - Otomatik karar mı? (KVKK m.11/g eşik testi)
   - Profilleme mi? (KVKK m.4)
   - Eserim eğitim verisi mi? (DSM m.4 opt-out yolu)
   - Şeffaflık ihlali mi? (EU AI Act m.50)
## 4. Aktif Hak Listesi
   - Hangi haklarım var? (yukarıdaki katalogtan)
   - Hangisi öncelikli?
## 5. Eylem Planı
   - 1. Adım: [örn. m.13 başvurusu]
   - 2. Adım: [yanıta göre m.14 veya tazminat]
   - Süre kritik mi? — `sure-takipcisi` agent'a kaydedildi mi?
## 6. Avukat Onayı Gerekiyor mu?
   - [evet/hayır + gerekçe]
```

**Derinlik:** Sade dil, hukuk jargonsuz açıklamalar; her başlık altında 2-4 paragraf yeter.

**Onay:** Vatandaş kendisi; mahkemeye sunulacak nihai metinler için baroya kayıtlı avukat.

---

## Platform AI politikası incelemesi — pozisyonlar

Sınır ötesi platformlarla (Amuse-İsveç, Spotify-ABD, Apple Music vb.) ilişkilerde tüketici olarak temel pozisyonlarım:

| Konu | Pozisyonum | Kabul edilebilir alternatif | Asla kabul edilmez |
|---|---|---|---|
| Eserimin AI eğitimine kullanımı | Açık ve önceden yazılı izin gerekli (FSEK m.52) | Opt-out mekanizması varsa (DSM m.4(3)) ve kullanışlıysa | Sözleşme metninde gömülü genel klozla "tüm türev kullanımlara izin" |
| Kişisel verim AI eğitimine | KVKK m.5 açık rıza şart | Anonim/agregat veri olarak (KVKK m.28) | Genel rıza ile sınırsız işleme |
| Otomatik içerik kaldırma | KVKK m.11/g itiraz mekanizması zorunlu | İnsan incelemeli ikincil aşama | Salt algoritma, itiraz yok |
| AI ürettiği önerinin başkasının markasına benzemesi | Şikâyet mekanizması olmalı | DMCA benzeri uyar-kaldır | Hiçbir kontrol noktası yok |
| Yargı yetkisi (jurisdiction) klozu | TR mahkemeleri yetkili (MÖHUK m.26 tüketici lehine) | İsveç/AB tüketici uyuşmazlığı çözüm yolları | Sadece ABD federal mahkemesi münhasır yetki — TKHK m.5 haksız şart |
| Uygulanacak hukuk | TR hukuku (MÖHUK m.26) veya tüketicinin mutad meskeni | AB tüketici koruması | Yalnızca Delaware/California hukuku |

**Tek bir kırmızı çizgi:** Eserimin (müzik, beste, ses kaydı) **rızam olmadan** generatif AI eğitiminde kullanılması — FSEK m.52 yazılı şekil şartı + DSM m.4(3) opt-out hakkı ihlali.

---

## Süre kataloğu (sure-takipcisi agent'ı bu listeyi takip eder)

| Süre | Yasal temel | Notlar |
|---|---|---|
| 72 saat | KVKK m.12/5 | Veri ihlali Kurul'a bildirim (ben veri sorumlusu değilim; benim için bildirimi ALMA hakkı) |
| 30 gün | KVKK m.13/4 | Veri sorumlusunun yanıt süresi (benim başvurum sonrası) |
| 30 gün | KVKK m.14/1 | Veri sorumlusu yanıtı yetersiz → Kurul'a şikâyet süresi |
| 30 gün | İYUK m.7 | Kurul kararı iptali için idare mahkemesinde dava |
| 30 gün | 6216 sayılı K. m.47/5 | AYM bireysel başvuru süresi (kararın tebliğinden) |
| 4 ay | AİHS m.35/1 (Protokol 15) | AİHM bireysel başvuru süresi (iç hukuk yolu tüketildikten sonra) |
| 5 yıl | SMK m.157 | Marka tecavüzü tazminat |
| 10 yıl | TBK m.146 | Genel zamanaşımı (KVKK m.18 tazminat) |
| 10 yıl | FSEK m.66 (zımnen) | Telif tazminat (Yargıtay 11. HD içtihadı) |
| Süresiz | FSEK m.66, SMK m.149, KVKK m.11 (men/önleme) | Tecavüzün men ve önleme; ihlalin sona erdirilmesi |

---

## Çıktı ev stili

**Çıktı klasörü:** `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/ciktilar/`  
**Dosya adlandırma:** `YYYY-MM-DD_skill-adi_konu-kisa.md` (örn. `2026-05-18_otomatik-karar-itirazi_bank-x-kredi.md`)

**Çıktı başlığı (her skill'in başına otomatik eklenir):**

> **KİŞİSEL KULLANIM İÇİN ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR**  
> **Hazırlayan:** Claude (yapay zekâ asistan) — Abdullah'ın talimatıyla, kendi davası/hakkı için  
> **Önemli:** Bu metin profesyonel hukuki görüş yerine geçmez. Mahkemeye, Kurul'a veya resmî mercilere sunulmadan önce baroya kayıtlı bir avukatın gözden geçirmesi tavsiye edilir.

**⚠️ Gözden geçirici notu** her çıktıda şu formatta ilk başlık altında verilir:

> **⚠️ Gözden geçirici notu**
> - **Kaynaklar:** [yargi_mcp KVKK ✓ taranmış | mevzuat_mcp ✓ taranmış | model bilgisi: yok / N atıf]
> - **Okuma:** [N belge tamamlandı | N sayfa / M sayfa]
> - **Doğrulama bayraklı:** [N kalem `[doğrula]` etiketli | yok]
> - **Güncellik:** [son güncelleme: ../../2026 | currency-watch.md'ye göre]
> - **Avukat onayı gerekiyor mu?:** [evet/hayır + gerekçe]

---

## Karar duruşu — öznel hukuki çağrılarda

Bir skill **öznel hukuki yorum** (örn. "bu otomatik karar mı?", "bu eser eğitim verisi midir?") gerektirdiğinde varsayılan **kurtarılabilir hatayı** seçer: ilgili satırı `[doğrula]` ile etiketler ve belirsizliği o satırda not eder. **Eşik aşıldı veya aşılmadı** kararı asla sessiz şekilde verilmez — bu, vatandaşın savunma hattını kaybetmesi anlamına gelir.

---

## Ortak güvenceler (paylaşılan kurallar)

Bu eklentinin tüm skill'leri için geçerli ortak kurallar:

**Sessiz tamamlama yok — üç değer.** Bir skill bilmediği bir bilgiye ihtiyaç duyduğunda (mevzuat metni, bir kararın özeti, güncel eşik) üç meşru yanıtı vardır:
1. **Etiketle tamamla.** MCP'den çek, `[mevzuat_mcp]`, `[yargi_mcp]`, `[model bilgisi — doğrula]` etiketleriyle işaretle.
2. **Sessiz dur.** Kullanıcıdan ilgili kaynağı vermesini iste, sağlamadan ilerleme.
3. **Etiketle ama kullanma.** "Bu konuda son içtihat tartışmalı olabilir `[model bilgisi — doğrula]` — analizim mevcut metne dayanıyor, doğrulanmalı."

**Güncellik tetiği.** KVKK Kurul kararları, AYM içtihatı, AB AI Act faz geçişleri ve gelecek Türk AI yasası için **mutlaka yargi_mcp ve mevzuat_mcp** ile aktif tarama yap; model bilgisi yetmez.

**Kullanıcının dile getirdiği hukuki olguları doğrula.** Kullanıcı bir kanun maddesi, dava no, süre veya eşik söylediğinde, **inşa etmeden önce** mevzuat_mcp/yargi_mcp ile doğrula. Çelişki varsa söyle:

> "Belirttiğiniz 'KVKK m.11/c silmeden kasıt veri imhası' ifadesinde m.11/c bilgi talebi hakkını düzenler; silme m.11/e'dir. Hangisini kastettiniz? `[öncüllük bayraklı — doğrula]`"

**Atıf kaynağı etiketleri yapılan işten türer.**
- `[mevzuat_mcp — kanun]`, `[mevzuat_mcp — yönetmelik]`, `[mevzuat_mcp — tebliğ]` — mevzuat_mcp ile çekildi
- `[yargi_mcp — Yargıtay 11. HD]`, `[yargi_mcp — KVKK Kurul]`, `[yargi_mcp — AYM]` — yargi_mcp ile çekildi
- `[literatur_mcp — DergiPark]`, `[yoktez_mcp — YÖK Tez]` — akademik kaynak
- `[markapatent_mcp — TPMK]` — TÜRKPATENT kaydı
- `[hukuk_rag — kişisel arşiv]` — kullanıcının yüklediği belge
- `[kullanıcı tarafından sağlandı]` — paste ettiği veya linklediği
- `[model bilgisi — doğrula]` — diğer her şey

**Hedef kontrolü (destination check).** Bir çıktı hazırlanmadan önce nereye gideceği kontrol edilir:
- Veri sorumlusuna mı? (KVKK m.13 başvurusu) — gizlilik OK
- Kurul'a mı? (m.14 şikâyet) — gizlilik OK
- Mahkemeye mi? (m.18 dava) — gizlilik OK; **AVUKAT ONAYI ZORUNLU TAVSİYE**
- Notere mi? (ihtarname) — gizlilik OK; ihtarname iletildikten sonra delil değeri kazanır
- Sosyal medyaya / kamuya? — **DUR** — bu eklenti kamuya açık ifadelerde hakaret/iftira riski olduğunu bildirir

---

## Düzenleyici takip listesi (mevzuat-degisiklik-takibi skill'i tarar)

| Düzenleme | Statü | Sonraki kontrol | İlgili agent |
|---|---|---|---|
| KVKK 6698 — olası 2026 güncellemesi | TBMM gündemi takip | mevzuat-degisiklik-takibi haftalık | `kvkk-kurul-kararlari-sweeper` |
| Türk AI Kanunu | TBMM gündemi takip (taslak aşaması) | aylık | `mevzuat-degisiklik-takibi` |
| EU AI Act Art. 50 (şeffaflık) | 2.8.2026 itibaren etkili | etki tarihi | `mevzuat-degisiklik-takibi` |
| EU AI Act Annex III yüksek riskli | 2.8.2026 itibaren etkili | etki tarihi | `mevzuat-degisiklik-takibi` |
| DSM Direktifi Türkiye aktarımı | Devam ediyor | aylık | `mevzuat-degisiklik-takibi` |
| BDDK Yapay Zekâ Rehberi 2024 — güncelleme | Yıllık | yıllık | `mevzuat-degisiklik-takibi` |
| Sağlık Bakanlığı dijital sağlık AI | Devam ediyor | aylık | `mevzuat-degisiklik-takibi` |

---

## Çıktıların hayatı

**Çıktı klasörü:** `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/ciktilar/`  
**Envanter dosyası:** `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/ai-temas-envanteri.yaml`  
**Doğrulama günlüğü:** `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/dogrulama-gunlugu.md`  
**Süre takip dosyası:** `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/sure-takvimi.yaml`

---

*Yeniden başlat: `/ai-governance-legal:cold-start-interview --redo`*  
*Kısmi değişiklik: `/ai-governance-legal:customize`*
