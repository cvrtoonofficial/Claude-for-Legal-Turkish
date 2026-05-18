---
name: kvkk-veri-itirazi
description: >
  KVKK 6698 sayılı Kanun kapsamında ilgili kişi (veri sahibi) haklarınızı kullanma süreci —
  m.13 veri sorumlusu başvurusu (bilgi, düzeltme, silme, otomatik karara itiraz, tazminat),
  m.14 Kurul'a şikâyet, m.18 tazminat davası. Süre takibi otomatik. Tetikleyiciler:
  "KVKK başvurusu", "veri silme talebi", "kişisel verilerimi öğrenmek istiyorum", "veri
  sorumlusu yanıt vermiyor", "Kurul'a şikâyet", "KVKK m.13", "ilgili kişi başvurusu".
argument-hint: "[başvuru tipi: --bilgi-talebi | --silme-talebi | --duzeltme | --kurul-sikayet | --mahkeme-dava | --otomatik-karar]"
---

# /kvkk-veri-itirazi

## Ne zaman çalışır

KVKK 6698 sayılı Kanun kapsamında ilgili kişi sıfatınızla **m.11'de sayılan haklarınızı** sistematik bir prosedürle kullanmak istiyorsanız. Bu skill **uçtan uca** süreci yönetir: ilk başvurudan Kurul şikâyetine, mahkemeye gerekiyorsa tazminat davası dilekçesine kadar.

## Akış üç katmanlıdır

**Katman 1 — Veri sorumlusuna m.13 başvurusu:**
- 30 gün yanıt süresi
- KEP zorunlu (kurumsal) veya yazılı/elektronik (kişisel)
- Olumlu yanıt → süreç biter
- Yanıt yetersiz/yok → Katman 2

**Katman 2 — Kurul'a m.14 şikâyet:**
- Veri sorumlusu yanıtından sonra 30 gün
- Kurul karar verir (kabul / red / yaptırım)
- Olumsuz → idare mahkemesinde iptal davası (İYUK m.7 — 30 gün)

**Katman 3 — Mahkemede m.18 tazminat:**
- Zarar varsa Tüketici Mahkemesi (mali değer altı) veya Asliye Hukuk
- TBK m.49 haksız fiil + KVKK m.18 özel hüküm
- Zamanaşımı 10 yıl (TBK m.146) — özel mevzuat varsa farklı

## Hukuki temel ve madde haritası

| KVKK m. | Hak | Süreçteki yeri |
|---|---|---|
| m.11/a | Kişisel verinin işlenip işlenmediğini öğrenme | İlk başvuru |
| m.11/b | İşlenmişse buna ilişkin bilgi talep etme | İlk başvuru |
| m.11/c | İşlenme amacı + amaca uygun kullanılıp kullanılmadığı | İlk başvuru |
| m.11/ç | Yurt içi/yurt dışı üçüncü kişiler | İlk başvuru |
| m.11/d | Eksik/yanlış işlenmişse düzeltilmesi | Düzeltme |
| m.11/e | m.7 çerçevesinde silinmesi/yok edilmesi | Silme/imha |
| m.11/f | (d) ve (e) işlemlerinin üçüncü kişilere bildirilmesi | Bildirim talebi |
| m.11/g | **Münhasıran otomatik sistemler vasıtasıyla aleyhe sonuca itiraz** | Otomatik karar — `/otomatik-karar-itirazi` ile entegre |
| m.11/h | Zarar tazmini | Tazminat |
| m.13 | Veri sorumlusuna başvuru — usul | İlk yol |
| m.14 | Kurul'a şikâyet — usul | İkincil yol |
| m.18 | Tazminat | Üçüncül yol |
| m.20 | Çeşitli hükümler — adli yargı | Tazminat tabi olduğu yargı |
| m.17 | Cezai hüküm — TCK m.135-138 atıf | Ceza yönü |

**Uygulama yönetmeliği:** Veri Sorumlusuna Başvuru Usul ve Esasları Hakkında Tebliğ (RG 10.3.2018) `[mevzuat_mcp — teblig]`

## MCP araştırma stratejisi

1. **`yargi_mcp KVKK endpoint` (BİRİNCİL):** Bu skill'in en kritik veri kaynağı. Aşağıdaki tipte sorgular yapılır:
   - `search_kvkk_decisions` — benzer ihlal tipinde Kurul'un yaptırım/red kararları
   - `get_kvkk_document_markdown` — tam karar metni
   - Operatör adı (veri sorumlusu) + ihlal tipi anahtarları

2. **`mevzuat_mcp`:**
   - KVKK 6698 tam metni
   - Veri Sorumlusuna Başvuru Usul ve Esasları Hakkında Tebliğ
   - Aydınlatma Yükümlülüğünün Yerine Getirilmesinde Uyulacak Usul ve Esaslar Hakkında Tebliğ
   - Veri İhlali Bildirimi (Madde 12) — varsa

