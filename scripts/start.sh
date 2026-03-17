#!/bin/bash

# Цветовая пометка (в логах RunPod будет выглядеть как яркий текст)
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! СИСТЕМА САМОДИАГНОСТИКИ И ЗАПУСКА КОРРЕКТИРОВКА !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# 1. ПРОВЕРКА ДИСКА (Критично для моделей)
FREE_SPACE=$(df -h /workspace | awk 'NR==2 {print $4}' | sed 's/G//')
echo "!!! СВОБОДНО: ${FREE_SPACE}GB"
if [ "${FREE_SPACE%.*}" -lt 40 ]; then
    echo "!!! ВНИМАНИЕ: МЕСТА МЕНЬШЕ 40GB! МОДЕЛИ МОГУТ НЕ ВЛЕЗТЬ !!!"
fi

# 2. ПРОВЕРКА И СОЗДАНИЕ СТРУКТУРЫ ПАПОК
echo "!!! ПРОВЕРКА ПАПОК..."
BASE_DIR="/workspace/ComfyUI"
mkdir -p "$BASE_DIR/models/unet"
mkdir -p "$BASE_DIR/models/vae"
mkdir -p "$BASE_DIR/custom_nodes"

# 3. ПОИСК ПРАВИЛЬНОГО main.py (Игнорируем мусор из плагинов)
echo "!!! ВЕРИФИКАЦИЯ ЯДРА COMFYUI..."
# Сначала ищем в корне, если нет - ищем в папке ComfyUI, исключая системный хлам
REAL_PATH=$(find /workspace -maxdepth 2 -name "main.py" | grep -v "custom_nodes" | grep -v "lib2to3" | head -n 1)

if [ -z "$REAL_PATH" ]; then
    echo "!!! ОШИБКА: main.py НЕ НАЙДЕН! СОЗДАЕМ ОТЧЕТ..."
    ls -R /workspace > /workspace/folder_structure.txt
    echo "!!! СТРУКТУРА ПАПОК СОХРАНЕНА В folder_structure.txt !!!"
    exit 1
fi
echo "!!! ПУТЬ ПОДТВЕРЖДЕН: $REAL_PATH"

# 4. ЗАГРУЗКА РЕСУРСОВ (Только если их нет)
if [ ! -f "$BASE_DIR/workflow_artius.json" ]; then
    echo "!!! ЗАГРУЗКА ВОРКФЛОУ..."
    wget -q -O "$BASE_DIR/workflow_artius.json" "https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"
fi

# Фоновая загрузка моделей (с проверкой на существование)
if [ ! -f "$BASE_DIR/models/vae/wan_2.1_vae.safetensors" ]; then
    wget -b -q -O "$BASE_DIR/models/vae/wan_2.1_vae.safetensors" "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
fi

# 5. ЗАПУСК С ПЕРЕХВАТОМ ОШИБОК
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! ЗАПУСК СЕРВЕРА... ПОРТ 8188              !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

cd $(dirname "$REAL_PATH")

# Запуск. Если выпадет ошибка, она будет выделена знаками !!!
python3 main.py --listen 0.0.0.0 --port 8188 2>&1 | while read line; do
    if [[ "$line" == *"Error"* || "$line" == *"ImportError"* || "$line" == *"ModuleNotFoundError"* ]]; then
        echo "!!! КРИТИЧЕСКАЯ ОШИБКА: $line !!!"
    else
        echo "$line"
    fi
done
