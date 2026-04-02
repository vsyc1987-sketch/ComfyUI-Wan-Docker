#!/bin/bash

echo "!!! [INIT] Starting Smyshnikov-style initialization !!!"

# 1. Если в переменную WORKFLOW_JSON_URL передана ссылка — качаем воркфлоу
if [ ! -z "$WORKFLOW_JSON_URL" ]; then
    echo "!!! [STEP 1] Downloading remote workflow from $WORKFLOW_JSON_URL !!!"
    curl -sL "$WORKFLOW_JSON_URL" -o "$PROMPT_PATH"
fi

# 2. Подмена системного воркфлоу твоим файлом (из папки или скачанным)
if [ -f "$PROMPT_PATH" ]; then
    echo "!!! [STEP 2] Replacing default workflow with $PROMPT_PATH !!!"
    cp "$PROMPT_PATH" "$COMFY_DEFAULT_WORKFLOW"
else
    echo "!!! [SKIP] No custom workflow found at $PROMPT_PATH !!!"
fi

# 3. Установка менеджера (как в его темплейте)
cd /workspace/ComfyUI/custom_nodes
if [ ! -d "ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
fi

echo "!!! [READY] Initialization complete. Starting ComfyUI !!!"
