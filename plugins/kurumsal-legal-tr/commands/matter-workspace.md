---
description: Çoklu müvekkil/işlem dosyası yönetimi — yeni matter aç, listele, aktif değiştir, kapat. Av.K. m.36 sır yükümlülüğüne uygun izolasyon.
argument-hint: "[--new | --list | --switch <id> | --close <id> | --detach]"
---

Eklentinin `matter-workspace` skill'ini çalıştır. Müvekkil verisi profil dosyasına yazılmaz; her matter `~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/matters/<matter-id>/` altında izole tutulur.

Detaylı talimat: `skills/matter-workspace/SKILL.md`.

Yeni matter için `turk-hukuk-legal:matter-intake` skill'ine paralel handoff yapılabilir.

Argümanlar: $ARGUMENTS
