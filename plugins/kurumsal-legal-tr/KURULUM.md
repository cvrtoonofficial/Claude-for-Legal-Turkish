# Kurulum Kılavuzu — Kurumsal Hukuk TR

## Hızlı kurulum (önerilen)

```bash
git clone https://github.com/cvrtoonofficial/Claude-for-Legal-Turkish.git
cd Claude-for-Legal-Turkish/plugins/kurumsal-legal-tr
bash scripts/install.sh
```

Script:
1. Mevcut kurulumu yedekler (`~/.claude/backups/` altına)
2. Dizin yapısını kurar (`~/.claude/plugins/kurumsal-legal-tr/` ve `~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/`)
3. Plugin dosyalarını kopyalar (skill'ler, agent'lar, hooks)
4. Profil template'ini config dizinine yerleştirir
5. `settings.json`'a plugin'i ekler
6. MCP bağımlılıklarını doğrular

---

## Manuel kurulum (script çalışmazsa)

### 1. Plugin dosyalarını kopyala

```bash
PLUGIN_NAME="kurumsal-legal-tr"
PLUGIN_SRC="$(pwd)"   # repo kökünden plugins/kurumsal-legal-tr/ olduğunuza emin olun
PLUGIN_DST="${HOME}/.claude/plugins/${PLUGIN_NAME}"

mkdir -p "${PLUGIN_DST}"
rsync -a --exclude='scripts' --exclude='config-template' "${PLUGIN_SRC}/" "${PLUGIN_DST}/"
```

### 2. Config dizinini kur

```bash
CONFIG_BASE="${HOME}/.claude/plugins/config/claude-for-legal"
PLUGIN_CONFIG="${CONFIG_BASE}/kurumsal-legal-tr"

mkdir -p "${PLUGIN_CONFIG}"/{seed,ciktilar,matters}
mkdir -p "${CONFIG_BASE}"
```

### 3. Profil template'ini yerleştir

```bash
cp "${PLUGIN_SRC}/config-template/CLAUDE.md" "${PLUGIN_CONFIG}/CLAUDE.md"
cp "${PLUGIN_SRC}/config-template/company-profile.md" "${CONFIG_BASE}/company-profile.md"
```

> **Not:** `company-profile.md` zaten varsa **üzerine yazılmamalıdır** — başka plugin'ler de bu dosyayı kullanabilir.

### 4. `settings.json`'a plugin'i ekle

`~/.claude/settings.json` dosyasını editleyip `plugins` listesine ekleyin:

```json
{
  "plugins": [
    "kurumsal-legal-tr"
  ]
}
```

veya mevcut listenin sonuna ekleyin.

---

## İlk çalıştırma

Cowork'te veya Claude Code'da:

```
/kurumsal-legal-tr:cold-start-interview
```

veya doğal dilde:

> "kurumsal hukuk plugin'ini kuralım"

Plugin sizinle 8-10 dakikalık bir mülakat yapacak ve `CLAUDE.md` profilinizi yazacaktır.

---

## MCP bağımlılık kontrolü

Plugin şu MCP'leri çağırır. Çalıştığını doğrulamak için:

```bash
# Claude Code'da
claude mcp list

# beklenen çıktıda gözükmesi gerekenler:
# - mevzuat_mcp     (zorunlu)
# - yargi_mcp       (zorunlu)
# - literatur_mcp   (tavsiye)
# - yoktez_mcp      (tavsiye)
# - hukuk_rag       (tavsiye — kendi büro corpus'unuz)
# - markapatent_mcp (tavsiye)
```

Eksik MCP varsa Plugin yine çalışır, ancak ilgili kategorideki atıflar `[model bilgisi — doğrula]` etiketi alır.

---

## Doğrulama

Kurulum sonrası:

```bash
# Plugin dosyaları yerinde mi?
ls -la ~/.claude/plugins/kurumsal-legal-tr/

# Config doğru kuruldu mu?
head -20 ~/.claude/plugins/config/claude-for-legal/kurumsal-legal-tr/CLAUDE.md

# Plugin tanındı mı?
grep -i "kurumsal-legal-tr" ~/.claude/settings.json
```

---

## Sorun giderme

### "Plugin bulunamadı" hatası
`~/.claude/settings.json`'da plugin listede mi? Plugin dizini `~/.claude/plugins/kurumsal-legal-tr/` altında mı?

### "Config gerekiyor" uyarısı
`CLAUDE.md` profil dosyası `[PLACEHOLDER]` içeriyor olabilir. `/kurumsal-legal-tr:cold-start-interview` çalıştırın.

### MCP atıfları çalışmıyor
İlgili MCP servisinin Claude Code'a kayıtlı olduğundan emin olun: `claude mcp list`.

### Eski kurulumu temizle
```bash
bash scripts/uninstall.sh
```

---

## Güncelleme

Repo'nun yeni sürümü çıktığında:

```bash
cd Claude-for-Legal-Turkish
git pull origin main
cd plugins/kurumsal-legal-tr
bash scripts/install.sh   # mevcut config'i koruyarak günceller
```

`install.sh`, plugin dosyalarını günceller ama **kullanıcı config'ini** (CLAUDE.md, company-profile.md, matter'lar) **korur**.
