#!/bin/bash

# Находим путь к ComfyUI, так как он изменился на runpod-slim
COMFY_PATH=$(find /workspace -name "ComfyUI" -type d | head -n 1)

# 1. Создаем папки
mkdir -p "$COMFY_PATH/models/diffusion_models"
mkdir -p "$COMFY_PATH/models/text_encoders"
mkdir -p "$COMFY_PATH/models/vae"

# 2. Скачивание (те самые стрелочки)
echo "Downloading Models..."

# VAE
curl -L -H "Authorization: Bearer $HF_TOKEN" -o "$COMFY_PATH/models/vae/wan_2.1_vae.safetensors" "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors"

# Text Encoder
curl -L -H "Authorization: Bearer $HF_TOKEN" -o "$COMFY_PATH/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

# UNET High
curl -L -H "Authorization: Bearer $HF_TOKEN" -o "$COMFY_PATH/models/diffusion_models/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf" "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf"

echo "All done! Ready to work."
