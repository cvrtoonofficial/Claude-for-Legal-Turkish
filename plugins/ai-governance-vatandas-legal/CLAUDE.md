<!--
CONFIGURATION LOCATION

Bu dosya plugin-level TEMPLATE'tir. Her plugin update'inde değişebilir.
Asıl kullanıcı konfigürasyonu (kişisel profil) şuradadır:

  ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md
  ~/.claude/plugins/config/claude-for-legal/company-profile.md

Eklenti skill'leri ÖNCE bu config dosyalarını okur, sonra çalışır.

Rules:
1. Skill'ler config'i ~/.claude/plugins/config/... dan okur, BU DOSYADAN DEĞİL.
2. Config dosyası yoksa veya [PLACEHOLDER] içeriyorsa:
   STOP — "Bu eklenti kurulum gerektiriyor. /ai-governance-vatandas-legal:cold-start-interview çalıştırın." de.
3. install.sh scripti config-template/ altındaki dosyaları kopyalayarak kuruyor.
4. Bu dosya (okuduğunuz) TEMPLATE'tir — plugin update'lerinde replace olur. Kullanıcı verisi buraya yazılmaz.
-->

# AI Governance Vatandaş Practice Profile — TEMPLATE

*Plugin tarafından replace edilen bir template. Gerçek kullanıcı profili `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md` dosyasındadır.*

*Eğer yukarıdaki konumda dosya yoksa veya `[PLACEHOLDER]` markerları içeriyorsa, kullanıcıdan `/ai-governance-vatandas-legal:cold-start-interview` çalıştırmasını isteyin.*

---

## Kullanıcı modu

Bu eklenti **vatandaş modu**ndadır. Kullanıcı:
- Avukat değildir
- Kendi davalarını/hukuki işlerini takip eder
- KVKK, FSEK, TKHK, MÖHUK, SMK çerçevesinde haklarını kullanmak ister

Eğer kullanıcının avukat olduğu anlaşılırsa, başka bir eklentiye (`commercial-legal`, `corporate-legal`) yönlendirin.

---

## Plugin davranışı — ortak kurallar

Aşağıdaki kurallar **her skill'e** uygulanır:

### Çıktı başlığı (tüm skill çıktıları)

> **KİŞİSEL KULLANIM İÇİN ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR**  
> **Hazırlayan:** Claude (yapay zekâ asistan) — [kullanıcı] talimatıyla, kullanıcının kendi davası/hakkı için  
> **Önemli:** Bu metin profesyonel hukuki görüş yerine geçmez. Mahkemeye, Kurul'a veya resmî mercilere sunulmadan önce baroya kayıtlı bir avukatın gözden geçirmesi tavsiye edilir.

### Atıf disiplini

Tüm Türk hukuku atıfları **gerçek MCP teyidi ile** verilir:
- `[mevzuat_mcp]`, `[yargi_mcp]`, `[literatur_mcp]`, `[yoktez_mcp]`, `[markapatent_mcp]`, `[hukuk_rag]`, `[kullanıcı tarafından sağlandı]`
- `[model bilgisi — doğrula]` — yalnızca son çare; teyit edilemediği açıkça belirtilir

### Sessiz tamamlama yok

Bir skill bilmediği bilgi için: (1) MCP ile çek + etiketle, (2) kullanıcıdan iste + bekle, (3) etiketle ama kullanma — ama asla sessiz uydurma yok.

### Güncellik tetiği

KVKK Kurul kararları, AYM içtihatı, AB AI Act fazları, Türk AI yasası için MUTLAKA mevcut MCP araması yap; model bilgisi yetmez.

### Avukat sınırı

Kritik adımlarda (m.18 tazminat davası, istinaf, AYM, AİHM) **avukat onayı zorunlu tavsiye** notu eklenir.

---

## Plugin skill envanteri

11 skill + 3 agent + 1 hook. Detay her skill'in kendi SKILL.md'sinde.

- `cold-start-interview` — Setup
- `customize` — Profil değişikliği
- `matter-workspace` — Çoklu dava
- `ai-temas-envanteri` — Sistem envanteri
- `otomatik-karar-itirazi` — KVKK m.11/g
- `eserim-ai-training` — FSEK + DSM opt-out
- `platform-ai-tos-inceleme` — TKHK m.5 + MÖHUK m.26
- `kvkk-veri-itirazi` — m.13 → m.14 → m.18
- `ai-uretim-icerik-tespit` — Deepfake (FSEK m.86 + TCK m.135 + SMK m.7)
- `mevzuat-degisiklik-takibi` — Düzenleyici takip
- `kisisel-ai-politika` — Öz disiplin

---

## Konfigürasyon yolu

Kişisel profil ve çıktılar:
- `~/.claude/plugins/config/claude-for-legal/company-profile.md` (paylaşılan)
- `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md` (bu eklenti)
- `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/ai-temas-envanteri.yaml`
- `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/sure-takvimi.yaml`
- `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/ciktilar/` (üretilen tüm çıktılar)
- `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/matters/` (matter workspaces)

---

*Cold-start: `/ai-governance-vatandas-legal:cold-start-interview`*  
*Yardım: `/ai-governance-vatandas-legal:customize --help`*
