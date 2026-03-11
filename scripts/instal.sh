#!/bin/bash

# 1. Создаем папки по схеме со скриншота
mkdir -p /workspace/ComfyUI/models/diffusion_models
mkdir -p /workspace/ComfyUI/models/text_encoders
mkdir -p /workspace/ComfyUI/models/vae

# 2. Скачиваем модели в ПРАВИЛЬНЫЕ папки
echo "Downloading Models to correct paths..."

# VAE
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/vae/wan_2.1_vae.safetensors "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors"

# Text Encoder (в папку text_encoders)
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

# UNET (в папку diffusion_models)
curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/diffusion_models/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/diffusion_models/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf"

# Остальное (библиотеки и воркфлоу) оставляем как было
pip install psutil nvidia-ml-py3
mkdir -p /workspace/ComfyUI/user/default_workflows
cp /workspace/vsyс-sketch/presets/wan/MyPreset/*.json /workspace/ComfyUI/user/default_workflows/
cp /workspace/vsyс-sketch/presets/wan/MyPreset/Artius_wan2_2_14B_flf2v.json /workspace/ComfyUI/web/scripts/defaultGraph.json

echo "All done! Ready to work."
