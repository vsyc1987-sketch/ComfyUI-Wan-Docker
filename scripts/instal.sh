#!/bin/bash

# Создаем папку в самом начале для проверки
mkdir -p /workspace/VADIM_ALIVE

# Находим путь к ComfyUI
CPATH=$(find /workspace -name "ComfyUI" -type d | head -n 1)

# Создаем папки для моделей и твою личную
mkdir -p "$CPATH/models/diffusion_models"
mkdir -p "$CPATH/models/vae"
mkdir -p "$CPATH/models/text_encoders"
mkdir -p "$CPATH/models/vadim_folder"

echo "=== STARTING DOWNLOAD ==="

# Загрузка VAE
wget --header="Authorization: Bearer $HF_TOKEN" -O "$CPATH/models/vae/wan_2.1_vae.safetensors" --progress=bar:force "https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors" 2>&1

# Загрузка Text Encoder
wget --header="Authorization: Bearer $HF_TOKEN" -O "$CPATH/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" --progress=bar:force "https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors" 2>&1

# Wan 2.1 HIGH
wget --header="Authorization: Bearer $HF_TOKEN" -O "$CPATH/models/diffusion_models/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf" --progress=bar:force "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf" 2>&1

# Wan 2.1 LOW
wget --header="Authorization: Bearer $HF_TOKEN" -O "$CPATH/models/diffusion_models/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf" --progress=bar:force "https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-low-Q4_K_M-v2.gguf" 2>&1

# Менеджер Смышникова
cd "$CPATH/custom_nodes"
git clone https://github.com/smisnikov/comfyui-preset-download-manager

echo "=== ALL DONE ==="
