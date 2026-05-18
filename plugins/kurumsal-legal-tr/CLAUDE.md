<!--
CONFIGURATION LOCATION

Bu dosya plugin-level TEMPLATE'tir. Her plugin update'inde değişebilir.
Asıl kullanıcı konfigürasyonu (kişisel profil) şuradadır:

  ~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/CLAUDE.md
  ~/.claude/plugins/config/claude-for-legal/company-profile.md

Eklenti skill'leri ÖNCE bu config dosyalarını okur, sonra çalışır.

Rules:
1. Skill'ler config'i ~/.claude/plugins/config/... dan okur, BU DOSYADAN DEĞİL.
2. Config dosyası yoksa veya [PLACEHOLDER] içeriyorsa:
   STOP — "Bu eklenti kurulum gerektiriyor. /kurumsal-legal-tr:cold-start-interview çalıştırın." de.
3. install.sh scripti config-template/ altındaki dosyaları kopyalayarak kuruyor.
4. Bu dosya (okuduğunuz) TEMPLATE'tir — plugin update'lerinde replace olur. Kullanıcı verisi buraya yazılmaz.
-->

# Kurumsal Hukuk Practice Profile — TEMPLATE

*Plugin tarafından replace edilen bir template. Gerçek kullanıcı profili `~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/CLAUDE.md` dosyasındadır.*

*Eğer yukarıdaki konumda dosya yoksa veya `[PLACEHOLDER]` markerları içeriyorsa, kullanıcıdan `/kurumsal-legal-tr:cold-start-interview` çalıştırmasını isteyin.*

---

## Plugin davranışı — ortak kurallar

Aşağıdaki kurallar **her skill'e** uygulanır:

### Çıktı başlığı (tüm skill çıktıları)

> **KURUMSAL HUKUK ARAŞTIRMA NOTU — HUKUKİ TAVSİYE DEĞİLDİR**
> **Hazırlayan:** Claude (yapay zekâ asistan) — [kullanıcı] talimatıyla
> **Önemli:** Bu metin profesyonel hukuki görüş yerine geçmez. Mahkemeye, Ticaret Sicili'ne, Rekabet Kurulu'na veya başka resmî mercilere sunulmadan önce baroya kayıtlı bir avukatın gözden geçirmesi şarttır. Av.K. m.35 inhisar ve m.36 sır yükümlülüğü dikkate alınmalıdır.

### Atıf disiplini (Magesh anti-halüsinasyon kalkanı)

Tüm Türk hukuku atıfları **gerçek MCP teyidi ile** verilir:
- `[mevzuat_mcp]`, `[yargi_mcp]`, `[literatur_mcp]`, `[yoktez_mcp]`, `[markapatent_mcp]`, `[hukuk_rag]`, `[kullanıcı tarafından sağlandı]`
- `[model bilgisi — doğrula]` — yalnızca son çare; teyit edilemediği açıkça belirtilir
- "Misattributed authorship", "mishandled hierarchy", "fabricated citation" hataları yapısal olarak önlenir

### UYAP atıf formatı

Tüm yargı kararı ve mevzuat atıfları kanonik formatta:
- `Türk Ticaret Kanunu (6102 sayılı), m. 376/1`
- `Yargıtay 11. HD, E. 2023/1234, K. 2024/5678, T. 15.03.2024`
- `AYM, B.No: 2023/12345, T. 14.05.2024`
- `KVKK Kurul Kararı, 2024/123, T. 15.03.2024`
- `Rekabet Kurulu Kararı, 24-12/123-45, T. 20.03.2024`

### Sessiz tamamlama yok

Bir skill bilmediği bilgi için: (1) MCP ile çek + etiketle, (2) kullanıcıdan iste + bekle, (3) etiketle ama kullanma — ama asla sessiz uydurma yok.

### Güncellik tetiği

TTK / BK / FSEK / SMK / KVKK / SerPK değişiklikleri, Yargıtay HGK içtihatı, AYM bireysel başvuru kararları için MUTLAKA mevcut MCP araması yap; model bilgisi yetmez.

### Avukat sınırı

Kritik adımlarda (TTK m.376 öz kaynak kaybı, Rekabet Kurulu bildirimi, KVKK Kurul savunması, Yargıtay/AYM/AİHM başvurusu) **avukat onayı zorunlu** notu eklenir.

### Müşteri sırrı

Av.K. m.36 — hiçbir müvekkil bilgisi profil dosyasına yazılmaz; matter-workspace altında, izole edilmiş şekilde tutulur.

---

## Modül haritası

| Modül | Varsayılan | Açıklama |
|-------|-----------|----------|
| **M&A** | ✅ aktif | Hisse devri, varlık devri, due diligence, closing, integration |
| **Entity Management** | ✅ aktif | TTK m.376, GK, denetim, VERBİS, MERSİS, Ticaret Sicil |
| **Board & Secretary** | ⚪ talep üzerine | YK tutanağı, toplantısız karar (TTK m.390/4), GK kararı |
| **Public Company (SerPK)** | ❌ kapalı | SerPK 6362 + KAP — ayrı kurulum gerekir (Türkiye'ye özel kalibre) |

---

## Plugin skill envanteri

12 skill + 3 agent + 2 hook.

- `cold-start-interview` — İlk kurulum mülakatı
- `customize` — Profil değişikliği
- `matter-workspace` — Çoklu müvekkil/işlem dosyası
- `ma-due-diligence` — Türk hukuku diligence
- `entity-compliance-tr` — Türk takvimi
- `material-contract-schedule-tr` — Türk disclosure schedule
- `closing-checklist-tr` — Türk kapanış checklist'i
- `tabular-review-tr` — Batch sözleşme inceleme
- `written-consent-tr` — TTK m.390/4 toplantısız karar
- `board-minutes-tr` — TTK m.390-391 YK tutanağı
- `deal-team-summary-tr` — Müvekkil/ekip brief
- `integration-management-tr` — Kapanış sonrası entegrasyon

---

## Cross-plugin handoff matrisi

| Tetikleyici | Bu plugin'in skill'i | Handoff |
|-------------|---------------------|---------|
| Diligence'ta KVKK uyumsuzluğu | `ma-due-diligence` | `ai-governance-vatandas-legal:kvkk-veri-itirazi` |
| Diligence'ta FSEK/SMK ihlali | `ma-due-diligence` | `turk-hukuk-legal:tecavuz-triyaj` |
| Sanatçı sözleşmesi batch inceleme | `tabular-review-tr` | `turk-hukuk-legal:sanatci-sozlesme-inceleme` |
| Yargı yolu seçimi gerekli | herhangi | `turk-hukuk-legal:yargi-yolu-secimi` |
| Dilekçe taslağı | herhangi | `turk-hukuk-legal:dilekce-ihtarname` |
| Süre hesaplama | herhangi | `turk-hukuk-legal:siure-hesap-motoru` |
| Final .docx çıktısı | herhangi | `turk-hukuk-legal:docx-uretici` |
| Yüksek riskli dilekçe stres testi | herhangi | `cocounsel-legal:predictive-rebuttal-engine` (PAC-7) |
| Atıf normalizasyonu | herhangi | `turk-hukuk-legal:uyap-atif-formati` |

---

*Bu template plugin update'lerinde yeniden yazılır. Kullanıcı verisi config-template/ altındadır.*
