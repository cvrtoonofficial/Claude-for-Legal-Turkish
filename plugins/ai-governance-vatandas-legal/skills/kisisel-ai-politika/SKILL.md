---
name: kisisel-ai-politika
description: >
  Vatandaş olarak kendi AI kullanım disiplinimi yönetir — hangi AI'a hangi veriyi veririm,
  eserlerim için opt-out kontrol listesi, kişisel veri sızıntısı engelleme kuralları. Orijinal
  policy-starter'ın vatandaş çevirisi. Tetikleyiciler: "AI kullanım disiplini", "kişisel AI
  politikam", "ChatGPT'ye ne paylaşırım", "AI hijyen", "kendi kurallarımı çıkar".
argument-hint: "[--draft (ilk taslak) | --review (mevcut politikayı gözden geçir) | --check '<kullanım senaryosu>']"
---

# /kisisel-ai-politika

## Ne zaman çalışır

Vatandaş olarak kendi AI etkileşimlerinizi disiplin altına almak istiyorsanız:
- ChatGPT/Claude'a davalarımı yazarken nelere dikkat etmeliyim?
- Suno/Udio'ya kendi seslerimi mi yüklüyorum? (Eğitim verisi riskim)
- Hangi platformlara müzik dağıtmadan önce opt-out beyanı yazmalıyım?
- Banka mobil uygulamasının "AI asistan"ına ne sormam riskli?

## Akış

### `--draft` modu (ilk politika oluşturma)

İnteraktif mülakat:
1. Hangi AI'ları kullanıyorsunuz? (ChatGPT, Claude, Grok, Gemini, Suno, ElevenLabs, ...)
2. Her biri için: bugüne kadar **paylaştığınız en hassas veri** ne?
3. Eserleriniz nerede yayında? Opt-out yapabildiklerinize bakalım
4. Banka/sigorta AI'larıyla etkileşiminiz?
5. Sosyal medyada AI tabanlı içerik (Meta, X) kullanıyor musunuz?

Politika taslağı **6 kuralda** üretilir:

**Kural 1 — Kırmızı Çizgi:** Hiçbir AI'a verilmez:
- TC kimlik no
- IBAN ve hesap detayları
- Tıbbi raporlar (sağlık verisi — KVKK m.6 özel nitelikli)
- Aktif dava içeriği (taraflar, mahkeme no, savcılık dosyası)
- 3. kişilerin kişisel verileri

**Kural 2 — Anonimleştirme Zorunlu:** Davalarımı yazarken:
- İsim → [taraf adı]
- Adres → [adres]
- TC → [TC]
- Tarih → [tarih]

**Kural 3 — Hangi AI'a Ne:**

| AI | Güven seviyesi | İzin verilen | Yasak |
|---|---|---|---|
| Claude (Anthropic) | yüksek (eğitim için varsayılan opt-out) | hukuki strateji, dilekçe taslağı | TC + isim kombinasyonu |
| ChatGPT (OpenAI) | orta (eğitim opt-out gerekiyor) | genel soru | aktif dava detayı |
| Grok (xAI) | düşük (eğitim verisi şeffaflığı zayıf) | meraki sorular | hiçbir kişisel veri |
| Gemini (Google) | orta | genel | kişisel veri |

**Kural 4 — Eser Opt-Out Kontrol Listesi:**
- ☐ Spotify — opt-out talebim var mı? Tarih?
- ☐ Apple Music
- ☐ Amuse — yan ürün opt-out
- ☐ YouTube — Content ID + AI training opt-out
- ☐ SoundCloud
- ☐ TikTok — kullanılan eserlerim için

**Kural 5 — Banka/Sigorta AI:**
- "AI asistan" kullanıyorsam KVKK aydınlatma metnini sakla
- Otomatik karar verilmişse derhal `/otomatik-karar-itirazi`

**Kural 6 — Sosyal Medya AI:**
- AI üretimi içerikleri etiketle (EU AI Act m.50 alıcı tarafı şeffaflığı)
- Meta AI training opt-out tamamlandı mı? (Kullanılan tüm hesaplar)
- X (Twitter) Grok training opt-out (settings → Privacy → Data sharing)

### `--review` modu
Mevcut politikayı tarar; son 30 günde eklenmiş yeni AI sistemleri kontrol et; envanterden eksik olan var mı?

### `--check '<senaryo>'` modu
Belirli bir kullanım hakkında hızlı kontrol:
- `--check 'ChatGPT'ye dava dilekçemi yapıştırıp soracağım'` → analiz + uyarı

## MCP araştırma stratejisi

1. **`hukuk_rag` (BİRİNCİL):** Mevcut politika dosyası `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/kisisel-ai-politikam.md`
2. **`mevzuat_mcp`:** KVKK m.5-6 (rıza), TCK m.135 (suç sınırı), FSEK m.52
3. **`yargi_mcp`:** KVKK Kurul kararları — kişisel veri sızıntısı tipik yaptırımlar

## Çıktı

`~/.claude/plugins/config/claude-for-legal/ai-governance-legal/kisisel-ai-politikam.md` dosyasına yazılır. Hook olarak `kisisel-veri-anonimlestirme-prehook` bu politikayı okur ve her AI etkileşiminden önce uygular.

## Cross-skill handoff

- Yeni AI sistemi keşfedildiyse: `/ai-temas-envanteri ekle`
- Opt-out talebi yapılacaksa: `/eserim-ai-training --opt-out-talebi`
- Veri sızıntısı oldu şüphesi: `/kvkk-veri-itirazi`
