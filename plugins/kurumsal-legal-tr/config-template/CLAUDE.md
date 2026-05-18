# Corporate-Legal Plugin — Pratik Profili

> **Hedef konum:** `~/.claude/plugins/config/claude-for-legal/corporate-legal/CLAUDE.md`
> **Yetki alanı:** Türk hukuku (birincil) + AB hukuku (ikincil katman)
> **Usul ekseni:** HMK 6100, TTK 6102, BK 6098, FSEK 5846, SMK 6769, KVKK 6698, SerPK 6362
> **Profil versiyonu:** 2026-05 / v1.0
> **Sürüm tarihi:** 19 Mayıs 2026

---

## 1. Büro / Avukat Profili

| Parametre | Değer |
|-----------|-------|
| Ana yetki alanı | Türkiye Cumhuriyeti (HMK ve ilgili usul kanunları) |
| İkincil yetki alanı | Avrupa Birliği müktesebatı (GDPR, DSM, EU AI Act, DSA) |
| Müvekkil profili | **Sanatçı / yapımcı / bireysel telif sahibi** (FSEK + MESAM/MSG/MÜYAP odaklı) |
| Aktif modüller | **M&A** + **Entity Management** |
| Pasif modüller | Board & Secretary (sadece talep üzerine), Public Company (kapalı — SerPK işleri ayrı protokol) |
| Çıktı dili | **Türkçe** (ana dil) |
| Atıf formatı | **UYAP standardı** — bkz. §6 |
| Ton / risk tutumu | **Agresif — müvekkil hakkı sıkı korunur**, HMK m.29 dürüstlük sınırı içinde |
| Onay matrisi | Yüksek değerli işlem (> 500.000 TL veya > 50.000 EUR) → kıdemli avukat onayı şart |

---

## 2. Materiality Eşikleri

Bu eşikler `diligence-issue-extraction`, `material-contract-schedule` ve `deal-team-summary` skill'lerinin hangi olayı "önemli" sayacağını belirler.

### 2.1. Sözleşmesel Materiality

| Kategori | Eşik |
|----------|------|
| Tek sözleşme yıllık değeri | > 500.000 TL |
| Münhasırlık / non-compete süresi | > 12 ay |
| Change-of-control klozu | **Her zaman material** (sektör fark etmez) |
| Müvekkilin telif/sınai mülkiyet devri | **Her zaman material** (FSEK m.48-52 kapsamında) |
| Yabancı para birimli yükümlülük | > 50.000 EUR / USD eşdeğeri |
| KVKK kapsamında işlenen kişisel veri | "Özel nitelikli" (KVKK m.6) ise her hâlükârda material |

### 2.2. Uyuşmazlık Materiality

| Kategori | Eşik |
|----------|------|
| Açılan / açılması muhtemel dava | Talep > 100.000 TL veya manevi tazminat içeriyorsa |
| Cezai soruşturma | Her zaman material (TCK + özel ceza kanunları) |
| İdari para cezası | > 50.000 TL veya tekrar eden ihlal |
| KVKK Kurul kararı | Her zaman material |
| Rekabet Kurulu kararı | Her zaman material |

### 2.3. Kurumsal Materiality (Entity Management için)

| Olay | Materiality |
|------|-------------|
| TTK m.376 öz kaynak kaybı | Her hâlükârda kritik |
| Olağan genel kurul gecikmesi | TTK m.409 — kritik |
| Bağımsız denetim atama eksikliği | TTK m.397/4 — kritik |
| VERBİS kayıt eksikliği | KVKK m.16 — kritik |
| Yıllık faaliyet raporu | TTK m.516 — material |

---

## 3. M&A Modülü — Türk Hukuku İskeleti

### 3.1. Due Diligence Kategorileri (Türk hukukuna uyarlanmış)

`diligence-issue-extraction` skill'i VDR'deki belgeleri **şu kategori altyapısıyla** tarayacak:

