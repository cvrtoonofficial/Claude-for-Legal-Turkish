# AI Governance — Vatandaş Versiyonu (TR)

> **Türk vatandaşının AI çağında kendi haklarını koruma kontrol paneli.**

Anthropic'in `ai-governance-legal` eklentisinin tamamen yeniden inşa edilmiş Türk versiyonu. Şirket içi hukuk müşaviri (in-house counsel) odaklı orijinal aracın yerine, **avukat olmayan bir vatandaşın** KVKK, FSEK, TKHK, MÖHUK ve SMK haklarını sistematik kullanması için yapılandırılmıştır.

**Sürüm:** 1.0.0  
**Hazırlayan:** Claude (Anthropic) — Abdullah için  
**Kapsam:** Sadece kişisel kullanım; git'e yüklenmemiş

---

## Kim için

- **Avukat değilim**, kendi davalarımı/hukuki işlerimi takip ediyorum (HMK m.71 asil sıfatı)
- **Müzisyen/sanatçıyım** — eserlerim sınır ötesi AI platformlarda (Spotify, Amuse, Suno tehditi)
- **KVKK haklarımı** sistemik şekilde kullanmak istiyorum
- Sınır ötesi platformlarda **tüketici** sıfatıyla korumamı arıyorum

## Ne yapar

| Skill | Hangi soruyu cevaplar |
|---|---|
| `otomatik-karar-itirazi` | "AI beni reddetti — itiraz edebilir miyim?" |
| `eserim-ai-training` | "Eserlerim AI eğitiminde mi? Nasıl opt-out yaparım?" |
| `platform-ai-tos-inceleme` | "Spotify/Amuse TOS'undaki AI klozu haksız mı?" |
| `kvkk-veri-itirazi` | "KVKK m.13 başvurusu nasıl yazılır? Kurul'a nasıl şikâyet ederim?" |
| `ai-uretim-icerik-tespit` | "Birisi AI ile sesimi/yüzümü kopyaladı — ne yaparım?" |
| `ai-temas-envanteri` | "Beni etkileyen tüm AI sistemlerinin envanteri" |
| `mevzuat-degisiklik-takibi` | "Yeni mevzuat bana ne kazandırdı?" |
| `kisisel-ai-politika` | "Hangi AI'a ne veri vermem güvenli?" |
| `cold-start-interview` | İlk kurulum (10 dk) |
| `customize` | Profil tek-alan değişiklik |
| `matter-workspace` | Çoklu dava/iş paralel yönetim |

## Üç katmanlı güvenlik

1. **kisisel-veri-anonimlestirme-prehook** — Her AI'a gönderilmeden önce TC, IBAN, telefon, sağlık verisi tespit edilir, anonimleştirme önerilir (KVKK m.4-5, TCK m.135-136)
2. **tos-degisiklik-watcher** (haftalık) — 14+ sınır ötesi platform TOS'u, AI klozu diff
3. **kvkk-kurul-kararlari-sweeper** (haftalık) — yargi_mcp KVKK endpoint'inden yeni emsal kararlar, envanterle eşleştirme
4. **sure-takipcisi** (günlük) — 15+ hak düşürücü süre, T-14/7/3/1 uyarı

## MCP havuzu

```
mevzuat_mcp     ← KVKK, FSEK, TKHK, MÖHUK, sektörel düzenleyiciler
yargi_mcp       ← Özellikle KVKK Kurul endpoint + Yargıtay + AYM + AİHM
markapatent_mcp ← TPMK sahne adı/marka tescil kontrolü
literatur_mcp   ← DergiPark — doktrin
yoktez_mcp      ← YÖK Tez — monografik doktrin
hukuk_rag       ← Kişisel arşiv (TOS metinleri, başvuru şablonları)
```

## Hızlı başlangıç

```bash
cd ai-governance-vatandas-plugin
bash scripts/install.sh
```

Ardından Claude Code içinde:

```
/ai-governance-vatandas-legal:cold-start-interview
```

Detaylı kurulum: [`scripts/install.sh`](./scripts/install.sh) — adımlar interaktif.

Manuel kurulum: [`KURULUM.md`](./KURULUM.md).

## Plugin dosya haritası

```
ai-governance-vatandas-plugin/
├── .claude-plugin/
│   └── plugin.json                  ← Plugin manifest
├── README.md                        ← Bu dosya
├── KURULUM.md                       ← Detaylı kurulum kılavuzu
├── CLAUDE.md                        ← Plugin-level template (config dosyası buradan kopyalanır)
│
├── commands/                        ← Slash command tanımları (11 komut)
│   ├── cold-start-interview.md
│   ├── otomatik-karar-itirazi.md
│   ├── eserim-ai-training.md
│   └── ...
│
├── skills/                          ← Skill brief'leri (11 skill)
│   ├── cold-start-interview/SKILL.md
│   ├── otomatik-karar-itirazi/SKILL.md
│   └── ...
│
├── agents/                          ← Scheduled agent tanımları
│   ├── agents.json
│   ├── tos-degisiklik-watcher.md
│   ├── kvkk-kurul-kararlari-sweeper.md
│   └── sure-takipcisi.md
│
├── hooks/                           ← Hook konfigürasyonu
│   ├── hooks.json                   ← settings.json'a merge edilecek
│   └── kisisel-veri-anonimlestirme-prehook.md
│
├── references/                      ← Referans dokümanlar
│   ├── currency-watch.md            ← Hızla değişen alanlar
│   ├── 00-MIMARI-KARARLARI.md       ← Tüm tasarım kararlarının gerekçesi (chain-of-thought)
│   └── 04-DOGRULAMA-RAPORU.md       ← Statik tutarlılık testi
│
├── config-template/                 ← Kurulum sırasında ~/.claude/plugins/config/ altına kopyalanır
│   ├── company-profile.md           ← → ~/.claude/plugins/config/claude-for-legal/company-profile.md
│   ├── CLAUDE.md                    ← → ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md
│   ├── ai-temas-envanteri.yaml      ← boş başlangıç
│   └── sure-takvimi.yaml            ← boş başlangıç
│
└── scripts/
    ├── install.sh                   ← One-shot kurulum
    └── uninstall.sh                 ← Geri alma
```

## Önemli sınırlar

- Bu eklenti çıktıları **hukuki tavsiye değildir** — araştırma notu seviyesindedir.
- Mahkemeye/Kurul'a sunulacak nihai metinler için **baroya kayıtlı bir avukat** tavsiye edilir.
- KVKK m.13 ve m.14 başvuruları için avukat zorunlu değil; m.18 tazminat ve istinaf için zorunlu olabilir.
- Türk içtihadı bazı alanlarda (AI eğitim verisi, deepfake) çok yeni — argümanlar büyük ölçüde doktrindir.

## Lisans

Kişisel kullanım. Git'e yüklenmemiş. Başka biri için adapte edilecekse `config-template/company-profile.md` içindeki kişisel bilgiler ve `config-template/CLAUDE.md` içindeki ad/e-posta değiştirilmelidir.

## Hata raporu / iyileştirme

Bir sorun fark ederseniz Claude'a şu şekilde söyleyin:

> "ai-governance-vatandas eklentisinde şunu fark ettim: [açıklama]. Düzeltir misin?"

Claude bu klasörü tarayıp düzeltir ve değişiklikleri loglar.
