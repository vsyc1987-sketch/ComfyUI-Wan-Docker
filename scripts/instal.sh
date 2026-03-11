#!/bin/bash

# Автоматически находим, где лежит ComfyUI
CPATH=$(find /workspace -name "ComfyUI" -type d | head -n 1)

# Создаем папки там, где они должны быть
mkdir -p "$CPATH/models/diffusion_models"
mkdir -p "$CPATH/models/text_encoders"
mkdir -p "$CPATH/models/vae"

echo "Starting download into $CPATH..."

# Качаем модели (те самые стрелочки появятся тут)
curl -L -H "Authorization: Bearer $HF_TOKEN" -o "$CPATH/models/vae/wan_2.1_vae.safetensors" "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o "$CPATH/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o "$CPATH/models/diffusion_models/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf" "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf"

echo "Done!"
