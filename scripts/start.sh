#!/bin/bash
cd /workspace/ComfyUI

# Установка только необходимых нод для твоего воркфлоу
cd custom_nodes
git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager
git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader
git clone --depth 1 https://github.com/city96/ComfyUI-GGUF
git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite

# Загрузка твоего воркфлоу (Artius_wan2_2_14)
cd /workspace/ComfyUI
mkdir -p web/scripts
wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# Запуск с отключенной защитой для работы загрузчика Смышникова
python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security
