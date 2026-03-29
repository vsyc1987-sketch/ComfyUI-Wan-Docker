#!/bin/bash
cd /workspace/ComfyUI

# 1. Создаем структуру папок для пресетов Easy-Use
mkdir -p presets/workflows

# 2. Скачиваем твой основной пресет в папку выбора
wget -q -O presets/workflows/Artius_Wan_2.2.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# 3. Устанавливаем ноды, которые создают это меню
cd custom_nodes
git clone https://github.com/yolain/ComfyUI-Easy-Use.git || true
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git || true
cd ..

echo "ИНФРАСТРУКТУРА ДЛЯ ПРЕСЕТОВ ГОТОВА"
