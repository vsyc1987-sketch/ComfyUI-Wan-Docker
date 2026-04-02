#!/bin/bash

# Функция для вывода как у Смышникова (заметно в логах)
msg() {
    echo "----------------------------------------------------------------"
    echo ">>> ПРОВЕРКА: $1"
    echo "----------------------------------------------------------------"
}

msg "ЗАПУСК ПРЕДСТАРТОВОЙ ПОДГОТОВКИ"

# Создаем структуру папок (стандарт)
mkdir -p /workspace/ComfyUI/user_workflows
mkdir -p /workspace/ComfyUI/web/scripts/

# Скачиваем воркфлоу (тихо, без лишнего мусора в логах)
msg "ЗАГРУЗКА ВОРКФЛОУ..."
wget -q -O /workspace/ComfyUI/user_workflows/workflow.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/refs/heads/main/user_workflows/workflow.json"

# Проверка и установка дефолта
if [ -f /workspace/ComfyUI/user_workflows/workflow.json ]; then
    cp /workspace/ComfyUI/user_workflows/workflow.json /workspace/ComfyUI/web/scripts/default_workflow.json
    msg "ВОРКФЛОУ УСТАНОВЛЕН! [OK]"
else
    msg "ОШИБКА: ФАЙЛ НЕ НАЙДЕН! [ERROR]"
fi

msg "ПОДГОТОВКА ЗАВЕРШЕНА. ПЕРЕДАЮ УПРАВЛЕНИЕ COMFYUI."