1. **Şirketler hukuku** — TTK 6102
   - Esas sözleşme ve değişiklikleri (TTK m.339, 452)
   - Yönetim kurulu kararları (TTK m.390-391)
   - Genel kurul tutanakları (TTK m.413-414)
   - Pay defteri ve pay devirleri (TTK m.499, 595)
   - TTK m.376 öz kaynak durumu
   - Bağımsız denetim raporları (TTK m.397/4)
2. **Sözleşmesel yükümlülükler** — BK 6098 + TBK 6098
   - Material contract eşiklerini geçen tüm sözleşmeler
   - Change-of-control klozları
   - Münhasırlık ve non-compete
   - Garantiler ve tazminat klozları
3. **Fikri ve sınai mülkiyet** — **FSEK 5846 + SMK 6769** (sanatçı/yapımcı müvekkil için kritik)
   - Eser sahipliği kayıtları (FSEK m.1/B, m.8)
   - Mali hakların devri ve lisansları (FSEK m.48-52)
   - Manevi hakların durumu (FSEK m.16-19)
   - Marka, patent, faydalı model, tasarım, coğrafi işaret tescilleri (SMK)
   - MESAM/MSG/MÜYAP üyelikleri ve royalty hesapları
   - Yabancı platformlarla sözleşmeler (Amuse, Spotify, Apple Music, Epidemic Sound, Kobalt, AWAL)
4. **İş hukuku** — 4857 İK + 6356 STİSK + 5510 SGK
   - Açık iş davaları (arabuluculuk + İş Mahkemesi)
   - Kıdem-ihbar tazminatı yükümlülükleri
   - Mobbing ve sendikal hak iddiaları
   - Sanatçı-yapımcı ilişkisinde gizli iş akdi argümanı
5. **Vergi** — VUK 213 + GVK 193 + KVK 5520 + KDV 3065 + ÖTV
   - Vergi inceleme raporları
   - Uzlaşma tutanakları
   - GİB özelgeleri (yargi_mcp `search_gib_ozelge`)
   - Vergi mahkemesi davaları
6. **KVKK uyumu** — KVKK 6698 + GDPR 679/2016
   - VERBİS kayıt durumu
   - Veri envanteri
   - Aydınlatma metni ve açık rıza altyapısı
   - Veri ihlali bildirimleri (m.12/5 — 72 saat)
   - Yurt dışı aktarım (Schrems II + KVKK m.9)
7. **Rekabet hukuku** — RKHK 4054
   - Birleşme/devralma bildirim eşiği kontrolü (2024 sayılı Tebliğ)
   - Açık Rekabet Kurulu soruşturmaları
   - Dikey/yatay anlaşma riskleri
8. **MASAK uyumu** — 5549 sayılı Kanun
   - Suç gelirlerinin aklanması iç düzenlemeleri
   - Şüpheli işlem bildirim altyapısı
9. **Sektörel düzenleme** (uygulanabilirse)
   - RTÜK (yayıncılık)
   - BTK (elektronik haberleşme)
   - BDDK (bankacılık)
   - SPK (halka açık şirket — pasif modül)
   - EPDK (enerji)

### 3.2. Material Contract Tanımı (Türk usulü)

Bir sözleşme aşağıdakilerden **herhangi birini** karşılıyorsa **material** sayılır:

- Yıllık değeri > 500.000 TL
- Şirketin yıllık cirosunun > %5'i
- Münhasırlık veya non-compete içeriyor (süresi 12 ayı aşan)
- Change-of-control / kontrol değişikliği klozu var
- IP/telif devri veya münhasır lisans içeriyor (FSEK m.48-52)
- Kişiye sıkı sıkıya bağlı haklar içeriyor (BK m.83 — sözleşmenin devri)
- Yabancı mahkeme yetki / hakem klozu içeriyor (MÖHUK m.47)
- Cezai şart > 100.000 TL (TBK m.179-182)
- Sanatçı sözleşmesinde: kayıt süresi > 3 yıl, royalty oranı < %15, ileride yapılacak eserler sınırlandırılmamış (FSEK m.51)