3. **`literatur_mcp` + `yoktez_mcp`:** Ciddi argümantasyon gereken kararlar için doktrin

4. **`hukuk_rag`:** Kullanıcının daha önce yazdığı başvuru/şikâyet/dava şablonları

## Akış — argümana göre

### `--bilgi-talebi`

Standart KVKK m.13 başvurusu. m.11/a-ç haklarını birlikte kullanır.

**Çıktı:**
- Başvuru dilekçesi tam metni (bilgi talebi formatı)
- Hangi adrese gönderilecek (KEP zorunlu, veri sorumlusu kayıtlı KEP adresi araştırılır)
- 30 gün yanıt süresi `sure-takipcisi` agent'a kaydedilir
- Yanıt geldiğinde değerlendirme için takip skill'i (m.13/4 yetersizse → m.14)

### `--silme-talebi`

m.11/e + m.7 birlikte uygulanır. **m.7 koşulları:**
- İşleme sebebi ortadan kalkmış
- Açık rıza yetersiz hâle gelmiş
- Hukuka aykırı işleme

**Özel durum — sosyal medya / arama motoru:** *Right to be forgotten* (AİHM *Hurbain v. Belgium* ve AYM bireysel başvuruları). Google'a "unutulma hakkı" talebi.

### `--duzeltme`

m.11/d. Veri yanlış veya eksikse düzeltme. Genelde basit, kısa süreç.

### `--kurul-sikayet`

**Önkoşul:** m.13 başvurusu yapılmış olmalı ve aşağıdakilerden biri olmalı:
- Yanıt verilmedi (30 gün)
- Yanıt yetersiz
- Yanıt kabul edilemez

**Süre:** Yanıt tarihinden veya 30 gün dolumundan itibaren 30 gün.

**Süreç:**
1. Önceki m.13 başvurusunun çıktısı yüklenir
2. Yanıt (varsa) eklenir
3. Kurul şikâyet dilekçesi yazılır (Form-2 standardı + ek belgeler)
4. KVKK Kurul'a iletim (kurum web portalı veya yazılı/KEP)

**Kurul önceki kararları kritik:** yargi_mcp KVKK endpoint'inden **benzer ihlal tipinde** Kurul'un yaptırım uyguladığı emsal kararlar dilekçede kullanılır.

### `--mahkeme-dava`

KVKK m.18 + TBK m.49 birleşik tazminat davası. **Mahkeme:** Tüketici Mahkemesi (parasal sınır altı) veya Asliye Hukuk.

**Önkoşul:** Genelde m.13 ve/veya m.14 başvurularından geçilmiş olmalı (yargısal kesinlik için değil ama olgusal temel için).

**Dilekçe unsurları:**
- Tarafların kimliği
- Olgular (kişisel veri hangi şekilde işlenmiş, ne tür zarar oluşmuş)
- Hukuki temel (KVKK m.18 + TBK m.49)
- Kanıt listesi (KVKK Kurul kararı varsa kuvvetli delil)
- Talep (maddi tazminat + manevi tazminat + faiz)

**Avukat gerekiyor mu?** Tüketici hakem heyeti için hayır; Asliye Hukuk için tavsiye edilir; istinaf duruşmasında zorunlu olabilir.

### `--otomatik-karar`

Doğrudan `/otomatik-karar-itirazi` skill'ine yönlendirir; bu skill onun bir alt yolu olarak hareket eder.

## Çıktı yapısı

