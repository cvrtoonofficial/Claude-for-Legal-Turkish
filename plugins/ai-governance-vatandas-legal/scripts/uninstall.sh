#!/usr/bin/env bash
# AI Governance Vatandaş Eklenti — Kaldırma
# Çalıştırma: bash scripts/uninstall.sh
# UYARI: Kullanıcı verilerini (envanter, çıktılar, matters) SİLMEZ — sadece plugin dosyalarını kaldırır.

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

PLUGIN_NAME="ai-governance-vatandas-legal"
PLUGINS_DIR="${HOME}/.claude/plugins/${PLUGIN_NAME}"
CONFIG_BASE="${HOME}/.claude/plugins/config/claude-for-legal"
PLUGIN_CONFIG="${CONFIG_BASE}/ai-governance-legal"

echo -e "${BLUE}AI Governance Vatandaş — Kaldırma${NC}"
echo

echo -e "${YELLOW}Bu işlem:${NC}"
echo "  ✗ ${PLUGINS_DIR} klasörünü SİLECEK"
echo "  ! ${PLUGIN_CONFIG} klasöründeki KULLANICI VERİSİ KORUNACAK"
echo "    (envanter, çıktılar, matters, dilekçeleriniz orada kalır)"
echo "  ! settings.json'daki hook'lar SİLİNMEYECEK (manuel kaldırın)"
echo

echo -e "${YELLOW}Devam edilsin mi? [y/N]${NC}"
read -r CONFIRM
if [[ "${CONFIRM}" != "y" && "${CONFIRM}" != "Y" ]]; then
    echo "İptal edildi."
    exit 0
fi

# Yedek al
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="${HOME}/.claude/backups/${PLUGIN_NAME}_uninstall_${TIMESTAMP}"
mkdir -p "${BACKUP_DIR}"

if [ -d "${PLUGIN_CONFIG}" ]; then
    cp -r "${PLUGIN_CONFIG}" "${BACKUP_DIR}/config-backup"
    echo -e "${GREEN}✓ Config klasörü yedeklendi → ${BACKUP_DIR}/config-backup${NC}"
fi

# Plugin dosyalarını sil
if [ -d "${PLUGINS_DIR}" ]; then
    rm -rf "${PLUGINS_DIR}"
    echo -e "${GREEN}✓ Plugin dosyaları kaldırıldı${NC}"
fi

echo
echo -e "${GREEN}Kaldırma tamamlandı.${NC}"
echo -e "${YELLOW}Manuel adımlar:${NC}"
echo "  1. ${HOME}/.claude/settings.json içindeki hook'ları manuel kaldırın"
echo "  2. Eğer kullanıcı verisini de silmek isterseniz:"
echo "     rm -rf ${PLUGIN_CONFIG}"
echo "  3. Yedek: ${BACKUP_DIR}"