### 3.3. Closing Checklist Türk Usulü

`closing-checklist` skill'i şu kanonik adım grubuna göre çalışacak:

| Faz | Adımlar |
|-----|---------|
| **Imza öncesi** | (a) Esas sözleşme tadili taslağı; (b) hisse devri sözleşmesi (TTK m.490); (c) Rekabet Kurulu birleşme bildirimi (Tebliğ 2010/4); (d) sektörel onaylar (BTK/BDDK/RTÜK vb.); (e) KVKK uyum auditi |
| **İmza** | (a) Hisse devri / varlık devri sözleşmesi; (b) Yan sözleşmeler (escrow, transition services); (c) Yönetim kurulu / GK kararları |
| **Kapanış** | (a) Pay defterine işleme; (b) Ticaret Sicil tescili (TTK m.30); (c) MERSİS güncelleme; (d) Banka hesap yetkilendirme değişiklikleri; (e) Vergi dairesi bildirim; (f) SGK bildirim |
| **Kapanış sonrası** | (a) VERBİS güncellemesi; (b) İmza sirküleri yenileme; (c) Yıllık faaliyet raporuna işleme (TTK m.516); (d) Müvekkil özet brief |

---

## 4. Entity Management Modülü — Türk Takvimi

`entity-compliance` skill'i her şirket için aşağıdaki takvimi otomatik üretir:

### 4.1. Yıllık Tekrar Eden Yükümlülükler

| Yükümlülük | Mevzuat | Son tarih |
|-----------|---------|-----------|
| Olağan Genel Kurul | TTK m.409 | Faaliyet dönemini izleyen 3 ay (genelde 31 Mart) |
| TTK m.376 öz kaynak kontrolü | TTK m.376 | Her bilanço çıkarımında |
| Bağımsız denetim atama | TTK m.397/4 + Bakanlar Kurulu eşik | GK'da yıllık |
| Yıllık faaliyet raporu | TTK m.516 | GK'dan önce |
| Kurumlar Vergisi Beyannamesi | KVK m.14 | 30 Nisan |
| KDV Beyannamesi | KDVK m.41 | Her ayın 28'i |
| Muhtasar ve Prim Hizmet Beyannamesi | VUK + 5510 | Her ayın 26'sı |
| Geçici Vergi | GVK Mük. m.120 | Çeyrek dönem +14 gün |
| Damga Vergisi | DVK | İşlem anında |
| VERBİS güncelleme | KVKK m.16 + Yönetmelik | Yıllık veya değişiklikte |
| BAĞ-KUR / SGK bildirimi | 5510 | Aylık |
| MERSİS bilgi güncelleme | TTK m.24 | Değişiklikte 15 gün içinde |

### 4.2. Olay Tetiklemeli Yükümlülükler

| Olay | Yapılması gereken | Mevzuat |
|------|---------------------|---------|
| Sermaye artışı/azaltışı | GK kararı + Ticaret Sicil tescili | TTK m.456, 473 |
| Esas sözleşme değişikliği | GK + tescil + Türkiye Ticaret Sicil Gazetesi | TTK m.452 |
| YK üye değişikliği | Tescil 15 gün içinde | TTK m.359 |
| Adres değişikliği | MERSİS + tescil | TTK m.40 |
| Pay devri (LLC) | Pay defteri + GK onayı (esas sözleşme aksini öngörmemişse) | TTK m.595 |
| Tasfiye kararı | GK + tasfiye memuru tayini + tescil + üç ilan | TTK m.526-548 |

---

## 5. Onay Matrisi (Escalation)

Aşağıdaki olaylar **kıdemli avukat onayı** olmadan müvekkile/karşı tarafa gönderilemez:

