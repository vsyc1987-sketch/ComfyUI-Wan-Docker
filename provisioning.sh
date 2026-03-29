#!/bin/bash
cd /workspace/ComfyUI

# 1. Создаем структуру папок для пресетов (как у тебя на GitHub)
mkdir -p custom_nodes/ComfyUI-Manager/custom-workflows/flf

# 2. Скачиваем твой воркфлоу в эту папку
wget -q -O custom_nodes/ComfyUI-Manager/custom-workflows/flf/Artius_wan2_2_14.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/flf/Artius_wan2_2_14.json"

# 3. Устанавливаем ноды, которые создают это меню (из его логов)
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
git clone https://github.com/yolain/ComfyUI-Easy-Use.git || true
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git || true
git clone https://github.com/kijai/ComfyUI-KJNodes.git || true
git clone https://github.com/ChrisGuzman/CRT-Nodes.git || true
cd ..

echo "SETUP COMPLETE: ПРЕСЕТ flf ГОТОВ"
