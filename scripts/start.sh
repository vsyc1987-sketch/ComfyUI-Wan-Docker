#!/bin/bash

# 1. Переходим в директорию ComfyUI
cd /workspace/ComfyUI

# 2. Устанавливаем базу (занимает секунд 40)
cd custom_nodes
[ -d "ComfyUI-Manager" ] || git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager
[ -d "ComfyUI-Model-Downloader" ] || git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader
[ -d "ComfyUI-GGUF" ] || git clone --depth 1 https://github.com/city96/ComfyUI-GGUF
[ -d "ComfyUI-VideoHelperSuite" ] || git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite

# 3. Ставим твой воркфлоу как стандартный
cd /workspace/ComfyUI
mkdir -p web/scripts
wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# 4. ФИНАЛЬНЫЙ ЗАПУСК: разрешаем всё
# Флаг --disable-security уберет ошибку "This action is not allowed"
python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security
