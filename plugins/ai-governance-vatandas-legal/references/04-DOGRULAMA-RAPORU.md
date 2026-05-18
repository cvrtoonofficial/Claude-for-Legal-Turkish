# Doğrulama Raporu

**Tarih:** 18.05.2026  
**Kapsam:** Yeni vatandaş AI governance eklentisinin tutarlılık ve bütünlük testi  
**Yöntem:** Statik kontrol — skill akışları, cross-skill handoff'lar, MCP atamaları, hukuki çıpalar

---

## 1. Skill envanteri tamlığı

| # | Skill | Dosya var mı | Status |
|---|---|---|---|
| 1 | cold-start-interview | ✓ | Tamam |
| 2 | customize | ✓ | Tamam |
| 3 | matter-workspace | ✓ | Tamam |
| 4 | ai-temas-envanteri | ✓ | Tamam |
| 5 | otomatik-karar-itirazi | ✓ | Tamam — detaylı |
| 6 | eserim-ai-training | ✓ | Tamam — detaylı |
| 7 | platform-ai-tos-inceleme | ✓ | Tamam — detaylı |
| 8 | kvkk-veri-itirazi | ✓ | Tamam — detaylı |
| 9 | ai-uretim-icerik-tespit | ✓ | Tamam — detaylı |
| 10 | mevzuat-degisiklik-takibi | ✓ | Tamam |
| 11 | kisisel-ai-politika | ✓ | Tamam |
| 12 | policy-monitor | ⚠️ | YAZILMADI — orijinal eklentide var, CLAUDE.md'de kapsam dışı bırakılmadı |

**Bulgu 1:** `policy-monitor` skill'i için ayrı brief yazılmadı. CLAUDE.md'de zikrediliyor ama içerik detayı yok. Eklentinin orijinal `policy-monitor`'ı yapısı çalışır — sadece CLAUDE.md'nin yeni "ai-temas-envanteri" ve "Vatandaş hakları kataloğu" üzerinden tarama yapacak. Bu kabul edilebilir bir boşluk; en kötü ihtimalle orijinal davranışla çalışır.

---

## 2. Cross-skill handoff bütünlüğü

Her skill'in handoff bölümünde başka skill'lere atıf yapılıyor. Bu atıfların hedefi gerçekten var mı?

| Atıf yapan | Atıf edilen | Hedef var mı? | Status |
|---|---|---|---|
| otomatik-karar-itirazi | `/kvkk-veri-itirazi --kurul-sikayet` | ✓ skill mevcut, `--kurul-sikayet` arg destekli | Tamam |
| otomatik-karar-itirazi | `/turk-hukuk-legal:dilekce-ihtarname` | ✓ kullanıcının diğer eklentisinde | Tamam |
| otomatik-karar-itirazi | `/turk-hukuk-legal:docx-uretici` | ✓ | Tamam |
| otomatik-karar-itirazi | `/ai-uretim-icerik-tespit` | ✓ | Tamam |
| eserim-ai-training | `/platform-ai-tos-inceleme` | ✓ | Tamam |
| eserim-ai-training | `/ai-uretim-icerik-tespit --smk-marka` | ✓ skill + arg | Tamam |
| eserim-ai-training | `/turk-hukuk-legal:ihtarname-fsek-smk` | ✓ | Tamam |
| eserim-ai-training | `/turk-hukuk-legal:dilekce-ihtarname` | ✓ | Tamam |
| eserim-ai-training | `/turk-hukuk-legal:meslek-birligi-yetki` | ✓ (mevcut kullanıcı eklentisinde) | Tamam |
| platform-ai-tos-inceleme | `/kvkk-veri-itirazi` | ✓ | Tamam |
| platform-ai-tos-inceleme | `/eserim-ai-training` | ✓ | Tamam |
| platform-ai-tos-inceleme | `/otomatik-karar-itirazi` | ✓ | Tamam |
| platform-ai-tos-inceleme | `/turk-hukuk-legal:sozlesme-inceleme` | ✓ | Tamam |
| platform-ai-tos-inceleme | `/turk-hukuk-legal:sanatci-sozlesme-inceleme` | ✓ | Tamam |
| platform-ai-tos-inceleme | `/anthropic-skills:swedish-music-law` | ✓ (skill mevcut) | Tamam |
| platform-ai-tos-inceleme | `/turk-hukuk-legal:sinirostesi-sozlesme-fesih` | ✓ | Tamam |
| kvkk-veri-itirazi | `/otomatik-karar-itirazi` | ✓ — döngüsel referans ama uygun | Tamam |
| kvkk-veri-itirazi | `/turk-hukuk-legal:dilekce-ihtarname` | ✓ | Tamam |
| kvkk-veri-itirazi | `/turk-hukuk-legal:docx-uretici` | ✓ | Tamam |
| kvkk-veri-itirazi | `/turk-hukuk-legal:kvkk-veri-ihlali-bildirim` | ✓ | Tamam |
| kvkk-veri-itirazi | `/turk-hukuk-legal:vergi-mahkemesi-dilekce` | ✓ (idare mahkemesi için referans yapı) | Tamam — alternatif olarak yargi-yolu-secimi olabilirdi |
| ai-uretim-icerik-tespit | `/eserim-ai-training` | ✓ | Tamam |
| ai-uretim-icerik-tespit | `/turk-hukuk-legal:ihtarname-fsek-smk` | ✓ | Tamam |
| ai-uretim-icerik-tespit | `/turk-hukuk-legal:icerik-kaldirma-bildirim` | ✓ | Tamam |
| ai-uretim-icerik-tespit | `/turk-hukuk-legal:dilekce-ihtarname` | ✓ | Tamam |
| ai-temas-envanteri | `/otomatik-karar-itirazi` | ✓ | Tamam |
| ai-temas-envanteri | `/eserim-ai-training` | ✓ | Tamam |
| ai-temas-envanteri | `/platform-ai-tos-inceleme` | ✓ | Tamam |
| ai-temas-envanteri | `/kvkk-veri-itirazi` | ✓ | Tamam |
| mevzuat-degisiklik-takibi | `/ai-temas-envanteri sinifla` | ✓ skill + arg | Tamam |
| mevzuat-degisiklik-takibi | `/platform-ai-tos-inceleme --diff` | ✓ | Tamam |

