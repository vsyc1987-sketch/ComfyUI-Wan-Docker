#!/bin/bash
# В официальном образе путь всегда такой:
cd /workspace/ComfyUI

# Скачиваем твой воркфлоу
mkdir -p user/default
wget -q -O user/default/my_workflow.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# Устанавливаем ноды (Manager, GGUF, VHS)
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git || true
cd ..

echo "SETUP COMPLETE"
