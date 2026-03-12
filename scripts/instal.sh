#!/bin/bash

# Находим путь
CPATH=$(find /workspace -name "ComfyUI" -type d | head -n 1)
if [ -z "$CPATH" ]; then CPATH="/workspace/runpod-slim/ComfyUI"; fi

# 1. СОЗДАЕМ ПАПКИ (сначала папки, потом загрузка!)
mkdir -p "$CPATH/models/diffusion_models"
mkdir -p "$CPATH/models/vae"
mkdir -p "$CPATH/models/text_encoders"
mkdir -p "$CPATH/models/vadim_folder"

echo "=== STARTING DOWNLOAD ==="

# 2. СКАЧИВАЕМ (со стрелочками)
wget --header="Authorization: Bearer $HF_TOKEN" -O "$CPATH/models/vae/wan_2.1_vae.safetensors" --progress=bar:force "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors" 2>&1

wget --header="Authorization: Bearer $HF_TOKEN" -O "$CPATH/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" --progress=bar:force "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors" 2>&1

wget --header="Authorization: Bearer $HF_TOKEN" -O "$CPATH/models/diffusion_models/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf" --progress=bar:force "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf" 2>&1

wget --header="Authorization: Bearer $HF_TOKEN" -O "$CPATH/models/diffusion_models/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf" --progress=bar:force "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf" 2>&1

# 3. Менеджер Смышникова
cd "$CPATH/custom_nodes"
git clone https://github.com/smisnikov/comfyui-preset-download-manager

echo "=== FINISHED ==="
