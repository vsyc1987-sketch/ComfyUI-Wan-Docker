#!/bin/bash

# 1. Переходим в папку ComfyUI (в этом образе она в /workspace/ComfyUI)
cd /workspace/ComfyUI

# 2. Устанавливаем базу (занимает 30 секунд)
cd custom_nodes
# Менеджер
[ -d "ComfyUI-Manager" ] || git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager
# Нода Смышникова (обязательно!)
[ -d "ComfyUI-Model-Downloader" ] || git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader
# Поддержка GGUF и Видео (чтобы воркфлоу не был красным)
[ -d "ComfyUI-GGUF" ] || git clone --depth 1 https://github.com/city96/ComfyUI-GGUF
[ -d "ComfyUI-VideoHelperSuite" ] || git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite

# 3. Твой воркфлоу (делаем его стандартным)
cd /workspace/ComfyUI
mkdir -p web/scripts
wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# 4. Запуск с отключенной защитой
# Флаг --disable-security позволит ноде Смышникова качать модели
python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security --user-directory /workspace/ComfyUI