1. Yıllık değeri > 1.000.000 TL sözleşme inceleme çıktısı
2. FSEK m.48-52 kapsamında mali hak devri içeren herhangi bir sözleşme
3. Sanatçı sözleşmesinde "kazanılmış haklardan vazgeçme" içeren klozlar
4. KVKK Kurul'a verilecek savunma
5. Rekabet Kurulu'na verilecek bildirim/savunma
6. Yargıtay/AYM/AİHM'e gidecek dilekçe
7. Cezai sorumluluk doğurabilecek herhangi bir beyan

---

## 6. UYAP Atıf Standardı

Tüm plugin çıktıları aşağıdaki kanonik atıf formatını kullanır:

### 6.1. Mevzuat

```
Türk Ticaret Kanunu (6102 sayılı), m. 376/1
Türk Borçlar Kanunu (6098 sayılı), m. 49 vd.
Fikir ve Sanat Eserleri Kanunu (5846 sayılı), m. 48
Hukuk Muhakemeleri Kanunu (6100 sayılı), m. 119/1-(ğ)
```

### 6.2. Yargı Kararları

```
Yargıtay 11. HD, E. 2023/1234, K. 2024/5678, T. 15.03.2024
Yargıtay HGK, E. 2022/(11)-456, K. 2023/789, T. 20.06.2023
Danıştay 7. D., E. 2024/1111, K. 2025/2222, T. 10.01.2025
AYM, B.No: 2023/12345, T. 14.05.2024 (bireysel başvuru)
AYM, E. 2023/45, K. 2024/12, T. 20.03.2024 (norm denetimi)
AİHM, Aydın v. Türkiye, B.No: 23456/20, T. 15.01.2024
Uyuşmazlık Mahkemesi, E. 2024/12, K. 2024/34, T. 05.02.2024
```

### 6.3. İdari Kararlar

```
KVKK Kurul Kararı, 2024/123, T. 15.03.2024
Rekabet Kurulu Kararı, 24-12/123-45, T. 20.03.2024
GİB Özelgesi, B.07.1.GİB.4.34.16.01-..., T. 10.01.2025
SPK Bülteni, 2024/12, T. 25.03.2024
RTÜK Kararı, 2024/...
```

### 6.4. AB Mevzuatı

```
GDPR (Tüzük 2016/679/AB), m. 17/1
DSM Direktifi (2019/790/AB), m. 17(4)(b)
EU AI Act (Tüzük 2024/1689/AB), m. 6 ve Ek III
DSA (Tüzük 2022/2065/AB), m. 16
ABAD, C-311/18 (Schrems II), T. 16.07.2020
```

> **Magesh ve ark. (2025) anti-halüsinasyon kuralı:** Her atıf, dilekçe gönderilmeden önce `yargi_mcp` veya `mevzuat_mcp` ile doğrulanır. "Misattributed authorship", "mishandled hierarchy" ve "fabricated citation" hataları yapısal olarak önlenir.

---

## 7. MCP Connector Entegrasyon Haritası

Plugin'in her skill'i hangi connector'ı çağıracağını biliyor:

| Skill | Birincil connector | İkincil connector |
|-------|-------------------|------------------|
| `diligence-issue-extraction` | yargi_mcp + mevzuat_mcp | hukuk_rag (müvekkil dosya tabanı) |
| `material-contract-schedule` | mevzuat_mcp (`search_kanun` — TTK, BK, FSEK) | literatur_mcp (doktrin) |
| `closing-checklist` | mevzuat_mcp (`search_kurum_yonetmelik` — Ticaret Sicil Yön., Tebliğ) | yargi_mcp (Rekabet Kurulu emsali) |
| `entity-compliance` | mevzuat_mcp (TTK, VUK, KVKK Yön.) | yargi_mcp (`search_gib_ozelge`) |
| `tabular-review` | hukuk_rag (sözleşme corpus) | yargi_mcp (klauz emsali) |
| `deal-team-summary` | yok (kendi çıktısı) | — |
| `integration-management` | mevzuat_mcp (post-kapanış mevzuat) | yargi_mcp (entegrasyon emsali) |
| `written-consent` | mevzuat_mcp (TTK m.390/4) | yoktez_mcp (toplantısız karar tezleri) |
| `board-minutes` | mevzuat_mcp (TTK m.390-391) | — |

