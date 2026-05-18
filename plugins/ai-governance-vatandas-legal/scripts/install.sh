#!/usr/bin/env bash
# AI Governance Vatandaş Eklenti — Otomatik Kurulum
# Çalıştırma: bash scripts/install.sh   (plugin kök dizininden)
# veya:        bash ai-governance-vatandas-plugin/scripts/install.sh

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
PLUGIN_NAME="ai-governance-vatandas-legal"

# Hedef yollar
CONFIG_BASE="${HOME}/.claude/plugins/config/claude-for-legal"
PLUGIN_CONFIG="${CONFIG_BASE}/ai-governance-legal"
PLUGINS_DIR="${HOME}/.claude/plugins/${PLUGIN_NAME}"
SETTINGS_FILE="${HOME}/.claude/settings.json"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  AI Governance — Vatandaş Versiyonu — Kurulum                    ║${NC}"
echo -e "${BLUE}║  Plugin: ${PLUGIN_NAME}                       ║${NC}"
echo -e "${BLUE}║  Sürüm: 1.0.0                                                    ║${NC}"
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
# Plugin dosyalarını ~/.claude/plugins/ altına kopyala
rsync -a --exclude='scripts' --exclude='config-template' --exclude='references/00-MIMARI-KARARLARI.md' --exclude='references/04-DOGRULAMA-RAPORU.md' "${PLUGIN_DIR}/" "${PLUGINS_DIR}/"
echo -e "${GREEN}✓ Plugin dosyaları ${PLUGINS_DIR} altına yüklendi${NC}"
echo

# --- Adım 4: Config dosyalarını yerleştir ---
echo -e "${YELLOW}[4/7] Kullanıcı profil dosyaları yerleştiriliyor...${NC}"

# company-profile.md
if [ -f "${CONFIG_BASE}/company-profile.md" ]; then
    echo -e "${YELLOW}  ! company-profile.md zaten var. Üzerine yazılsın mı? [y/N]${NC}"
    read -r CONFIRM
    if [[ "${CONFIRM}" == "y" || "${CONFIRM}" == "Y" ]]; then
        cp "${PLUGIN_DIR}/config-template/company-profile.md" "${CONFIG_BASE}/company-profile.md"
        echo -e "${GREEN}✓ company-profile.md güncellendi${NC}"
    else
        echo -e "${YELLOW}  → Atlandı (mevcut korundu)${NC}"
    fi
else
    cp "${PLUGIN_DIR}/config-template/company-profile.md" "${CONFIG_BASE}/company-profile.md"
    echo -e "${GREEN}✓ company-profile.md yerleştirildi${NC}"
fi

# CLAUDE.md
if [ -f "${PLUGIN_CONFIG}/CLAUDE.md" ]; then
    echo -e "${YELLOW}  ! Plugin CLAUDE.md zaten var. Üzerine yazılsın mı? [y/N]${NC}"
    read -r CONFIRM
    if [[ "${CONFIRM}" == "y" || "${CONFIRM}" == "Y" ]]; then
        cp "${PLUGIN_DIR}/config-template/CLAUDE.md" "${PLUGIN_CONFIG}/CLAUDE.md"
        echo -e "${GREEN}✓ Plugin CLAUDE.md güncellendi${NC}"
    else
        echo -e "${YELLOW}  → Atlandı (mevcut korundu)${NC}"
    fi
else
    cp "${PLUGIN_DIR}/config-template/CLAUDE.md" "${PLUGIN_CONFIG}/CLAUDE.md"
    echo -e "${GREEN}✓ Plugin CLAUDE.md yerleştirildi${NC}"
fi

# Boş YAML dosyaları
if [ ! -f "${PLUGIN_CONFIG}/ai-temas-envanteri.yaml" ]; then
    cp "${PLUGIN_DIR}/config-template/ai-temas-envanteri.yaml" "${PLUGIN_CONFIG}/ai-temas-envanteri.yaml"
    echo -e "${GREEN}✓ ai-temas-envanteri.yaml (boş) yerleştirildi${NC}"
fi
if [ ! -f "${PLUGIN_CONFIG}/sure-takvimi.yaml" ]; then
    cp "${PLUGIN_DIR}/config-template/sure-takvimi.yaml" "${PLUGIN_CONFIG}/sure-takvimi.yaml"
    echo -e "${GREEN}✓ sure-takvimi.yaml (boş) yerleştirildi${NC}"
fi
if [ ! -f "${PLUGIN_CONFIG}/dogrulama-gunlugu.md" ]; then
    cp "${PLUGIN_DIR}/config-template/dogrulama-gunlugu.md" "${PLUGIN_CONFIG}/dogrulama-gunlugu.md"
    echo -e "${GREEN}✓ dogrulama-gunlugu.md yerleştirildi${NC}"
fi
echo

# --- Adım 5: Hooks settings.json'a merge ---
echo -e "${YELLOW}[5/7] Hook konfigürasyonu hazırlanıyor...${NC}"
if [ -f "${SETTINGS_FILE}" ]; then
    echo -e "${YELLOW}  ! settings.json zaten var. Hook'ları manuel eklemek gerekiyor.${NC}"
    echo -e "${YELLOW}  → Şu dosyaya bak: ${PLUGIN_DIR}/hooks/hooks.json${NC}"
    echo -e "${YELLOW}  → Hook bloğunu mevcut settings.json'a merge edin.${NC}"
