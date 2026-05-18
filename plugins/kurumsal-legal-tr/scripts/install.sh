#!/usr/bin/env bash
# Kurumsal Hukuk TR Eklenti — Otomatik Kurulum
# Çalıştırma: bash scripts/install.sh   (plugin kök dizininden)

set -euo pipefail

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Yolları belirle
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
PLUGIN_NAME="kurumsal-legal-tr"

# Hedef yollar
CONFIG_BASE="${HOME}/.claude/plugins/config/claude-for-legal"
PLUGIN_CONFIG="${CONFIG_BASE}/${PLUGIN_NAME}"
PLUGINS_DIR="${HOME}/.claude/plugins/${PLUGIN_NAME}"
SETTINGS_FILE="${HOME}/.claude/settings.json"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Kurumsal Hukuk TR — Kurulum                                     ║${NC}"
echo -e "${BLUE}║  Plugin: ${PLUGIN_NAME}                                       ║${NC}"
echo -e "${BLUE}║  Sürüm: 1.0.0                                                    ║${NC}"
echo -e "${BLUE}║  Mevzuat: TTK 6102 + BK 6098 + FSEK 5846 + SMK 6769 + HMK 6100   ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════════╝${NC}"
echo

# --- Adım 0: Önkoşul kontrolü ---
echo -e "${YELLOW}[0/7] Önkoşul kontrolü...${NC}"
if [ ! -d "${HOME}/.claude" ]; then
    echo -e "${RED}HATA: ${HOME}/.claude dizini yok. Claude Code/Cowork kurulu mu?${NC}"
    exit 1
fi
if [ ! -f "${PLUGIN_DIR}/.claude-plugin/plugin.json" ]; then
    echo -e "${RED}HATA: plugin.json bulunamadı. Bu script'i plugin dizininden çalıştırın.${NC}"
    echo -e "       Beklenen: ${PLUGIN_DIR}/.claude-plugin/plugin.json"
    exit 1
fi
echo -e "${GREEN}✓ Önkoşullar tamam${NC}"
echo

# --- Adım 1: Eski kurulum yedeği ---
echo -e "${YELLOW}[1/7] Mevcut kurulumun yedeği alınıyor...${NC}"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="${HOME}/.claude/backups/${PLUGIN_NAME}_${TIMESTAMP}"
mkdir -p "${BACKUP_DIR}"

if [ -f "${PLUGIN_CONFIG}/CLAUDE.md" ]; then
    cp "${PLUGIN_CONFIG}/CLAUDE.md" "${BACKUP_DIR}/CLAUDE.md.backup"
    echo -e "${GREEN}✓ Mevcut CLAUDE.md yedeklendi → ${BACKUP_DIR}/${NC}"
fi
if [ -f "${CONFIG_BASE}/company-profile.md" ]; then
    cp "${CONFIG_BASE}/company-profile.md" "${BACKUP_DIR}/company-profile.md.backup"
    echo -e "${GREEN}✓ Mevcut company-profile.md yedeklendi${NC}"
fi
if [ -f "${SETTINGS_FILE}" ]; then
    cp "${SETTINGS_FILE}" "${BACKUP_DIR}/settings.json.backup"
    echo -e "${GREEN}✓ Mevcut settings.json yedeklendi${NC}"
fi
echo

# --- Adım 2: Dizinleri oluştur ---
echo -e "${YELLOW}[2/7] Dizin yapısı oluşturuluyor...${NC}"
mkdir -p "${CONFIG_BASE}"
mkdir -p "${PLUGIN_CONFIG}"/{seed,ciktilar,matters}
mkdir -p "${PLUGINS_DIR}"
echo -e "${GREEN}✓ Dizinler hazır${NC}"
echo

# --- Adım 3: Plugin dosyalarını kopyala ---
echo -e "${YELLOW}[3/7] Plugin dosyaları yükleniyor...${NC}"
rsync -a --exclude='scripts' --exclude='config-template' "${PLUGIN_DIR}/" "${PLUGINS_DIR}/"
echo -e "${GREEN}✓ Plugin dosyaları ${PLUGINS_DIR} altına yüklendi${NC}"
echo

# --- Adım 4: Config dosyalarını yerleştir ---
echo -e "${YELLOW}[4/7] Kullanıcı profil dosyaları yerleştiriliyor...${NC}"

