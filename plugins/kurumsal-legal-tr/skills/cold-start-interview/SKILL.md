---
name: cold-start-interview
description: >
  Plugin'in ilk kurulumu — kullanıcı profilini, müvekkil tipini, aktif modülleri,
  materiality eşiklerini, ton tercihini ve seed dokümanlarını öğrenip CLAUDE.md ve
  company-profile.md'yi yazar. Tetikleyiciler: "kurulumu yap", "set up kurumsal hukuk",
  "ilk kez kullanıyorum", "onboard", veya CLAUDE.md'de [PLACEHOLDER] varsa otomatik.
argument-hint: "[--redo (yeniden mülakat) | --check-integrations (MCP testi)]"
---

# /cold-start-interview

## Ne zaman çalışır

- `~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/CLAUDE.md` yoksa veya `[PLACEHOLDER]` içeriyorsa otomatik tetiklenir
- `--redo` ile elle yeniden başlatılır
- `--check-integrations` ile sadece MCP bağlantı testi yapılır (mülakat yok)

## Mülakat akışı (8-12 dakika)

### Aşama 1 — Statü kontrolü

> "Avukat mısınız, in-house danışman mısınız, yoksa kendi şirketinizin hukuk işlerini yapan bir profesyonel mi?"

- **Avukat (dış vekil)** → Av.K. m.35 ve m.36 sınırlarıyla kalibre; matter-workspace zorunlu
- **In-house** → Av.K. inhisar çerçevesi farklı; sınırlar yumuşatılabilir
- **Profesyonel (avukat değil)** → Çıktılar "araştırma notu" seviyesinde; avukat onayı zorunlu uyarı her çıktıda

### Aşama 2 — Müvekkil profili (varsayılan: sanatçı/yapımcı)

Çoklu seçim:

- ☑ Sanatçı / yapımcı / bireysel telif sahibi (FSEK + MESAM/MSG)
- ☐ Türk KOBİ / aile şirketi (TTK + KDV/Muhtasar)
- ☐ Yabancı yatırımcı Türk iştiraki (cross-border M&A, GDPR-KVKK, Rekabet)
- ☐ Müzik / teknoloji / IP yoğun şirket (FSEK + SMK + DSM + EU AI Act)

### Aşama 3 — Aktif modüller

- ☑ **M&A** (varsayılan) — Diligence, material contract, closing, integration
- ☑ **Entity Management** (varsayılan) — TTK m.376, GK, denetim, VERBİS, MERSİS
- ☐ **Board & Secretary** (talep üzerine) — YK tutanağı, m.390/4 toplantısız karar
- ☐ **Public Company (SerPK)** (kapalı) — Ayrı kurulum gerekir

### Aşama 4 — Çıktı dili ve atıf formatı

> "Çıktıları hangi dilde alacaksınız?"

- Türkçe + UYAP atıf formatı (varsayılan)
- Türkçe + İngilizce paralel
- İngilizce ana dil + Türk hukuku referans

### Aşama 5 — Risk tutumu / ton

> "Müzakerede ve dilekçede ne kadar agresif olalım?"

- **Agresif** (varsayılan) — Müvekkil hakkı sıkı korunur, HMK m.29 sınırı içinde
- **Dengeli** — Pragmatik müzakere, ticari ilişki korunur
- **İhtiyatlı** — Riskten kaçınan, savunmacı ton

### Aşama 6 — Materiality eşikleri

Varsayılan eşikler kullanıcıya gösterilir ve değiştirmek isteyip istemediği sorulur:

- Sözleşme: > 500.000 TL veya > 50.000 EUR
- Dava: > 100.000 TL veya manevi tazminat
- Change-of-control: her zaman material
- FSEK m.48-52 mali hak devri: her zaman material

### Aşama 7 — Seed dokümanlar (opsiyonel)

> "Aşağıdakileri yükleyebiliyorsanız, plugin daha doğru çalışır:"

- Standart sözleşme şablonlarınız (NDA, MSA, hisse devri sözleşmesi vb.)
- Önceki diligence raporu (örnek)
- Müvekkil esas sözleşmesi (template)
- Standart YK karar metni

Yüklenen dosyalar `~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/seed/` altına kopyalanır.

### Aşama 8 — Onay matrisi ve escalation

> "Yüksek riskli işlemlerde (örn. > 1M TL veya FSEK mali hak devri) kim onaylar?"

- Tek başına çalışıyorum → otomatik onay (kullanıcıya)
- Kıdemli avukat → e-posta + iletişim
- Müvekkil yöneticisi → e-posta + iletişim

### Aşama 9 — MCP entegrasyon testi

Plugin şu MCP servislerini test eder ve raporlar:

- `yargi_mcp` (zorunlu) — sample query: "Yargıtay 11. HD birleşme"
- `mevzuat_mcp` (zorunlu) — sample query: "TTK m. 376"
- `literatur_mcp` (tavsiye) — sample query: "FSEK m. 48 doktrin"
- `yoktez_mcp` (tavsiye) — sample query: "kurumsal hukuk tez"
- `hukuk_rag` (tavsiye) — sample query: "müvekkil sözleşme corpus"
- `markapatent_mcp` (tavsiye) — sample query: "TPMK marka tescil"

Eksik MCP varsa kullanıcıya uyarı verilir ve plugin yine de devam eder (atıflar `[model bilgisi — doğrula]` etiketi alır).

### Aşama 10 — Profil yazımı

Plugin yukarıdaki cevaplara göre şu dosyaları yazar:

```
~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/CLAUDE.md
~/.claude/plugins/config/claude-for-legal/company-profile.md  (paylaşılan dosya — yoksa oluşturulur)
~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/sure-takvimi.yaml  (boş takvim)
~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/entity-compliance-tracker.yaml  (boş tracker)
```

### Aşama 11 — Kapanış

> "Kurulum tamamlandı. İlk dosyanızı açmak için `/kurumsal-legal-tr:matter-workspace --new` çalıştırın."

---

## Çıktı formatı

Plugin mülakat sırasında **AskUserQuestion** tool'unu kullanır (Cowork mode'da görsel form), terminal'de ise satır-satır prompt verir.

---

## Cross-plugin entegrasyonu

Mülakat sırasında plugin şu plugin'lerin kurulu olup olmadığını kontrol eder:

- `turk-hukuk-legal` (zorunlu tavsiye)
- `ai-governance-vatandas-legal` (tavsiye)
- `cocounsel-legal` (tavsiye)

Eksikse kullanıcıya kurulum önerilir.
