#!/bin/bash

# 1. Путь к ComfyUI (проверяем оба варианта)
if [ -d "/workspace/runpod-slim/ComfyUI" ]; then
    COMFY_PATH="/workspace/runpod-slim/ComfyUI"
else
    COMFY_PATH="/workspace/ComfyUI"
fi

cd "$COMFY_PATH/custom_nodes"

# 2. Установка всех необходимых нод для твоего воркфлоу
nodes=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/city96/ComfyUI-GGUF"
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/ssitu/ComfyUI_Ultimate_SD_Upscale"
    "https://github.com/Kijai/ComfyUI-WanVideoHelper"
)

for repo in "${nodes[@]}"; do
    dir_name=$(basename "$repo")
    if [ ! -d "$dir_name" ]; then
        git clone "$repo"
        [ -f "$dir_name/requirements.txt" ] && pip install -r "$dir_name/requirements.txt"
    fi
done

# 3. Настройка меню пресетов
cd "$COMFY_PATH"
mkdir -p custom_nodes/ComfyUI-Manager/
echo '{"custom_workflows": ["https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/custom-presets.json"]}' > custom_nodes/ComfyUI-Manager/config.json

echo "SETUP COMPLETE"
