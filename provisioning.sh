#!/bin/bash
# Принудительно идем в папку, которую мы видим в твоем логе
cd /workspace/runpod-slim/ComfyUI

# Создаем папку и качаем воркфлоу
mkdir -p user/default
wget -q -O user/default/my_workflow.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# Устанавливаем недостающие ноды
cd custom_nodes
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git || true
cd ..
