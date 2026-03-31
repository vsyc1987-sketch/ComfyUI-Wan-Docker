#!/bin/bash

# Это тот самый скрипт, который RunPod НЕ игнорирует
echo "SMYSHNIKOV STYLE ACTIVATED: STAGE 1"

# Запускаем твой основной скрипт установки
if [ -f "/workspace/runpod-slim/provisioning.sh" ]; then
    bash /workspace/runpod-slim/provisioning.sh
else
    curl -sL https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/provisioning.sh | bash
fi

echo "SMYSHNIKOV STYLE ACTIVATED: STAGE 2"