### 7.1. Çapraz Doğrulama Kuralı

Aşağıdaki olaylarda iki connector zorunlu çapraz teyit:

- **Yargıtay kararı atıfı** → yargi_mcp + bedesten (`search_bedesten_unified`) çakışma kontrolü
- **Mevzuat madde atıfı** → mevzuat_mcp `search_kanun` + `get_mevzuat_madde_tree`
- **Doktrin atıfı** → literatur_mcp + yoktez_mcp (akademik ağırlık kontrolü)
- **Vergi özelgesi** → yargi_mcp `search_gib_ozelge` + GİB resmi sitesi (WebFetch)

---

## 8. Cross-Plugin Handoff Matrisi

Plugin'ler arası iş bölümü:

| Tetikleyici | corporate-legal skill'i | Handoff edilen plugin/skill |
|-------------|------------------------|----------------------------|
| Diligence'ta KVKK uyumsuzluğu | `diligence-issue-extraction` | **privacy-legal:pia-generation** + `dsar-response` (eğer açık DSAR varsa) |
| Diligence'ta açık tüketici davası | `diligence-issue-extraction` | **turk-hukuk-legal:yargi-yolu-secimi** + `dava-strateji-analiz` |
| Diligence'ta FSEK / SMK ihlali | `diligence-issue-extraction` | **turk-hukuk-legal:tecavuz-triyaj** + `ihtarname-fsek-smk` |
| Diligence'ta sanatçı sözleşmesi | `tabular-review` | **turk-hukuk-legal:sanatci-sozlesme-inceleme** + `fikri-haklar-klozu-inceleme` |
| Diligence'ta AB iştiraki / GDPR | `diligence-issue-extraction` | **ai-governance-legal:ai-inventory** + **privacy-legal:reg-gap-analysis** |
| Diligence'ta İsveçli platform sözleşmesi (Amuse, Epidemic Sound, Kobalt) | `tabular-review` | **swedish-music-law** skill'i |
| Kapanış sonrası entegrasyon uyuşmazlığı | `integration-management` | **turk-hukuk-legal:dilekce-ihtarname** + `dava-strateji-analiz` |
| Yönetim kurulu kararı taslağı | `written-consent` / `board-minutes` | **turk-hukuk-legal:uyap-atif-formati** (atıf normalizasyonu için) |
| Müvekkile final brief | `deal-team-summary` | **turk-hukuk-legal:docx-uretici** (UYAP-formatlı .docx çıktısı) |
| Rebuttal hazırlığı (yüksek riskli işlem) | herhangi bir skill | **cocounsel-legal:predictive-rebuttal-engine** (PAC-7) |

---

## 9. HMK / Usul Standartları

Plugin'in çıkardığı her dilekçe / yazışma şu usul kontrolünden geçer:

| Belge tipi | Şekil kuralı | Yasal dayanak |
|-----------|--------------|---------------|
| Dava dilekçesi | Mahkeme, taraflar, dava değeri, vakıalar, deliller, hukuki sebepler, talep, imza | HMK m.119 |
| Cevap dilekçesi | 2 hafta kesin süre, vakıalara cevap, def'i ve itirazlar, deliller, hukuki sebepler | HMK m.127, 129 |
| Replik | Cevaba cevap, 2 hafta | HMK m.136 |
| Düplik | Repliğe cevap, 2 hafta | HMK m.136 |
| İstinaf dilekçesi | 2 hafta tebliğden, gerekçe + talep + harç | HMK m.342, 345 |
| Temyiz dilekçesi | 2 hafta BAM kararından, sınırlı hukuki sebep | HMK m.361, 364 |
| İhtarname | Noter veya KEP/iadeli taahhütlü, açık talep + makul süre | TBK m.117, Noterlik K. m.60 |
| KEP tebligatı | Kayıtlı Elektronik Posta zorunluluğu (tüzel kişi avukat) | Tebligat K. m.7/a |

