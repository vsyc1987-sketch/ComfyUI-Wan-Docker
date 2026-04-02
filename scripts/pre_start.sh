#!/bin/bash

echo "!!! [START] Running pre-start script by Smyshnikof logic !!!"

# 1. Пути (согласно структуре в Dockerfile)
MY_WORKFLOW="/workspace/user_workflows/workflow.json"
COMFY_DEFAULT_PATH="/workspace/ComfyUI/web/scripts/default_workflow.json"

# 2. Проверка и подмена воркфлоу (Магия автозагрузки)
if [ -f "$MY_WORKFLOW" ]; then
    echo "!!! [REPORT] Copying your workflow to default position..."
    cp "$MY_WORKFLOW" "$COMFY_DEFAULT_PATH"
    echo "!!! [SUCCESS] Workflow replaced!"
else
    echo "!!! [ERROR] Workflow file not found at $MY_WORKFLOW"
fi

# 3. Установка кастомных нод (если нужно добавить еще — просто допиши git clone ниже)
cd /workspace/ComfyUI/custom_nodes

if [ ! -d "ComfyUI-Manager" ]; then
    echo "!!! [INSTALL] Downloading ComfyUI-Manager..."
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
fi

echo "!!! [FINISH] Pre-start configuration complete. Starting ComfyUI..."
