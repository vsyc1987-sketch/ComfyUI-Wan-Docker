#!/bin/bash

# Цвета для удобства чтения в логах RunPod
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${NC}"
echo -e "${YELLOW}!!! СИСТЕМА САМОДИАГНОСТИКИ И ЗАПУСКА ARTOIS !!!${NC}"
echo -e "${YELLOW}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${NC}"

# 1. ПРОВЕРКА ДИСКОВОГО ПРОСТРАНСТВА
FREE_SPACE=$(df -h /workspace | awk 'NR==2 {print $4}' | sed 's/G//')
echo -e "--- ПРОВЕРКА ДИСКА: Свободно ${FREE_SPACE} GB ---"
if (( $(echo "$FREE_SPACE < 40" | bc -l) )); then
    echo -e "${RED}!!! ОШИБКА: МЕСТА МЕНЬШЕ 40GB! МОДЕЛИ НЕ ВЛЕЗУТ. НУЖНО 60-80GB !!!${NC}"
else
    echo -e "${GREEN}>>> МЕСТА ДОСТАТОЧНО.${NC}"
fi

# 2. ПОИСК ЯДРА И ПРОВЕРКА ПУТЕЙ
echo -e "--- ПОИСК COMFYUI В СИСТЕМЕ... ---"
REAL_MAIN=$(find /workspace -maxdepth 3 -name "main.py" | grep -v "custom_nodes" | grep -v "lib2to3" | head -n 1)

if [ -z "$REAL_MAIN" ]; then
    echo -e "${RED}!!! КРИТИЧЕСКАЯ ОШИБКА: main.py НЕ НАЙДЕН! ПРОВЕРЬТЕ DOCKER-ОБРАЗ !!!${NC}"
    exit 1
fi
COMFY_DIR=$(dirname "$REAL_MAIN")
echo -e "${GREEN}>>> ПУТЬ ПОДТВЕРЖДЕН: $COMFY_DIR${NC}"

# 3. ПОЧИНКА БИБЛИОТЕК (FIX TORCHAUDIO)
echo -e "--- ЛЕЧЕНИЕ БИБЛИОТЕК (Fixing undefined symbols)... ---"
pip install --no-cache-dir torchaudio==2.1.0+cu121 --index-url https://download.pytorch.org/whl/cu121 --quiet
if [ $? -eq 0 ]; then
    echo -e "${GREEN}>>> БИБЛИОТЕКИ ОБНОВЛЕНЫ.${NC}"
else
    echo -e "${YELLOW}!!! ПРЕДУПРЕЖДЕНИЕ: ОШИБКА ПРИ ОБНОВЛЕНИИ БИБЛИОТЕК !!!${NC}"
fi

# 4. УСТАНОВКА ТВОЕГО ВОРКФЛОУ КАК ДЕФОЛТНОГО
echo -e "--- ЗАГРУЗКА ШАБЛОНА ARTOIS WAN 2.2... ---"
WFLOW_URL="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"
mkdir -p "$COMFY_DIR/web/scripts"
wget -q -O "$COMFY_DIR/web/scripts/default_workflow.json" "$WFLOW_URL"
wget -q -O "$COMFY_DIR/artius_wan.json" "$WFLOW_URL"
echo -e "${GREEN}>>> ВОРКФЛОУ УСТАНОВЛЕН ПО УМОЛЧАНИЮ.${NC}"

# 5. ПРОВЕРКА И ЗАГРУЗКА МОДЕЛЕЙ
echo
