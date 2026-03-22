#!/bin/bash
G='\033[0;32m'; Y='\033[1;33m'; R='\033[0;31m'; NC='\033[0m'

echo -e "${Y}--- ПОЛНАЯ НАСТРОЙКА СИСТЕМЫ: ARTOIS + JUPYTER ---${NC}"

# 1. Поиск папки ComfyUI
COMFY_DIR=$(find /workspace -maxdepth 2 -name "main.py" -exec dirname {} \; | head -n 1)
cd "$COMFY_DIR"

# 2. Исправление критических ошибок (NumPy и зависимости)
echo -e "${Y}Оптимизация библиотек...${NC}"
pip install "numpy<2" jupyterlab --quiet

# 3. Установка ComfyUI-Manager (если его нет)
if [ ! -d "custom_nodes/ComfyUI-Manager" ]; then
    echo -e "${Y}Установка Менеджера...${NC}"
    git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager --quiet
fi

# 4. Загрузка твоего Workflow (Artois Wan 2.2)
WFLOW="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"
mkdir -p "web/scripts"
wget -q -O "web/scripts/default_workflow.json" "$WFLOW"
wget -q -O "/workspace/artius_wan_2.2.json" "$WFLOW"

# 5. Запуск JupyterLab в фоне (Порт 8888)
nohup jupyter lab --allow-root --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password='' > /workspace/jupyter.log 2>&1 &
echo -e "${G}>>> JUPYTER LAB ЗАПУЩЕН НА ПОРТУ 8888 <<<${NC}"

# 6. Финальная проверка моделей (только если их нет)
mkdir -p "models/unet" "models/vae"
# (Здесь система подхватит уже скачанные тобой ранее модели из папок)

echo -e "${G}!!! СИСТЕМА ГОТОВА. ЗАПУСКАЮ COMFYUI !!!${NC}"

# 7. Запуск ComfyUI (Порт 8188)
python3 main.py --listen 0.0.0.0 --port 8188
