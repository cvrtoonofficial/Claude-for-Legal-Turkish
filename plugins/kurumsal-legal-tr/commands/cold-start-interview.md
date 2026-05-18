---
description: Kurumsal hukuk plugin'inin ilk kurulumu — büro profili, müvekkil tipi, aktif modüller, materiality eşikleri, ton tercihi ve seed dokümanları öğrenip CLAUDE.md ve company-profile.md'yi yazar.
argument-hint: "[--redo | --check-integrations]"
---

Eklentinin `cold-start-interview` skill'ini çalıştır. `~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/CLAUDE.md` dosyasında `[PLACEHOLDER]` varsa veya kullanıcı `--redo` derse interaktif mülakat başlat. `--check-integrations` argümanı varsa sadece MCP bağlantı testi yap, mülakat atla.

Detaylı talimat: `skills/cold-start-interview/SKILL.md`.

Çalışmadan önce kullanıcının statüsünü doğrula (avukat / in-house / profesyonel). Müvekkil bilgisi profile yazılmaz — Av.K. m.36 sır yükümlülüğü.

Argümanlar: $ARGUMENTS
