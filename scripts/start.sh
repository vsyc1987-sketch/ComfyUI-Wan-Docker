#!/bin/bash

# Флаг-предохранитель, чтобы не качать всё по кругу
if [ -f "/workspace/ready.txt" ]; then
    echo "!!! СИСТЕМА УЖЕ ГОТОВА. БЫСТРЫЙ ЗАПУСК... !!!"
    cd /workspace
    python3 main.py --listen 0.0.0.0 --port 8188
    exit 0
fi

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! СИСТЕМА САМОДИАГНОСТИКИ И ЗАПУСКА ARTOIS !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# 1. Сразу лечим библиотеки (без лишних проверок)
pip install --no-cache-dir torchaudio==2.1.0+cu121 --index-url https://download.pytorch.org/whl/cu121 --quiet

# 2. Установка воркфлоу как дефолтного
WFLOW_URL="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"
mkdir -p /workspace/web/scripts
wget -q -O /workspace/web/scripts/default_workflow.json "$WFLOW_URL"
wget -q -O /workspace/artius_wan.json "$WFLOW_URL"

# 3. Загрузка моделей (wget -c позволит докачать, если оборвется)
mkdir -p /workspace/models/unet /workspace/models/vae
echo ">>> ЗАГРУЗКА МОДЕЛЕЙ (ЖДЕМ)..."
wget -q -c -O /workspace/models/vae/wan_2.1_vae.safetensors "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
wget -q -c -O /workspace/models/unet/wan2.1_t2v_1.3b_bf16.safetensors "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/unet/wan2.1_t2v_1.3b_bf16.safetensors"

# Создаем файл-метку, что всё готово
touch /workspace/ready.txt

echo "!!! ВСЕ ПРОВЕРКИ ПРОЙДЕНЫ. ЗАПУСК... !!!"
cd /workspace
python3 main.py --listen 0.0.0.0 --port 8188
