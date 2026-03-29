#!/bin/bash
# 1. Переходим в рабочую директорию вашего образа
cd /workspace/runpod-slim/ComfyUI

# 2. Скачиваем ваш workflow в папку по умолчанию
mkdir -p user/default
wget -q -O user/default/my_workflow.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# 3. Устанавливаем недостающие ноды (стандарт через git clone)
cd custom_nodes
git clone https://github.com/city96/ComfyUI-GGUF || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite || true
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale || true
cd ..
