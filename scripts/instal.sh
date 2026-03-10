#!/bin/bash

# 1. Создаем папки, если их нет
mkdir -p /workspace/ComfyUI/models/unet
mkdir -p /workspace/ComfyUI/models/vae
mkdir -p /workspace/ComfyUI/models/clip

# 2. Скачиваем модели (используем твой токен для доступа к Private репо)
echo "Downloading Models..."

# VAE
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/vae/wan_2.1_vae.safetensors "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors"

# CLIP (Encoder)
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/clip/umt5_xxl_fp8_e4m3fn_scaled.safetensors "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

# UNET HIGH
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/unet/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf"

# UNET LOW
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/unet/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf"

# 3. Установка библиотек для индикаторов (Crystools)
pip install psutil nvidia-ml-py3

echo "All done! Launching ComfyUI..."
