#!/bin/bash
# Находим папку ComfyUI
COMFY_DIR=$(find /workspace -maxdepth 2 -name "main.py" -exec dirname {} \; | head -n 1)
cd "$COMFY_DIR"

# 1. Менеджер и твой Воркфлоу
[ -d "custom_nodes/ComfyUI-Manager" ] || git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager
WFLOW="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"
mkdir -p "web/scripts"
wget -q -O "web/scripts/default_workflow.json" "$WFLOW"

# 2. Установка JupyterLab (для быстрой работы с файлами)
pip install jupyterlab "numpy<2" --quiet
nohup jupyter lab --allow-root --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password='' > /workspace/jupyter.log 2>&1 &

# 3. Запуск ComfyUI
python3 main.py --listen 0.0.0.0 --port 8188
