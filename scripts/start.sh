#!/bin/bash
# 1. Создаем правильную иерархию папок
mkdir -p /workspace/ComfyUI/models/vae /workspace/ComfyUI/models/text_encoders /workspace/ComfyUI/models/unet

# 2. Скачивание моделей (используем секрет HF_TOKEN для авторизации)
echo "Starting model downloads..."
wget --header="Authorization: Bearer $HF_TOKEN" -O /workspace/ComfyUI/models/vae/wan_2.1_vae.safetensors https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors
wget --header="Authorization: Bearer $HF_TOKEN" -O /workspace/ComfyUI/models/unet/wan2.1_high.gguf https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf

# 3. Подтягиваем твой воркфлоу
wget -O /workspace/ComfyUI/workflow_artius.json https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14B_flf2v.json

# 4. Запуск ComfyUI
echo "Launching ComfyUI..."
# Переходим в папку, где лежит main.py
cd /workspace/ComfyUI || cd /workspace
python3 main.py --listen 0.0.0.0 --port 8188