```
# KİŞİSEL KULLANIM İÇİN ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR
# KVKK m.13 [veya m.14 / m.18] Başvuru/Şikâyet/Dava Taslağı
# Tarih: ../../2026 | Veri Sorumlusu: [adı]

## ⚠️ Gözden geçirici notu
- Kaynaklar: yargi_mcp KVKK ✓ (N karar) | mevzuat_mcp KVKK + Tebliğ ✓
- Mod: [bilgi / silme / düzeltme / Kurul şikâyet / mahkeme dava / otomatik karar]
- Avukat onayı: [m.13 için gerekli değil / m.18 için ZORUNLU TAVSİYE]

## 1. Veri sorumlusu kimliği ve iletişim
- Ad: [tam unvan]
- Yerleşim: [adres + ülke]
- VERBİS kaydı: [varsa numara]
- KEP adresi: [kayıtlı KEP]
- Aydınlatma metni tarihi: [varsa]

## 2. Olgu özeti
- İlişki başlangıcı: [tarih]
- Sorun: [bilgi yetersizliği / silme talebi / haksız işleme / otomatik karar / vb.]
- Bana zarar: [varsa — somut, hesaplanabilir / manevi / her ikisi]

## 3. Aktif hak listesi (bu başvuruda kullanılacak)
- ☑ m.11/a — bilgi
- ☐ m.11/b — işleme detayları
- ☑ m.11/d — düzeltme [veya işaretsiz]
- ☑ m.11/e — silme [veya işaretsiz]
- ☐ m.11/g — otomatik karara itiraz [`/otomatik-karar-itirazi`'ya devir varsa]
- ☐ m.11/h — tazminat

## 4. Emsal Kurul kararları
- KVKK Kurul, [no/tarih], [özet ve kullanım] `[yargi_mcp]`
- KVKK Kurul, [no/tarih], [özet ve kullanım] `[yargi_mcp]`

## 5. BAŞVURU/ŞİKÂYET/DAVA DİLEKÇESİ

[Tam metin — formal bürokratik dil]

KİŞİSEL VERİLERİ KORUMA KURULU
ANKARA

[veya: Veri Sorumlusu KEP'i'ne]

ŞİKÂYET EDEN/İLGİLİ KİŞİ : Abdullah [T.C. No, adres — anonimleştirilebilir]
ŞİKÂYET EDİLEN/MUHATAP   : [Veri Sorumlusu — tam unvan, KEP, adres]
KONU                      : [özet]

I. OLGULAR
[Tarihli, somut, kanıtlı anlatım]

II. HUKUKİ DEĞERLENDİRME
A) [Hak 1 — KVKK m.11/X — emsal Kurul kararı]
B) [Hak 2 — KVKK m.11/Y — emsal Kurul kararı]

III. TALEPLER
1. [Somut talep]
2. [Somut talep]
3. Gerekli yaptırımın uygulanması — KVKK m.18 / Yönetmelik m.X

IV. EKLER
1. [Belge listesi]

İmza: Abdullah
Tarih: ../../2026

## 6. Süre takvimi (sure-takipcisi'ye kaydet)
- ../../2026 — başvuru iletim
- ../../2026 — yanıt son tarih (30 gün)
- [Yetersiz yanıt halinde] ../../2026 — Kurul şikâyet son tarih

## 7. Eylem ağacı
1. [Önerilen] Dilekçeyi KEP/yazılı olarak gönder
2. Yanıt geldiğinde değerlendirme için skill'i tekrar çağır
3. Yanıt yetersiz → `/kvkk-veri-itirazi --kurul-sikayet`
4. Kurul red → idare mahkemesi iptal davası → `/turk-hukuk-legal:vergi-mahkemesi-dilekce` benzeri yapıda
5. Tazminat → `/kvkk-veri-itirazi --mahkeme-dava`
6. Sadece izle, arşivle
```

## Karşı argüman önleme

1. **"Verilerinizi aydınlatma metnimizle açıkladık"** → Aydınlatma yükümlülüğü m.10 — bilgilendirilmiş açık rıza demek değil; m.13 başvurusu bağımsız bir haktır
2. **"Açık rızanız vardı"** → KVKK m.5 açık rıza geri alınabilir; m.7 silme hakkı uygulanır
3. **"İşleme sebebimiz devam ediyor"** → m.7 koşullarını sistematik test et; **somut** sebep gerekli
4. **"Otomatik karar değil, insan inceledi"** → İnsan denetiminin **gerçek mahiyeti** sorgulanır; rubber-stamping varsa hala otomatik
5. **"Yurt dışı veri aktarımı yapmadık"** → m.9 yurt dışı veri aktarımı koşulları; bulut/CDN kullanan platformlar genelde fiilen aktarıyor

## Hatalar ve sınırlar

- m.13 ve m.14 başvurularında **avukat zorunlu değildir** — kendiniz yapabilirsiniz.
- m.18 tazminat davasında **mahkemede vekil tavsiye edilir** ama zorunlu değil; istinaf duruşmasında olabilir.
- KVKK Kurul yaptırım kararlarına idare mahkemesinde iptal davası açılabilir (İYUK m.7 — 30 gün).
- Cezai sorumluluk (TCK m.135-138) varsa **savcılığa suç duyurusu** ayrı bir yol — bu skill cezai yola değil idari/hukuki yola odaklanır.
- DOCX format için `/turk-hukuk-legal:docx-uretici`

## Cross-skill handoff

- Otomatik karar: `/ai-governance-legal:otomatik-karar-itirazi`
- Tazminat dilekçesi format: `/turk-hukuk-legal:dilekce-ihtarname`
- DOCX: `/turk-hukuk-legal:docx-uretici`
- Veri ihlali — 72 saat bildirim: `/turk-hukuk-legal:kvkk-veri-ihlali-bildirim`
- İdare mahkemesi iptal davası: `/turk-hukuk-legal:vergi-mahkemesi-dilekce` benzeri yapıda
- Süre takibi: otomatik `sure-takipcisi`
