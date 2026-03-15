#!/bin/bash
# Создаем иерархию папок
mkdir -p /workspace/ComfyUI/models/vae /workspace/ComfyUI/models/text_encoders /workspace/ComfyUI/models/diffusion_models

# Твой токен HF
HF_TOKEN="hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh"

# Загрузка моделей (в фоне, чтобы ComfyUI открылся сразу)
echo "Starting model downloads in background..."
wget --header="Authorization: Bearer $HF_TOKEN" -O /workspace/ComfyUI/models/vae/wan_2.1_vae.safetensors https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors &
wget --header="Authorization: Bearer $HF_TOKEN" -O /workspace/ComfyUI/models/diffusion_models/wan2.1_high.gguf https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf &

# Подтягиваем твой воркфлоу (Template)
wget -O /workspace/ComfyUI/workflow_artius.json https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14B_flf2v.json

# Запуск
echo "Starting ComfyUI..."
python3 /workspace/ComfyUI/main.py --listen --port 8188
