#!/bin/bash

# 1. Определяем путь к ComfyUI (подходит для любого образа)
COMFY_DIR="/workspace/ComfyUI"
cd $COMFY_DIR

# 2. Устанавливаем базу, чтобы ноды не были красными
cd custom_nodes
[ -d "ComfyUI-Manager" ] || git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager
[ -d "ComfyUI-Model-Downloader" ] || git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader
[ -d "ComfyUI-GGUF" ] || git clone --depth 1 https://github.com/city96/ComfyUI-GGUF
[ -d "ComfyUI-VideoHelperSuite" ] || git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite

# 3. Делаем твой воркфлоу стандартным (он появится сразу при входе)
cd $COMFY_DIR
mkdir -p web/scripts
wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# 4. ЗАПУСК БЕЗ ОГРАНИЧЕНИЙ
# Флаг --disable-security убирает красную ошибку "This action is not allowed"
python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security --user-directory /workspace/ComfyUI
