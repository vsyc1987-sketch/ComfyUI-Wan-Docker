#!/bin/bash

export PYTHONUNBUFFERED=1

# Пути для копирования воркфлоу (по модели Смышникова)
DST_WORKFLOWS_DIR="/workspace/ComfyUI/user/default/workflows"
SRC_MY_WORKFLOWS="/workspace/user_workflows"

echo "**** Copying Your Wan workflows to ComfyUI ****"

# Создаем системную директорию воркфлоу
mkdir -p "$DST_WORKFLOWS_DIR"

# Копируем твои JSON файлы используя rsync (как в оригинале)
if [ -d "$SRC_MY_WORKFLOWS" ]; then
    rsync -au "$SRC_MY_WORKFLOWS/" "$DST_WORKFLOWS_DIR/"
    echo "**** Workflows successfully imported to $DST_WORKFLOWS_DIR ****"
else
    echo "Skip: $SRC_MY_WORKFLOWS not found in image."
fi

# Установка SageAttention (если в темплейте стоит true)
if [ "${USE_SAGE_ATTENTION,,}" = "true" ]; then
    if ! pip show sageattention > /dev/null 2>&1; then
        echo "**** Installing SageAttention2, please wait... ****"
        pip install sageattention
    fi
fi

# Установка ComfyUI-Manager (базовый стандарт)
cd /workspace/ComfyUI/custom_nodes
if [ ! -d "ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
fi
