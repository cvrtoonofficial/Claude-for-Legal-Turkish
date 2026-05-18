---
name: cold-start-interview
description: >
  Eklentinin ilk kurulumu — vatandaş profilini, AI temas haritasını ve seed dokümanlarını
  öğrenip CLAUDE.md ve company-profile.md'yi yazar. Tetikleyiciler: "kurulumu yap", "set up
  ai governance", "ilk kez kullanıyorum", "onboard", veya CLAUDE.md'de [PLACEHOLDER]
  varsa otomatik.
argument-hint: "[--redo (yeniden mülakat) | --check-integrations (MCP testi)]"
---

# /cold-start-interview

## Ne zaman çalışır

- CLAUDE.md yoksa veya `[PLACEHOLDER]` içeriyorsa otomatik tetiklenir
- `--redo` ile elle yeniden başlatılır
- `--check-integrations` ile sadece MCP bağlantı testi yapılır (mülakat yok)

## Mülakat akışı (8-12 dakika)

### Aşama 1 — Statü kontrolü (zorunlu)
- "Avukat mısınız, vatandaş mı?" — Vatandaş ise vatandaş-modu (varsayılan); avukat ise plugin'in **bu kurulum** size uygun değil, `commercial-legal` veya `corporate-legal` eklentilerine yönlendir

### Aşama 2 — Hangi alanlarda kullanıyorsunuz
Çoklu seçim (sizin profilinizden ön-doldurulmuş):
- ☑ Müzik / sanatçı — eserlerimin AI eğitimine kullanılması, deepfake riski
- ☑ KVKK haklarımı kullanma — bilgi, silme, otomatik karar itirazı
- ☑ Sınır ötesi platform sözleşmeleri (Amuse, Spotify vb.)
- ☐ Finansal AI kararlar (kredi, sigorta)
- ☐ Kamu AI sistemleri (GİB, vize)
- ☐ Sağlık AI kararları
- ☐ Diğer

### Aşama 3 — Mevcut AI sistemleri envanteri (seed)
"Hayatınızda hangi AI sistemleri var? Yedi soru:"
1. Hangi müzik dağıtım platformlarını kullanıyorsunuz? (Spotify, Apple Music, vb.)
2. Hangi AI asistanları kullanıyorsunuz? (ChatGPT, Claude, Grok, Gemini)
3. Bankanız AI ile kredi kararı veriyor mu? (Cevap "evet/bilmiyorum" ise envantere ekle)
4. Sosyal medya hesabınız var mı? Hangi platformlarda?
5. Daha önce algoritmik bir karar tarafından mağdur oldunuz mu? (Hesap kapanması, içerik kaldırma, kredi reddi vb.)
6. Eserlerinizden ChatGPT/Suno tarzı sistemler haberdar olabilir mi?
7. KVKK/GDPR konusunda daha önce başvuru/şikâyet yaptınız mı?

### Aşama 4 — Seed dokümanlar
Aşağıdakileri yükleyebiliyorsanız çok faydalı (zorunlu değil):
- Amuse, Spotify, Apple Music TOS metinleri (en güncel sürüm)
- Daha önce yazdığınız KVKK başvurusu / Kurul şikâyet dilekçesi
- Bankanızın aydınlatma metni
- Sahne adı TÜRKPATENT marka tescil belgesi (varsa)

Yüklenen dosyalar `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/seed/` altına kopyalanır.

### Aşama 5 — Süre takip ve agent tercihleri
- "TOS değişiklik watcher haftalık çalışsın mı?" (varsayılan: evet)
- "KVKK Kurul kararı sweeper haftalık çalışsın mı?" (varsayılan: evet)
- "Süre takipçisi günlük kontrol etsin mi?" (varsayılan: evet)
- "Bildirimler hangi kanaldan?" (varsayılan: artifact + console)

### Aşama 6 — Avukat irtibatı (opsiyonel)
"Nihai dilekçelerinizi gözden geçirebilecek bir avukatınız var mı? Adını ve iletişimini girersek, skill'ler özellikle dava aşamasında 'avukat onayı tavsiye edilir' notunu doğru kontak ile veririz."

## MCP araştırma stratejisi (set-up modu)

1. **`hukuk_rag`:** Seed dokümanları arşivler
2. **`mevzuat_mcp`:** KVKK 6698, FSEK 5846, TKHK 6502 başlıkları çekilir — profil referansı için
3. **`scheduled-tasks`:** Agent'ları kaydeder

## Çıktı

1. `~/.claude/plugins/config/claude-for-legal/company-profile.md` — ön-doldurulmuş şablondan kullanıcı yanıtlarıyla yazılır
2. `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md` — vatandaş profili
3. `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/ai-temas-envanteri.yaml` — seed envanter
4. `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/sure-takvimi.yaml` — boş başlangıç
5. `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/seed/` — yüklenen dosyalar

## Doğrulama

Kurulum sonunda:
- Tüm MCP'ler test edilir (`--check-integrations`)
- Agent'lar `scheduled-tasks` üzerinden kaydedilir
- Sample skill çalıştırması önerilir: "İlk denemek için `/ai-temas-envanteri list` çalıştırın"

## Hatalar ve sınırlar

- Seed dokümanlar yoksa eklenti çalışır ama bazı skill'ler "TOS yüklenmedi" der
- markapatent_mcp bağlanmamışsa sahne adı tescil kontrolü `[doğrula]` ile geçer