### 9.1. Süre Hesabı

Tüm süreler `turk-hukuk-legal:siure-hesap-motoru` skill'i ile **çapraz hesaplanır**:
- HMK m.92-104 sürelerin hesaplanması
- HMK m.102 adli tatil (20 Temmuz - 31 Ağustos)
- Resmi tatil + hafta sonu kaydırması (HMK m.93)
- Hak düşürücü süre ↔ zamanaşımı ayrımı

---

## 10. AB Hukuku Katmanı

AB iştiraki, AB müvekkili veya cross-border işlem söz konusuysa şu katman otomatik açılır:

### 10.1. Temel AB Mevzuat Referans Tablosu

| AB Düzenlemesi | Türk paraleli | corporate-legal'da işlenme |
|---------------|--------------|----------------------------|
| GDPR (2016/679) | KVKK 6698 | `diligence-issue-extraction` KVKK kategorisi |
| DSM Direktifi (2019/790), m.17-23 | FSEK 5846 (telif ve bağlantılı haklar) | `material-contract-schedule` IP kategorisi |
| EU AI Act (2024/1689) | KVKK + 6502 TKHK | `ai-governance-legal:ai-inventory`a handoff |
| DSA (2022/2065) | 5651 sayılı Kanun | İçerik kaldırma → `turk-hukuk-legal:icerik-kaldirma-bildirim` |
| Schrems II / SCC | KVKK m.9 yurt dışı aktarım | DPA inceleme → `privacy-legal:dpa-review` |
| EU Merger Regulation (139/2004) | RKHK 4054 + Tebliğ 2010/4 | `closing-checklist` Rekabet Kurulu kontrolü |
| EU Whistleblower Direktifi (2019/1937) | İK + KVKK (Türkiye'de doğrudan karşılık yok) | İç ihbar mekanizması incelemesi |
| ESRS / CSRD (2022/2464) | KGK Sürdürülebilirlik Standartları | Yıllık faaliyet raporu |

### 10.2. Cross-Border İşlemlerde Zorunlu Kontrol Listesi

- [ ] MÖHUK m.24 — sözleşme statüsü
- [ ] MÖHUK m.47 — yetki sözleşmesi geçerliliği
- [ ] Rome I Regulation (593/2008) — AB tarafında hangi hukuk uygulanacak
- [ ] New York Konvansiyonu — yabancı tahkim kararlarının tanınması
- [ ] KVKK m.9 + GDPR Bölüm V — veri aktarımı meşru zemini (SCC, BCR, adequacy)
- [ ] AB Rekabet Hukuku eşik kontrolü (EUMR Art. 1)
- [ ] FDI Screening (2019/452/AB) — yabancı yatırım denetimi

---

## 11. Risk Tutumu (Agresif Profil Uygulaması)

**Tüm çıktılarda uyulacak ton kuralları:**

- Müvekkil aleyhine yorumlanabilecek ifadeler **yumuşatılmaz**; ancak HMK m.29 (dürüstlük) sınırı aşılmaz.
- Müzakere pozisyonu: ilk teklif daima müvekkilin maksimum talep edilebilir hakkıyla yapılır; geri çekilme alanı önceden tanımlanır.
- Sözleşme inceleme: **kabul edilebilir değil** denilen klozlar için **mutlaka alternatif metin** önerilir, sadece "sapma" işaretlenmez.
- Dilekçede: rakip iddialar **ezilir**, kötü niyet ve usuli hata varsa **açıkça öne çıkarılır** (HMK m.29/2 + 50/1).
- İhtarnamede: cezai sorumluluk ve haksız fiil tazminatı (BK m.49 vd.) **gerektiğinde** açıkça uyarılır.
- Cross-border'da: yabancı mahkeme yetki klozu **daima itiraz noktası** olarak değerlendirilir (MÖHUK m.47 + TKHK m.3 — tüketici lehine).
- Yargıtay kararı: lehe içtihat kalın puntoyla; aleyhe içtihat distinguishability ile **önceden** çürütülür (Toulmin rebuttal mantığı).

---

## 12. Plugin Kullanımına Başlamadan Önce Gereken Bilgi

Her yeni dava/işlem için aşağıdakiler **mutlaka** dolduralacak (matter-workspace skill'i ile):

1. **Müvekkil kimlik / TCKN-VKN** + iletişim
2. **Karşı taraf** kimlik + iletişim
3. **İşlem/dava türü** (M&A, sözleşme inceleme, dava, ihtarname vb.)
4. **Yetkili mahkeme** (HMK m.5-19 / İYUK m.32)
5. **Görevli mahkeme** (HMK m.1-4 / İYUK m.5)
6. **Müvekkil amacı** (savunma, saldırı, müzakere, uzlaşı)
7. **Kritik süreler** (zamanaşımı, hak düşürücü süre, sözleşmesel)
8. **Mevcut belgeler** (hukuk_rag'a yüklenecek)
9. **Risk profili** (düşük / orta / yüksek)
10. **Müvekkil bütçesi** (yargılama gideri + vekalet ücreti)

---

## 13. Çıktı Formatı

Tüm plugin çıktıları aşağıdaki şablona göre üretilir:

```
[BAŞLIK] — [DAVA/İŞLEM No]

§1. ÖZET (3-5 cümle, müvekkil dostu dil)
§2. OLGULAR (tarih sıralı, kaynak dipnotlu)
§3. HUKUKİ İNCELEME (UYAP atıf formatlı)
§4. RİSKLER (yüksek / orta / düşük; rebuttal hazırlığı)
§5. ÖNERİ / EYLEM PLANI (somut adımlar + sorumlular + süreler)
§6. EKLER VE KAYNAKLAR (yargi_mcp / mevzuat_mcp / literatur_mcp kayıtları)
```

Final çıktı **.docx** olarak `turk-hukuk-legal:docx-uretici` skill'i üzerinden UYAP standardına yakın formatta (Times New Roman 12pt, 1.5 satır aralığı, 2.5cm kenar boşlukları) üretilir.

---

## 14. Plugin Güvenlik Kuralları

1. **Hiçbir dilekçe / ihtarname / resmi yazışma kullanıcı onayı olmadan gönderilmez.**
2. **Her atıf gönderim öncesi mevzuat_mcp + yargi_mcp ile teyit edilir** (Magesh kalkanı).
3. **Müvekkil sırrı (Av.K. m.36)** — hiçbir müvekkil bilgisi profil dosyasına yazılmaz; matter-workspace altında tutulur.
4. **KVKK uyumu** — kişisel veri içeren tüm çıktılar VERBİS'e kayıtlı işleme amacıyla sınırlıdır.
5. **Magesh anti-halüsinasyon** — yüksek riskli işlemlerde `cocounsel-legal:phase6-magesh-anti-halusinasyon-kalkani` zorunlu gate.

---

## 15. Versiyon Notu ve Bakım

- **v1.0 — 19 Mayıs 2026:** İlk Türk/AB hukuku eksenli uyarlama. Sanatçı/yapımcı müvekkil profili.
- **Bakım:** Plugin çıktısında karşılaşılan eksiklik veya yanlışlıkta `corporate-legal:customize` skill'i ile bu dosya güncellenebilir.
- **Cold-start tekrarı:** Müvekkil profili veya modül seti değişirse `corporate-legal:cold-start-interview --redo` ile yeniden kurulabilir.

---

*Bu profil dosyası, Cowork mode tarafından `corporate-legal` plugin'inin tüm skill'leri tarafından okunur ve çıktıların kanonik referansını oluşturur. Profil değiştirilmeden plugin çıktıları "generic" düzeyde kalır.*