else
    cat > "${SETTINGS_FILE}" <<'EOF'
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": "ai-governance-legal|ai-governance-vatandas",
        "hooks": [
          {
            "type": "command",
            "command": "ai-governance-vatandas-prehook --check-pii",
            "description": "Kişisel veri tespit + anonimleştirme önerisi (KVKK m.4-5, TCK m.135-136)"
          }
        ]
      }
    ]
  }
}
EOF
    echo -e "${GREEN}✓ settings.json oluşturuldu, hook eklendi${NC}"
fi
echo

# --- Adım 6: Scheduled agents kayıt notu ---
echo -e "${YELLOW}[6/7] Scheduled agent'lar...${NC}"
echo -e "${YELLOW}  ! Agent'lar Claude Code içinde kaydedilmeli (bash script bunu yapamaz).${NC}"
echo -e "${BLUE}  Claude Code'da şunu çalıştırın:${NC}"
echo
echo -e "    ${BLUE}/ai-governance-vatandas-legal:cold-start-interview${NC}"
echo
echo -e "${BLUE}  Mülakat sonunda Claude size üç agent'ı kayıt teklif edecek:${NC}"
echo -e "    - tos-degisiklik-watcher (haftalık Pazartesi 09:00)"
echo -e "    - kvkk-kurul-kararlari-sweeper (haftalık Çarşamba 09:00)"
echo -e "    - sure-takipcisi (günlük 08:00)"
echo

# --- Adım 7: Doğrulama ---
echo -e "${YELLOW}[7/7] Kurulum doğrulanıyor...${NC}"
ERRORS=0

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}  ✓${NC} $2"
    else
        echo -e "${RED}  ✗${NC} $2 — EKSİK!"
        ERRORS=$((ERRORS + 1))
    fi
}

check_file "${PLUGINS_DIR}/.claude-plugin/plugin.json" "Plugin manifest"
check_file "${PLUGINS_DIR}/CLAUDE.md" "Plugin template"
check_file "${PLUGINS_DIR}/skills/cold-start-interview/SKILL.md" "Skill: cold-start-interview"
check_file "${PLUGINS_DIR}/skills/otomatik-karar-itirazi/SKILL.md" "Skill: otomatik-karar-itirazi"
check_file "${PLUGINS_DIR}/skills/eserim-ai-training/SKILL.md" "Skill: eserim-ai-training"
check_file "${PLUGINS_DIR}/skills/kvkk-veri-itirazi/SKILL.md" "Skill: kvkk-veri-itirazi"
check_file "${PLUGINS_DIR}/skills/platform-ai-tos-inceleme/SKILL.md" "Skill: platform-ai-tos-inceleme"
check_file "${PLUGINS_DIR}/skills/ai-uretim-icerik-tespit/SKILL.md" "Skill: ai-uretim-icerik-tespit"
check_file "${PLUGINS_DIR}/skills/ai-temas-envanteri/SKILL.md" "Skill: ai-temas-envanteri"
check_file "${PLUGINS_DIR}/agents/tos-degisiklik-watcher.md" "Agent: tos-degisiklik-watcher"
check_file "${PLUGINS_DIR}/agents/kvkk-kurul-kararlari-sweeper.md" "Agent: kvkk-kurul-kararlari-sweeper"
check_file "${PLUGINS_DIR}/agents/sure-takipcisi.md" "Agent: sure-takipcisi"
check_file "${PLUGINS_DIR}/hooks/hooks.json" "Hook config"
check_file "${PLUGINS_DIR}/hooks/kisisel-veri-anonimlestirme-prehook.md" "Hook: anonimleştirme"
check_file "${CONFIG_BASE}/company-profile.md" "Config: company-profile.md"
check_file "${PLUGIN_CONFIG}/CLAUDE.md" "Config: CLAUDE.md"
check_file "${PLUGIN_CONFIG}/ai-temas-envanteri.yaml" "Envanter dosyası"
check_file "${PLUGIN_CONFIG}/sure-takvimi.yaml" "Süre takvim dosyası"

echo
if [ ${ERRORS} -eq 0 ]; then
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✓ KURULUM TAMAMLANDI                                            ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "${BLUE}Sonraki adımlar:${NC}"
    echo
    echo -e "  ${BLUE}1.${NC} Claude Code'u (veya Cowork'u) yeniden başlatın"
    echo -e "  ${BLUE}2.${NC} Çalıştırın: ${YELLOW}/ai-governance-vatandas-legal:cold-start-interview${NC}"
    echo -e "  ${BLUE}3.${NC} Mülakat sonunda agent'ları kaydetmeyi onaylayın"
    echo -e "  ${BLUE}4.${NC} İlk test: ${YELLOW}/ai-governance-vatandas-legal:ai-temas-envanteri list${NC}"
    echo
    echo -e "${BLUE}Detaylı kullanım kılavuzu:${NC} ${PLUGINS_DIR}/README.md"
    echo -e "${BLUE}Mimari kararlar (CoT belgesi):${NC} ${PLUGIN_DIR}/references/00-MIMARI-KARARLARI.md"
    echo
    echo -e "${BLUE}Yedek konum:${NC} ${BACKUP_DIR}"
    echo -e "${BLUE}Kaldırma:${NC} bash scripts/uninstall.sh"
else
    echo -e "${RED}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║  ✗ KURULUM EKSİK — ${ERRORS} dosya bulunamadı                            ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════════╝${NC}"
    echo
    echo "Lütfen plugin paketini kontrol edin. Yedek: ${BACKUP_DIR}"
    exit 1
fi
