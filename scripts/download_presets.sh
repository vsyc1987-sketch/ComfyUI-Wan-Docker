#!/bin/bash
echo "=== Starting preset download script ==="

# Create necessary directories
mkdir -p /workspace/ComfyUI/user/default/workflows
mkdir -p /workspace/ComfyUI/models/diffusion_models
mkdir -p /workspace/ComfyUI/models/text_encoders
mkdir -p /workspace/ComfyUI/models/vae

# === ТВОЙ ARTIUS WORKFLOW - автозагрузка ===
echo "=== Загружаю Artius_wan2_2_14 как default workflow ==="

cp /presets/flf/Artius_wan2_2_14.json /workspace/ComfyUI/user/default/workflows/default.json
cp /presets/flf/Artius_wan2_2_14.json /workspace/ComfyUI/user/default/workflows/Artius_wan2_2_14.json

echo "✅ Artius_wan2_2_14 workflow успешно установлен как default!"

# Здесь можно позже добавить скачивание моделей, пока только workflow
echo "=== Preset download finished ==="
