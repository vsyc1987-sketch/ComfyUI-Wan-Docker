#!/bin/bash

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! ШАГ 1: ПОЛНАЯ ПРОВЕРКА ВСЕХ ПУТЕЙ        !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# 1. Проверяем место на диске (чтобы не было 0GB)
df -h /workspace

# 2. Создаем структуру папок
mkdir -p /workspace/ComfyUI/models/unet
mkdir -p /workspace/ComfyUI/models/vae

# 3. ИЩЕМ НАСТОЯЩИЙ main.py (только внутри /workspace, чтобы не найти системный)
echo "!!! Ищем основной файл в /workspace..."
REAL_MAIN=$(find /workspace -maxdepth 4 -name "main.py" | grep -v "lib2to3" | head -n 1)

if [ -z "$REAL_MAIN" ]; then
    echo "!!! ОШИБКА: main.py НЕ НАЙДЕН В /workspace !!!"
    echo "!!! ТЕКУЩЕЕ СОДЕРЖИМОЕ /workspace:"
    ls -F /workspace
    exit 1
fi

echo "!!! НАЙДЕН ВЕРНЫЙ ПУТЬ: $REAL_MAIN"
COMFY_DIR=$(dirname "$REAL_MAIN")

# 4. Загрузка воркфлоу
echo "!!! ЗАГРУЗКА ВОРКФЛОУ В $COMFY_DIR ..."
wget -q -O "$COMFY_DIR/workflow_artius.json" "https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# 5. Загрузка моделей в фоне
echo "!!! ЗАПУСК ЗАГРУЗКИ МОДЕЛЕЙ (ФОН) !!!"
wget -b -q -O "$COMFY_DIR/models/vae/wan_2.1_vae.safetensors" "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
wget -b -q -O "$COMFY_DIR/models/unet/wan2.1_t2v_1.3b_bf16.safetensors" "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/unet/wan2.1_t2v_1.3b_bf16.safetensors"

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! ШАГ 2: ФИНАЛЬНЫЙ ЗАПУСК COMFYUI          !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

cd "$COMFY_DIR"
echo "!!! ТЕКУЩАЯ ДИРЕКТОРИЯ: $(pwd)"
echo "!!! ЗАПУСКАЕМ python3 main.py..."

# Запуск с выводом всех логов
python3 main.py --listen 0.0.0.0 --port 8188 2>&1