# CLAUDE.md
if [ -f "${PLUGIN_CONFIG}/CLAUDE.md" ]; then
    echo -e "${YELLOW}  ! CLAUDE.md zaten var. Üzerine yazılsın mı? [y/N]${NC}"
    read -r CONFIRM
    if [[ "${CONFIRM}" == "y" || "${CONFIRM}" == "Y" ]]; then
        cp "${PLUGIN_DIR}/config-template/CLAUDE.md" "${PLUGIN_CONFIG}/CLAUDE.md"
        echo -e "${GREEN}✓ CLAUDE.md güncellendi (eski yedeklendi)${NC}"
    else
        echo -e "${YELLOW}  → Atlandı (mevcut korundu)${NC}"
    fi
else
    cp "${PLUGIN_DIR}/config-template/CLAUDE.md" "${PLUGIN_CONFIG}/CLAUDE.md"
    echo -e "${GREEN}✓ CLAUDE.md yerleştirildi${NC}"
fi

# company-profile.md (paylaşılan dosya — varsa dokunma)
if [ ! -f "${CONFIG_BASE}/company-profile.md" ]; then
    cp "${PLUGIN_DIR}/config-template/company-profile.md" "${CONFIG_BASE}/company-profile.md"
    echo -e "${GREEN}✓ company-profile.md yerleştirildi (paylaşılan dosya)${NC}"
else
    echo -e "${YELLOW}  → company-profile.md zaten var (başka plugin tarafından oluşturulmuş olabilir) — korundu${NC}"
fi
echo

# --- Adım 5: settings.json'a plugin'i kaydet ---
echo -e "${YELLOW}[5/7] settings.json güncelleniyor...${NC}"
if [ -f "${SETTINGS_FILE}" ]; then
    if grep -q "\"${PLUGIN_NAME}\"" "${SETTINGS_FILE}"; then
        echo -e "${GREEN}✓ Plugin zaten kayıtlı${NC}"
    else
        # Basit ekleme: kullanıcı manuel doğrulamalı
        echo -e "${YELLOW}  → settings.json'a plugin'i ekleyin (manuel):${NC}"
        echo -e "${YELLOW}    \"plugins\": [ ..., \"${PLUGIN_NAME}\" ]${NC}"
    fi
else
    echo -e "${YELLOW}  → settings.json yok. Claude Code/Cowork'te plugin'i ilk açtığınızda otomatik oluşur.${NC}"
fi
echo

# --- Adım 6: MCP bağımlılık kontrolü ---
echo -e "${YELLOW}[6/7] MCP bağımlılık kontrolü...${NC}"
echo -e "${BLUE}  Zorunlu: yargi_mcp, mevzuat_mcp${NC}"
echo -e "${BLUE}  Tavsiye: literatur_mcp, yoktez_mcp, hukuk_rag, markapatent_mcp${NC}"
if command -v claude &> /dev/null; then
    echo -e "${YELLOW}  → 'claude mcp list' komutuyla MCP servislerinizi doğrulayın${NC}"
fi
echo

# --- Adım 7: Final ---
echo -e "${YELLOW}[7/7] Kurulum tamamlanıyor...${NC}"
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✓ KURULUM BAŞARILI                                              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${BLUE}Sonraki adım:${NC}"
echo -e "  Cowork veya Claude Code'da şunu çalıştırın:"
echo -e "  ${YELLOW}/${PLUGIN_NAME}:cold-start-interview${NC}"
echo -e "  veya doğal dilde:"
echo -e "  ${YELLOW}\"kurumsal hukuk plugin'ini kuralım\"${NC}"
echo
echo -e "${BLUE}Yedek konumu:${NC} ${BACKUP_DIR}"
echo -e "${BLUE}Config konumu:${NC} ${PLUGIN_CONFIG}"
echo -e "${BLUE}Plugin konumu:${NC} ${PLUGINS_DIR}"
echo
echo -e "${YELLOW}⚠️  YASAL UYARI:${NC} Bu eklenti hukuki tavsiye değildir. Çıktılar baroya kayıtlı"
echo -e "    avukat onayı olmadan resmi mercilere sunulmamalıdır. Detay: README.md"
