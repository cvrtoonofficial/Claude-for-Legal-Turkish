# Kurulum Kılavuzu — Detaylı

Bu eklentinin kurulumu için **üç seçenek** vardır:

## Seçenek A — Tek komutla (önerilen)

Plugin paketini açtığınız klasörde:

```bash
cd ai-governance-vatandas-plugin
chmod +x scripts/install.sh
bash scripts/install.sh
```

Script:
1. Mevcut konfigürasyonu yedekler (`~/.claude/backups/`)
2. `~/.claude/plugins/ai-governance-vatandas-legal/` altına plugin dosyalarını kopyalar
3. `~/.claude/plugins/config/claude-for-legal/` altına config dosyalarını yerleştirir
4. `~/.claude/settings.json`'a hook'u ekler
5. Tüm dosyaları doğrular ve sonraki adımları söyler

Sonra Claude Code'da:

```
/ai-governance-vatandas-legal:cold-start-interview
```

Mülakat sonunda Claude size üç agent'ı (TOS watcher, KVKK sweeper, süre takipçisi) kayıt teklif edecek; onaylayın.

---

## Seçenek B — Manuel kurulum

Tercih ederseniz adım adım:

### 1. Plugin dosyalarını yerleştirin

```bash
mkdir -p ~/.claude/plugins/ai-governance-vatandas-legal
cp -r ai-governance-vatandas-plugin/{commands,skills,agents,hooks,references,.claude-plugin,CLAUDE.md,README.md} \
      ~/.claude/plugins/ai-governance-vatandas-legal/
```

### 2. Config dizinlerini oluşturun

```bash
mkdir -p ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/{seed,ciktilar,matters}
```

### 3. Profil dosyalarını yerleştirin

```bash
cp ai-governance-vatandas-plugin/config-template/company-profile.md \
   ~/.claude/plugins/config/claude-for-legal/company-profile.md

cp ai-governance-vatandas-plugin/config-template/CLAUDE.md \
   ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md

cp ai-governance-vatandas-plugin/config-template/ai-temas-envanteri.yaml \
   ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/

cp ai-governance-vatandas-plugin/config-template/sure-takvimi.yaml \
   ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/

cp ai-governance-vatandas-plugin/config-template/dogrulama-gunlugu.md \
   ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/
```

### 4. Hook'u settings.json'a ekleyin

`~/.claude/settings.json` dosyasını açın. Yoksa oluşturun. Aşağıdaki bloğu `hooks` alanına ekleyin (varsa merge edin):

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": "ai-governance-legal|ai-governance-vatandas",
        "hooks": [
          {
            "type": "command",
            "command": "ai-governance-vatandas-prehook --check-pii"
          }
        ]
      }
    ]
  }
}
```

> **Not:** Eğer Claude Code'un komut tabanlı hook'ları desteklemiyorsa, hook olarak inline talimat verilebilir — `hooks/hooks.json` dosyasındaki alternatif konfigürasyon kullanılır.

### 5. Claude Code'u yeniden başlatın

```bash
# CLI ise: çık ve tekrar başlat
# Cowork ise: uygulamayı kapatıp yeniden açın
```

### 6. Cold-start mülakatı

Claude Code/Cowork'ta:

```
/ai-governance-vatandas-legal:cold-start-interview
```

---

## Seçenek C — Sadece config update (mevcut ai-governance-legal eklentisi üzerine)

Eğer orijinal Anthropic `ai-governance-legal` eklentisini kurulu tutmak istiyorsanız ve sadece **konfigürasyonu** vatandaş moduna çevirmek istiyorsanız:

```bash
# Sadece config dosyalarını kopyala — plugin dosyalarına dokunma
cp ai-governance-vatandas-plugin/config-template/CLAUDE.md \
   ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md

cp ai-governance-vatandas-plugin/config-template/company-profile.md \
   ~/.claude/plugins/config/claude-for-legal/company-profile.md

cp ai-governance-vatandas-plugin/config-template/ai-temas-envanteri.yaml \
   ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/

cp ai-governance-vatandas-plugin/config-template/sure-takvimi.yaml \
   ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/
```

Bu durumda orijinal eklentinin skill dosyaları (vendor-ai-review, AIA, use-case-triage) hâlâ yerinde olur, ama CLAUDE.md'deki vatandaş profili sayesinde davranışları farklılaşır. **Yeni vatandaş-spesifik skill'ler (otomatik-karar-itirazi, eserim-ai-training vb.) çalışmaz.**

Daha sonra Seçenek A veya B'ye geçebilirsiniz.

---

## Doğrulama

Kurulum doğru çalıştı mı? Test edin:

```
/ai-governance-vatandas-legal:customize --check-integrations
```

Şu çıktıyı görmelisiniz:

```
✓ mevzuat_mcp
✓ yargi_mcp (KVKK endpoint dahil)
✓ literatur_mcp
✓ yoktez_mcp
⏳ markapatent_mcp (bağlanıyor)
✓ hukuk_rag
✓ scheduled-tasks
✓ cowork
```

Sonra envanter testi:

```
/ai-governance-vatandas-legal:ai-temas-envanteri list
```

Boş envanter listesini görmelisiniz (henüz sistem eklemediğiniz için).

---

## Kaldırma

```bash
bash ai-governance-vatandas-plugin/scripts/uninstall.sh
```

Script kullanıcı verilerinizi (envanter, çıktılar, matters) SİLMEZ — sadece plugin dosyalarını kaldırır. Tam temizlik için terminal çıktısındaki manuel adımları izleyin.

---

## Sorun giderme

**S: `bash: command not found: ai-governance-vatandas-prehook`**  
C: Hook tanımı `command` tipinde. Sisteminizde böyle bir komut yok. Hook'u devre dışı bırakmak için `~/.claude/settings.json`'da bu hook'u kaldırın. Alternatif olarak `hooks/hooks.json`'daki inline tip kullanılabilir.

**S: Skill'i çağırdığımda 'CLAUDE.md placeholder var' diyor.**  
C: `~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md` doğru konuma yerleşmemiş. Manuel kontrol edin:
```bash
ls -la ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md
cat ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/CLAUDE.md | head -20
```

**S: Yargi_mcp KVKK endpoint çalışmıyor.**  
C: Önce sağlık testi:
```
mcp__yargi_mcp__check_government_servers_health
```
KVKK servisi geçici olarak erişilebilir olmayabilir; birkaç saat sonra tekrar deneyin.

**S: Agent'lar otomatik çalışmıyor.**  
C: Cold-start sonunda agent kayıt teklifini onaylamış olmanız gerekir. Manuel kayıt için:
```
mcp__scheduled-tasks__list_scheduled_tasks
```
ile mevcut görevleri kontrol edin; yoksa Claude'a "agent'ları kur" deyin.

---

## Bilgi alma

```
ls -la ~/.claude/plugins/ai-governance-vatandas-legal/
ls -la ~/.claude/plugins/config/claude-for-legal/ai-governance-legal/
```

Veya Claude'a:

> "ai-governance-vatandas eklentisi kurulu mu? Tüm dosyaları teyit et."
