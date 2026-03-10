#!/bin/bash

# 1. Создаем папки
mkdir -p /workspace/ComfyUI/models/unet
mkdir -p /workspace/ComfyUI/models/vae
mkdir -p /workspace/ComfyUI/models/clip

# 2. Скачиваем модели (Здесь ВАЖНО: $ перед HF_TOKEN)
echo "Downloading Models..."

curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/vae/wan_2.1_vae.safetensors "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/clip/umt5_xxl_fp8_e4m3fn_scaled.safetensors "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/unet/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf"

curl -L -H "Authorization: Bearer $HF_TOKEN" -o /workspace/ComfyUI/models/unet/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf"

# 3. Библиотеки
pip install psutil nvidia-ml-py3

# 4. Автозагрузка воркфлоу (путь совпадает с твоим GitHub)
mkdir -p /workspace/ComfyUI/user/default_workflows
cp /workspace/vsyс-sketch/presets/wan/MyPreset/*.json /workspace/ComfyUI/user/default_workflows/
cp /workspace/vsyс-sketch/presets/wan/MyPreset/Artius_wan2_2_14B_flf2v.json /workspace/ComfyUI/web/scripts/defaultGraph.json

echo "All done! Launching ComfyUI..."
