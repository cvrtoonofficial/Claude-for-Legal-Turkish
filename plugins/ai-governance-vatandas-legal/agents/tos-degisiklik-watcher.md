# Agent: tos-degisiklik-watcher

**Tip:** Scheduled task (mcp__scheduled-tasks__create_scheduled_task)  
**Sıklık:** Haftalık — her Pazartesi 09:00 (Türkiye saati)  
**Cron:** `0 6 * * 1` (UTC; Türkiye = UTC+3, dolayısıyla 09:00 TR)

## Görevi

Kullanıcının `ai-temas-envanteri`'nde kayıtlı platformların güncel TOS sayfalarını WebFetch ile çeker, arşivdeki versiyonla **AI ile ilgili klozlarda** karşılaştırır, **materyal değişiklik** varsa rapor üretir.

## İzlenen platformlar (varsayılan)

CLAUDE.md'deki envanterden okur. Tipik liste:

| Platform | TOS URL'leri | AI ilgili anahtarlar |
|---|---|---|
| Amuse | amuse.io/legal/terms | "machine learning", "AI training", "automated systems" |
| Spotify | spotify.com/legal/end-user-agreement | "AI", "training", "machine learning", "model" |
| Apple Music | apple.com/legal/internet-services/itunes/ | "AI", "intelligence", "automated" |
| Epidemic Sound | epidemicsound.com/legal | "AI", "training data", "ML" |
| Kobalt | kobaltmusic.com/legal | "AI", "training", "automated" |
| YouTube (Google) | youtube.com/static?template=terms | "AI", "training", "ML" |
| Meta (Facebook + Instagram) | facebook.com/legal/terms | "AI", "Llama", "training", "automated" |
| X (Twitter) | x.com/en/tos | "Grok", "AI", "training" |
| TikTok | tiktok.com/legal/terms-of-service | "AI", "ML", "recommendation" |
| OpenAI (ChatGPT) | openai.com/policies/terms-of-use | "training", "fine-tuning" |
| Anthropic (Claude) | anthropic.com/legal/consumer-terms | "training", "fine-tuning" |
| Suno | suno.com/terms | "training data", "ML", "AI" |
| Udio | udio.com/terms | "training", "ML" |
| ElevenLabs | elevenlabs.io/terms | "voice cloning", "AI training" |

## Akış

1. **Çek:** WebFetch ile her platformun TOS sayfası
2. **Arşivle:** Çekilen versiyonu timestamp ile `hukuk_rag/tos-arsivi/<platform>/YYYY-MM-DD.html`
3. **Diff:** Bir önceki versiyonla karşılaştır
4. **AI klozu filtreleme:** Sadece "AI ilgili anahtarlar" tablosundaki kelimelerin geçtiği paragraflar
5. **Materyal mi:** Diff'te AI ile ilgili anlamlı değişiklik var mı? (Boşluk/punctuation değil, anlam değişikliği)
6. **Raporla:**
   - Cowork artifact: "TOS Watcher Raporu — ../../2026"
   - Süre uyarısı: TKHK m.5'e göre tüketici sözleşmesinde esaslı değişiklikler 30 gün önbildirim gerektirir; bu süre `sure-takipcisi`'ya eklenir

## Çıktı

```
# TOS Watcher Haftalık Rapor — ../../2026

## ⚠️ Materyal değişiklik tespit edildi: N platform

### 1. Spotify (../../2026'da güncellenmiş)
- **Yeni eklenen kloz (m.7.3):** 
  > "By using the Service, you grant Spotify a non-exclusive, royalty-free license to use Your Content for the purposes of training our recommendation and content analysis machine learning models, including audio fingerprinting and music similarity detection."
- **Hukuki değerlendirme:**
  - FSEK m.52 yazılı şekil + ayrı sayım eksik — kloz tartışmalı
  - DSM Direktifi m.4(3) opt-out hakkı var
  - TKHK m.5 müzakere edilmemiş → haksız şart varsayımı
- **Önerilen aksiyon:** 
  → /platform-ai-tos-inceleme spotify --diff (detaylı analiz)
  → /eserim-ai-training --opt-out-talebi spotify

### 2. [Diğer]
...

## Sadece şekli değişiklikler (4 platform — atlanabilir)
- Apple Music — başlık numaralandırma
- Meta — adresleme yenileme
...

## Eylem ağacı
1. [Önerilen] Spotify için detaylı diff: /platform-ai-tos-inceleme spotify --diff
2. Tüm değişiklikleri envanterde işaretle (otomatik tamamlandı)
3. Yeni opt-out fırsatları için kontrol listesi: /eserim-ai-training
```

## Hukuki temel

- **TKHK m.5/3:** Tüketici aleyhine müzakere edilmeden yapılan değişiklikler haksız şart
- **TKHK m.5(2):** Esaslı değişiklikler 30 gün önbildirim
- **MÖHUK m.26:** Sınır ötesi tüketici uyuşmazlığı; Türk emredici hükümleri korunur

## Hatalar ve sınırlar

- Bazı platformlar TOS sayfasını JavaScript ile render eder; WebFetch yetmezse `mcp__Claude_in_Chrome__navigate` + `get_page_text` yedek olarak kullanılır
- TOS'un dil sürümleri farklı olabilir (İngilizce, Almanca vs. Türkçe); **resmi dil İngilizce olan** versiyon birincil kaynaktır
- Bazı platformlar bot trafiğini engeller (Cloudflare); el ile yükleme istenebilir
