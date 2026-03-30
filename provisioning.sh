#!/bin/bash
cd /workspace/ComfyUI

# 1. Устанавливаем базу (Менеджер и основные ноды)
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
git clone https://github.com/yolain/ComfyUI-Easy-Use.git || true
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git || true
cd ..

# 2. Настройка связи с твоим GitHub (как у Смышникова)
# Прописываем твой файл custom-presets.json в конфиг Менеджера
mkdir -p /workspace/ComfyUI/custom_nodes/ComfyUI-Manager/
echo '{"custom_workflows": ["https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/custom-presets.json"]}' > /workspace/ComfyUI/custom_nodes/ComfyUI-Manager/config.json

echo "ГОТОВО: Твой личный список пресетов подключен!"
