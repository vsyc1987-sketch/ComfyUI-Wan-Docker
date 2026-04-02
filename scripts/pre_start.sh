#!/bin/bash

# 1. Подмена воркфлоу (Самое важное из FAQ)
if [ -f "/workspace/user_workflows/workflow.json" ]; then
    echo "!!! [REPORT] Applying your custom workflow as default..."
    cp /workspace/user_workflows/workflow.json /workspace/web/scripts/default_workflow.json
fi

# 2. Установка менеджера
cd /workspace/custom_nodes
if [ ! -d "ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
fi
