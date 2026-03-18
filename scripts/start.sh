#!/bin/bash
# 1. Пути
COMFY_DIR=$(find /workspace -maxdepth 2 -name "main.py" -exec dirname {} \; | head -n 1)
cd "$COMFY_DIR"

# 2. Установка Менеджера (если пусто)
if [ ! -d "custom_nodes/ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager
fi

# 3. Твой Workflow Artois Wan 2.2
WFLOW_URL="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"
mkdir -p "web/scripts"
wget -q -O "web/scripts/default_workflow.json" "$WFLOW_URL"

# 4. Фикс NumPy (чтобы не вылетало)
pip install "numpy<2" --quiet

# 5. Запуск
python3 main.py --listen 0.0.0.0 --port 8188
