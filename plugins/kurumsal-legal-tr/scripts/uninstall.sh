#!/usr/bin/env bash
# Kurumsal Hukuk TR Eklenti — Kaldırma Scripti
# Çalıştırma: bash scripts/uninstall.sh

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PLUGIN_NAME="kurumsal-legal-tr"
CONFIG_BASE="${HOME}/.claude/plugins/config/claude-for-legal"
PLUGIN_CONFIG="${CONFIG_BASE}/${PLUGIN_NAME}"
PLUGINS_DIR="${HOME}/.claude/plugins/${PLUGIN_NAME}"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Kurumsal Hukuk TR — Kaldırma                                    ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════════╝${NC}"
echo

# Yedek
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="${HOME}/.claude/backups/${PLUGIN_NAME}_uninstall_${TIMESTAMP}"
mkdir -p "${BACKUP_DIR}"

echo -e "${YELLOW}Kullanıcı verisi (matter'lar, çıktılar, profil) korunsun mu? [Y/n]${NC}"
read -r KEEP_DATA

if [[ "${KEEP_DATA}" == "n" || "${KEEP_DATA}" == "N" ]]; then
    if [ -d "${PLUGIN_CONFIG}" ]; then
        cp -r "${PLUGIN_CONFIG}" "${BACKUP_DIR}/config_backup"
        echo -e "${GREEN}✓ Config yedeği: ${BACKUP_DIR}/config_backup${NC}"
        rm -rf "${PLUGIN_CONFIG}"
        echo -e "${GREEN}✓ Config dizini silindi${NC}"
    fi
else
    echo -e "${BLUE}  → Config korundu: ${PLUGIN_CONFIG}${NC}"
fi

if [ -d "${PLUGINS_DIR}" ]; then
    cp -r "${PLUGINS_DIR}" "${BACKUP_DIR}/plugin_backup"
    rm -rf "${PLUGINS_DIR}"
    echo -e "${GREEN}✓ Plugin dosyaları silindi (yedek: ${BACKUP_DIR}/plugin_backup)${NC}"
fi

echo -e "${YELLOW}settings.json'dan plugin satırını manuel olarak kaldırın:${NC}"
echo -e "    ${HOME}/.claude/settings.json"
echo
echo -e "${GREEN}✓ Kaldırma tamamlandı${NC}"
echo -e "${BLUE}Yedek: ${BACKUP_DIR}${NC}"
