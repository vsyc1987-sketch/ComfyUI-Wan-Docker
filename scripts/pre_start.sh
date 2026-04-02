#!/bin/bash

# Установка SageAttention, если нужно
if [ "${USE_SAGE_ATTENTION,,}" = "true" ]; then
    pip install sageattention
fi

# Проверка менеджера
if [ ! -d "/workspace/comfyui/custom_nodes/ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git /workspace/comfyui/custom_nodes/ComfyUI-Manager
fi

echo "**** Pre-start complete. Workflow is ready. ****"
