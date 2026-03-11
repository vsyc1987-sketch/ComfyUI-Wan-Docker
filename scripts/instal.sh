#!/bin/bash

# Путь теперь с учетом runpod-slim
BASE_PATH="/workspace/runpod-slim/ComfyUI"

# 1. Создаем правильные папки
mkdir -p $BASE_PATH/models/diffusion_models
mkdir -p $BASE_PATH/models/text_encoders
mkdir -p $BASE_PATH/models/vae

# 2. Скачивание (используем новую переменную пути)
echo "Starting download into $BASE_PATH..."

curl -L -H "Authorization: Bearer $HF_TOKEN" -o $BASE_PATH/models/vae/wan_2.1_vae.safetensors "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o $BASE_PATH/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o $BASE_PATH/models/diffusion_models/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o $BASE_PATH/models/diffusion_models/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf"
