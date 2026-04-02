#!/bin/bash

echo "!!! [INIT] STARTING SMYSHNIKOV-STYLE SETUP !!!"

# 1. Создаем папку если её нет
mkdir -p /workspace/user_workflows

# 2. Скачиваем воркфлоу по ссылке из переменной
if [ ! -z "$WORKFLOW_JSON_URL" ]; then
    echo "!!! [STEP 1] Downloading workflow from GitHub !!!"
    curl -sL "$WORKFLOW_JSON_URL" -o "$PROMPT_PATH"
fi

# 3. Подменяем стандартный воркфлоу твоим
if [ -f "$PROMPT_PATH" ]; then
    echo "!!! [STEP 2] Applying your workflow to ComfyUI !!!"
    cp "$PROMPT_PATH" "$COMFY_DEFAULT_WORKFLOW"
else
    echo "!!! [ERROR] Workflow file not found at $PROMPT_PATH !!!"
fi

# 4. Установка ComfyUI-Manager (стандарт шаблона)
cd /workspace/ComfyUI/custom_nodes
if [ ! -d "ComfyUI-Manager" ]; then
    echo "!!! [STEP 3] Installing ComfyUI-Manager !!!"
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
fi

echo "!!! [READY] PRE-START FINISHED !!!"
