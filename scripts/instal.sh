#!/bin/bash

# 1. Создаем правильные папки
mkdir -p /workspace/ComfyUI/models/diffusion_models
mkdir -p /workspace/ComfyUI/models/text_encoders
mkdir -p /workspace/ComfyUI/models/vae

# 2. Скачивание (строго один знак $ перед HF_TOKEN)
echo "Starting download..."

# VAE
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/vae/wan_2.1_vae.safetensors "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors"

# Text Encoder
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

# UNET (Diffusion Models)
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/diffusion_models/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/diffusion_models/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf"

echo "All done! Ready to work."
