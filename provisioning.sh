#!/bin/bash
# 1. Определяем правильный путь ComfyUI (в официальном образе это всегда /workspace/ComfyUI)
INSTALL_DIR="/workspace/runpod-slim/ComfyUI"
cd $INSTALL_DIR

# 2. Создаем структуру папок для твоего воркфлоу
mkdir -p user/default

# 3. Скачиваем твой воркфлоу и подменяем базу данных (чтобы он открылся сразу)
wget -q -O user/default/my_workflow.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"
cp user/default/my_workflow.json user/default/comfy_db.sqlite

# 4. Установка ТОЛЬКО необходимых нод (без лишнего мусора)
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git || true
cd ..

echo "ПОДГОТОВКА ЗАВЕРШЕНА. ЗАПУСКАЕМ СЕРВЕР..."
