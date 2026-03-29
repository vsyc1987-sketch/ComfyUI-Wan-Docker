#!/bin/bash
cd /workspace/ComfyUI

# 1. Создаем папку, где нода Easy-Use ищет пресеты
mkdir -p ./custom_nodes/ComfyUI-Easy-Use/presets/workflows

# 2. Качаем твой основной воркфлоу прямо в эту папку
wget -q -O ./custom_nodes/ComfyUI-Easy-Use/presets/workflows/Artius_Wan_2.2.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# 3. Устанавливаем необходимые ноды (Менеджер, Easy-Use для меню и GGUF)
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
git clone https://github.com/yolain/ComfyUI-Easy-Use.git || true
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git || true
cd ..

echo "SETUP DONE: ПРЕСЕТ ЗАГРУЖЕН В МЕНЮ EASY-USE"
