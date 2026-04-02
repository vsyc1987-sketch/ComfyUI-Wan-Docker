FROM ghcr.io/ai-dock/comfyui:latest-cuda-12.1.1-runtime-22.04

# Устанавливаем rsync для работы скрипта
RUN apt-get update && apt-get install -y rsync && apt-get clean

# Копируем твои файлы в стандартные для этого образа папки
COPY scripts/pre_start.sh /opt/ai-dock/bin/pre-start.sh
COPY user_workflows/ /workspace/comfyui/user/default/workflows/

# Делаем скрипт исполняемым
RUN chmod +x /opt/ai-dock/bin/pre-start.sh

# СРАЗУ ПОДМЕНЯЕМ ДЕФОЛТНЫЙ ВОРКФЛОУ (Тот самый метод)
RUN cp /workspace/comfyui/user/default/workflows/workflow.json /workspace/comfyui/web/scripts/default_workflow.json

# Переменная как у Смышникова
ENV USE_SAGE_ATTENTION="true"

# Порт и запуск уже настроены в базовом образе ai-dock