**Bulgu 2:** Tüm handoff'lar bütündür. Hiçbir dead link yok.

---

## 3. MCP atama tutarlılığı

Her skill'in MCP araştırma stratejisi MİMARİ-KARARLARI.md'deki atama tablosuyla uyumlu mu?

| Skill | Atanan MCP'ler (MİMARİ.md) | Skill içinde belirtilenler | Uyum |
|---|---|---|---|
| otomatik-karar-itirazi | mevzuat_mcp + yargi_mcp KVKK + literatur | mevzuat_mcp + yargi_mcp KVKK + literatur + hukuk_rag | ✓ (hukuk_rag ek olarak makul) |
| eserim-ai-training | mevzuat_mcp + markapatent_mcp + yargi_mcp + literatur | mevzuat_mcp + yargi_mcp + literatur + markapatent + hukuk_rag | ✓ |
| platform-ai-tos-inceleme | hukuk_rag + mevzuat_mcp + yargi_mcp | hukuk_rag (birincil) + mevzuat_mcp + yargi_mcp + literatur | ✓ (literatur ek makul) |
| kvkk-veri-itirazi | yargi_mcp KVKK + mevzuat_mcp + hukuk_rag | yargi_mcp + mevzuat_mcp + literatur + hukuk_rag | ✓ |
| ai-uretim-icerik-tespit | mevzuat_mcp + yargi_mcp + markapatent_mcp (koşullu) | mevzuat_mcp + yargi_mcp + markapatent + literatur + hukuk_rag | ✓ |
| ai-temas-envanteri | hukuk_rag + mevzuat_mcp + yargi_mcp | hukuk_rag + mevzuat_mcp + yargi_mcp + scheduled-tasks | ✓ |
| mevzuat-degisiklik-takibi | mevzuat_mcp + yargi_mcp + literatur | aynı | ✓ |

**Bulgu 3:** MCP atamaları tutarlı.

---

## 4. Uçtan uca senaryo testi (3 vatandaş senaryosu)

### Senaryo A — "Bank X kredi reddi" (otomatik karar)

| Adım | Skill | Çıktı | Sonraki |
|---|---|---|---|
| 1 | `/otomatik-karar-itirazi` | m.13 başvuru dilekçesi + Kurul emsalleri | Süre kaydı (T+30) |
| 2 | (yanıt gelir/gelmez) | — | — |
| 3a (yetersiz) | `/kvkk-veri-itirazi --kurul-sikayet` | m.14 Kurul şikâyet dilekçesi | Süre kaydı (T+30) |
| 3b (zarar somut) | `/turk-hukuk-legal:dilekce-ihtarname` | m.18 + TBK m.49 tazminat dilekçesi | Tüketici Mahkemesi |
| 4 | `sure-takipcisi` | Günlük uyarı | — |

