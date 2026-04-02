#!/bin/bash

# Переходим в корень ComfyUI
cd /workspace/ComfyUI

# ПОДМЕНА ВОРКФЛОУ (Секрет Смышникова)
if [ -f "/workspace/user_workflows/workflow.json" ]; then
    echo "!!! [REPORT] Copying workflow to default..."
    cp /workspace/user_workflows/workflow.json ./web/scripts/default_workflow.json
fi

# Установка менеджера (если нужно)
cd custom_nodes
if [ ! -d "ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
fi
