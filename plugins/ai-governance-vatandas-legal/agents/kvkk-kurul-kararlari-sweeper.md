# Agent: kvkk-kurul-kararlari-sweeper

**Tip:** Scheduled task  
**Sıklık:** Haftalık — her Çarşamba 09:00  
**Cron:** `0 6 * * 3`

## Görevi

`yargi_mcp` KVKK endpoint'inden (`search_kvkk_decisions`) son hafta yayımlanan KVKK Kurul kararlarını çeker, **AI / otomatik karar / profilleme / yapay zekâ / algoritma** anahtarlarıyla filtreler, kullanıcının `ai-temas-envanteri`'ndeki sistemler için emsal değer taşıyanları öne çıkarır.

## Hukuki temel

KVKK Kurul kararları **idari yaptırım kararları**dır ama doktrinde ve emsal değer olarak yargı kararı seviyesinde önem taşır. Kurul kararının iptal davası (İYUK m.7) ile bağlayıcılığı tartışmalı; ancak benzer ihlal tipinde Kurul'un nasıl karar verdiğini bilmek **vatandaşın silahıdır** — dilekçede emsal olarak kullanılır.

## Akış

1. **Çek:** `mcp__yargi_mcp__search_kvkk_decisions` ile son 7 gün
2. **Filtre:** Aşağıdaki anahtar kelimelerden EN AZ BİRİ geçmeli:
   - "yapay zekâ" / "YZ" / "AI"
   - "otomatik karar" / "otomatik sistem"
   - "profilleme" / "profil çıkarma"
   - "algoritma" / "algoritmik"
   - "makine öğrenmesi" / "machine learning"
   - "skorlama" / "puanlama"
   - "öneri sistemi"
   - "biyometrik" (deepfake ile bağlantılı)
3. **Materyal değer:**
   - Yeni bir tanım yapılmış mı?
   - Yeni bir yaptırım tipi açıklanmış mı?
   - Önceki Kurul içtihadından sapma var mı?
4. **Envanter eşleştirmesi:**
   - Kararın taraf sektörü (banka, sosyal medya, sigorta vb.) envanterinizdeki sistemlerle eşleşiyor mu?
   - Eşleşiyorsa "ai-NNN sistemine emsal" notu eklenir
5. **Rapor:** Cowork artifact

## Çıktı

```
# KVKK Kurul Sweeper Haftalık Rapor — ../../2026

## ⚠️ Yeni materyal kararlar: N

### 1. Karar No: 2026/XXX, ../../2026
**Tip:** Veri sorumlusu yaptırım kararı  
**Sektör:** Bankacılık  
**Konu:** Kredi başvurusu otomatik reddi — KVKK m.11/g ihlali

**Özet:** Bank Y, kredi başvurusu otomatik reddedilen ilgili kişiye karar mantığı hakkında yetersiz bilgi verdi. Kurul, KVKK m.11/g uyarınca ihlal tespit etti; idari para cezası uyguladı (TL X).

**Bana emsal değer:**
- Envanter eşleşmesi: ai-001 (Bank X — aynı sektör, aynı ihlal tipi) ✓
- Argüman güçlendirme: Bu emsal Bank X'e karşı m.13 başvurumda kullanılabilir
- Yargısal değer: Kurul'un m.11/g eşik yorumu

**Aksiyon:**
→ /otomatik-karar-itirazi --emsal-ekle 2026/XXX
→ ai-001 kaydını güncelle (yeni emsal)

**Kaynak:** [yargi_mcp KVKK link]

### 2. [Diğer]
...

## Eylem ağacı
1. ai-001 için /otomatik-karar-itirazi --emsal-ekle 2026/XXX
2. Tüm bulgularla ai-temas-envanteri'ni güncelle (otomatik)
3. /mevzuat-degisiklik-takibi ile birleşik analiz
```

## Hatalar ve sınırlar

- KVKK Kurul yeni karar yayını **çok düzensiz** — bazı haftalar 0, bazı haftalar 10+ karar
- Kurul karar metinleri tam yayımlanmayabilir; özet veriliyor olabilir
- Bazı kararlar gizli (tarafların talebi üzerine anonimleştirilmiş)
- AI ile ilgili spesifik karar sayısı 2024-2026 döneminde hızla artıyor; agent'ın anahtar listesi periyodik genişletilmeli
