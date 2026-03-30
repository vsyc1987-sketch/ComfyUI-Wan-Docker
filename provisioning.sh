#!/bin/bash

# 1. Находим путь к ComfyUI
if [ -d "/workspace/runpod-slim/ComfyUI" ]; then
    COMFY_PATH="/workspace/runpod-slim/ComfyUI"
elif [ -d "/workspace/ComfyUI" ]; then
    COMFY_PATH="/workspace/ComfyUI"
else
    echo "ComfyUI не найден!" && exit 1
fi

cd "$COMFY_PATH"

# 2. Устанавливаем Менеджер и ноды для Wan 2.2
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
git clone https://github.com/yolain/ComfyUI-Easy-Use.git || true
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git || true
git clone https://github.com/ssitu/ComfyUI_Ultimate_SD_Upscale --recursive || true
cd ..

# 3. Привязываем твой файл пресетов к Менеджеру
mkdir -p custom_nodes/ComfyUI-Manager/
echo '{"custom_workflows": ["https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/custom-presets.json"]}' > custom_nodes/ComfyUI-Manager/config.json

echo "БАЗОВЫЙ SETUP ГОТОВ: Заходи в Manager -> Custom Workflows"
