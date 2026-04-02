#!/bin/bash

export PYTHONUNBUFFERED=1

# Путь, куда ComfyUI сохраняет пользовательские воркфлоу (как у Смышникова)
DST_WORKFLOWS_DIR="/workspace/ComfyUI/user/default/workflows"
SRC_MY_WORKFLOWS="/workspace/user_workflows"

echo "**** Copying Wan workflows (if any) ****"

# Создаем папку, если её нет
mkdir -p "$DST_WORKFLOWS_DIR"

# Копируем твой воркфлоу из папки образа в папку пресетов ComfyUI
if [ -d "$SRC_MY_WORKFLOWS" ]; then
    rsync -au "$SRC_MY_WORKFLOWS/" "$DST_WORKFLOWS_DIR/"
    echo "**** Workflows copied to $DST_WORKFLOWS_DIR ****"
    
    # Специфический шаг: делаем твой воркфлоу стандартным
    cp "$SRC_MY_WORKFLOWS/workflow.json" "/workspace/ComfyUI/web/scripts/default_workflow.json"
else
    echo "Skip: $SRC_MY_WORKFLOWS does not exist."
fi

# Установка SageAttention (если переменная true)
if [ "${USE_SAGE_ATTENTION,,}" = "true" ]; then
    if ! pip show sageattention > /dev/null 2>&1; then
        echo "**** Installing SageAttention2... ****"
        pip install sageattention
    fi
fi
