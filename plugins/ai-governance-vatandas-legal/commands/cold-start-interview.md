---
description: Vatandaş AI governance profilini ilk kez kurar — interaktif mülakat ile CLAUDE.md ve company-profile.md'yi yazar.
argument-hint: "[--redo | --check-integrations]"
---

Eklentinin `cold-start-interview` skill'ini çalıştır. `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md` dosyasında `[PLACEHOLDER]` varsa veya kullanıcı `--redo` derse interaktif mülakat başlat. `--check-integrations` argümanı varsa sadece MCP bağlantı testi yap, mülakat atla.

Detaylı talimat: `skills/cold-start-interview/SKILL.md`.

Çalışmadan önce kullanıcının statüsünü doğrula: avukat değil, vatandaş. Avukatsa kullanıcıyı `commercial-legal` veya `corporate-legal` eklentilerine yönlendir — bu eklenti vatandaş içindir.

Argümanlar: $ARGUMENTS