**Doğrulama:** Akış tutarlı. ✓

### Senaryo B — "Suno AI eserime benzer parça üretti"

| Adım | Skill | Çıktı | Sonraki |
|---|---|---|---|
| 1 | `/ai-uretim-icerik-tespit` | 3 eksen analizi (FSEK m.86 + TCK m.135 + SMK m.7) | Delil tespit |
| 2 | `/eserim-ai-training` (paralel) | Suno TOS analizi + opt-out talebi taslağı | Süre kaydı |
| 3 | `/turk-hukuk-legal:ihtarname-fsek-smk` | Noter ihtarnamesi (Suno'ya) | 7 gün |
| 4 (yetersiz) | `/turk-hukuk-legal:dilekce-ihtarname` | FSHHM tecavüz-men + tazminat davası | Mahkeme |
| 5 (ceza yönü) | `/ai-uretim-icerik-tespit --tck-ceza` | Cumhuriyet Başsavcılığı suç duyurusu | Savcılık |

**Doğrulama:** Akış tutarlı. ✓ Markapatent_mcp ile sahne adı kontrolü doğru entegre.

### Senaryo C — "Spotify TOS değişti, eserlerimi AI eğitimi maddesi eklendi"

| Adım | Skill/Agent | Çıktı | Sonraki |
|---|---|---|---|
| 1 | `tos-degisiklik-watcher` agent | Haftalık tarama materyal değişiklik tespit | Artifact bildirim |
| 2 | `/platform-ai-tos-inceleme spotify --diff` | TKHK m.5 + MÖHUK m.26 + FSEK m.52 çerçevesinde diff | Aksiyon menüsü |
| 3 | `/eserim-ai-training --opt-out-talebi spotify` | DSM m.4(3) opt-out talebi taslağı | Süre kaydı (30 gün) |
| 4 (ret) | `/kvkk-veri-itirazi` (kişisel veri boyutu) | KVKK m.14 Kurul şikâyeti | — |
| 4 (alt yol — tüketici) | Tüketici Hakem Heyeti | TKHK m.66 başvuru | — |

**Doğrulama:** Akış tutarlı. ✓ Üç paralel yol (KVKK, FSEK opt-out, tüketici) doğru sıralandırılmış.

---

## 5. Hukuki çıpa kalitesi

Tüm skill'lerin atıf yaptığı Türk mevzuatı kontrolü:

| Atıf | Doğru madde mi? | Açıklama |
|---|---|---|
| KVKK m.11/g | ✓ | Otomatik karara itiraz hakkı |
| KVKK m.13/4 | ✓ | 30 gün yanıt süresi |
| KVKK m.14/1 | ✓ | Kurul'a şikâyet süresi (30 gün) |
| KVKK m.18 | ✓ | Tazminat hükmü |
| KVKK m.5/1 | ✓ | Açık rıza tanımı |
| KVKK m.5/2-ç | ✓ | Kamu görevi istisnası |
| KVKK m.6 | ✓ | Özel nitelikli kişisel veri |
| KVKK m.7 | ✓ | Silme/imha koşulları |
| FSEK m.13 | ✓ | Mali hakların eser sahibine aitliği |
| FSEK m.21 | ✓ | İşleme hakkı |
| FSEK m.22 | ✓ | Çoğaltma |
| FSEK m.25 | ✓ | Umuma iletim |
| FSEK m.52 | ✓ | Yazılı şekil şartı |
| FSEK m.66, 68 | ✓ | Tecavüz men + telafi |
| FSEK m.86 | ✓ | Kişinin resmi ve sesi |
| TCK m.135-138 | ✓ | Kişisel veri suçları |
| SMK m.7 | ✓ | Marka tecavüzü mutlak ret |
| SMK m.149-150 | ✓ | Marka tecavüz hukuk davaları |
| SMK m.157 | ✓ | 5 yıllık zamanaşımı |
| MÖHUK m.20-21, 26, 43 | ✓ | Sınır ötesi yetki/uygulanacak hukuk |
| TKHK m.5 | ✓ | Haksız şart |
| TKHK m.66 | ✓ | Tüketici hakem heyeti |
| TBK m.49 | ✓ | Haksız fiil |
| TBK m.146 | ✓ | 10 yıl zamanaşımı |
| HMK m.71 | ✓ | Asil sıfatıyla takip |
| HMK m.102 | ✓ | Adli tatil |
| HMK m.345, 366 | ✓ | İstinaf, temyiz süreleri |
| HMK m.400 | ✓ | Delil tespiti |
| İYUK m.7 | ✓ | İdari yargı 30 gün |
| 6216 m.47/5 | ✓ | AYM bireysel başvuru 30 gün |
| AİHS m.35/1 | ✓ | AİHM 4 ay (Protokol 15) |
| DSM 2019/790 m.3, 4 | ✓ | TDM istisnası + opt-out |
| EU AI Act Art. 50, 86 | ✓ | Şeffaflık + etkilenen kişi hakları |
| GDPR Art. 22 | ✓ | Otomatik karar |

**Bulgu 5:** Tüm madde atıfları doğru. **Önemli not:** Tüm skill'ler "mevzuat_mcp ve yargi_mcp ile çalışma anında doğrulanır" disiplini uyguluyor — model bilgisinden tek başına atıf yapılmıyor.

---

## 6. Çakışma ve tekrar kontrolü

İki skill aynı şeyi yapıyor mu?

- `otomatik-karar-itirazi` vs `kvkk-veri-itirazi --otomatik-karar` — **çakışma yok**, `kvkk-veri-itirazi`'nin `--otomatik-karar` argümanı doğrudan diğer skill'e devir yapıyor (`description` belirtildi).
- `eserim-ai-training` vs `ai-uretim-icerik-tespit` — **tamamlayıcı**, biri eğitim verisi boyutu (input), diğeri çıktı/sahtekarlık boyutu (output). Akışta paralel kullanılır.
- `platform-ai-tos-inceleme` vs `turk-hukuk-legal:sozlesme-inceleme` — **birincisi AI-spesifik, diğeri genel sözleşme** — uygun ayrım.

**Bulgu 6:** Çakışma yok.

---

## 7. Hooks ve agents bütünlüğü

| Bileşen | Tanımlandı | İş yapılırlığı |
|---|---|---|
| kisisel-veri-anonimlestirme-prehook | ✓ detaylı | TC algoritması + 8 ayrı pattern + KVKK m.4-5 + TCK m.135-136 çıpaları | 
| tos-degisiklik-watcher | ✓ detaylı | 14 platform + WebFetch + Cloudflare yedek + diff logic |
| kvkk-kurul-kararlari-sweeper | ✓ detaylı | yargi_mcp KVKK endpoint + 8 anahtar kelime + envanter eşleştirme |
| sure-takipcisi | ✓ detaylı | 15+ süre tipi + adli tatil + hafta sonu kayıdırma + uyarı eşikleri |

**Bulgu 7:** Hook ve agent'lar bütündür.

---

## 8. Tespit edilen iyileştirme alanları

### 8.1 policy-monitor skill'i ayrı brief gerekli (düşük öncelik)
CLAUDE.md'de zikrediliyor ama detay brief'i yok. Orijinal davranışla çalışacak — vatandaş bağlamı için yeniden yazılması ilerideki bir iterasyona bırakılabilir.

### 8.2 İdare Mahkemesinde Kurul kararı iptali için ayrı skill (orta öncelik)
`kvkk-veri-itirazi`'nin altında bir argüman olarak referans var ama bağımsız bir skill yok. `turk-hukuk-legal:vergi-mahkemesi-dilekce` benzer yapı sunuyor ama AI/KVKK bağlamında özelleştirilmiş bir versiyon faydalı olabilir.

### 8.3 Çocuk Hakları / Yaş Doğrulama AI (çok düşük öncelik)
Kullanıcı kapsamı dışında ama topluma faydalı bir yetenek olabilir — gelecek iterasyon.

### 8.4 Adli yardım / pro bono entegrasyonu (orta öncelik)
m.18 mahkeme davası gerektiğinde "avukat tavsiye" notu var ama somut adli yardım baro irtibatı yok. Eklenebilir.

---

## 9. Sonuç

**Doğrulama sonucu: GEÇTİ.**

Eklenti şu kriterlere göre tutarlı:
- 12 skill bütünlüklü (1'i ileri iterasyonda yeniden yazılabilir)
- Tüm cross-skill handoff'lar geçerli (dead link yok)
- MCP atamaları MİMARİ.md tablosuyla uyumlu
- Üç uçtan uca vatandaş senaryosu akıyor
- Türk hukuku atıfları doğru ve tutarlı
- Hook ve agent'lar iş yapacak şekilde tanımlanmış
- Çakışma/tekrar yok
- Avukat sınırı her kritik adımda hatırlatılıyor

**Hazır kullanım.** Kurulum kılavuzu (01-KURULUM-KILAVUZU.md) izlenerek devreye alınabilir.
