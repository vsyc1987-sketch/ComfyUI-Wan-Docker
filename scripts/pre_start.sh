#!/bin/bash

echo "Starting pre-start script..."

# 1. Создаем структуру папок, если её нет
mkdir -p /workspace/ComfyUI/user_workflows
mkdir -p /workspace/ComfyUI/models/checkpoints
mkdir -p /workspace/ComfyUI/models/diffusion_models
mkdir -p /workspace/ComfyUI/models/vae

# 2. Скачиваем твой workflow и ставим его как дефолтный
echo "Downloading workflow..."
wget -O /workspace/ComfyUI/user_workflows/default_workflow.json https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/refs/heads/main/presets/flf/Artius_wan2_2_14.json

# Копируем его в системную папку ComfyUI, чтобы он открылся сразу при загрузке страницы
cp /workspace/ComfyUI/user_workflows/default_workflow.json /workspace/ComfyUI/web/scripts/default_workflow.json

# 3. Установка прав (на всякий случай)
chmod -R 777 /workspace/ComfyUI/user_workflows

echo "Pre-start script finished."
