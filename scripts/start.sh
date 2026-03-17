#!/bin/bash

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! ШАГ 1: ПРОВЕРКА РЕСУРСОВ И ПУТЕЙ !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# Проверка места на диске
DISK_SPACE=$(df -h | grep '/workspace' || echo "Не удалось определить место")
echo "!!! СВОБОДНОЕ МЕСТО: $DISK_SPACE"

# Вывод структуры папок для тебя
echo "!!! СТРУКТУРА /workspace:"
ls -F /workspace

# Поиск файла запуска
echo "!!! ПОИСК main.py..."
FINAL_PATH=$(find / -name "main.py" 2>/dev/null | head -n 1)

if [ -z "$FINAL_PATH" ]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "!!! ОШИБКА: ФАЙЛ main.py НЕ НАЙДЕН ВООБЩЕ !!!"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    exit 1
fi

echo "!!! ФАЙЛ НАЙДЕН: $FINAL_PATH"

# 1. Создаем папки
mkdir -p /workspace/ComfyUI/models/unet
mkdir -p /workspace/ComfyUI/models/vae

# 2. Загружаем воркфлоу (быстро)
echo "!!! ЗАГРУЗКА ВОРКФЛОУ..."
wget -q -O /workspace/ComfyUI/workflow_artius.json "https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# 3. Загружаем модели в фоне
echo "!!! ЗАПУСК ЗАГРУЗКИ МОДЕЛЕЙ (ФОН)..."
wget -b -q -O /workspace/ComfyUI/models/vae/wan_2.1_vae.safetensors "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
wget -b -q -O /workspace/ComfyUI/models/unet/wan2.1_t2v_1.3b_bf16.safetensors "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/unet/wan2.1_t2v_1.3b_bf16.safetensors"

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! ШАГ 2: ЗАПУСК COMFYUI            !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

cd $(dirname "$FINAL_PATH")
# Запуск с перехватом всех ошибок
python3 main.py --listen 0.0.0.0 --port 8188 2>&1 | while read line; do
    if [[ "$line" == *"Error"* || "$line" == *"exception"* || "$line" == *"Failed"* ]]; then
        echo "!!! КРИТИЧЕСКАЯ ОШИБКА: $line !!!"
    else
        echo "$line"
    fi
done
