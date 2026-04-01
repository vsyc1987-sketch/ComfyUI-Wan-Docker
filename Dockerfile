# Используем актуальный рабочий образ
FROM runpod/stable-diffusion:comfy-ui-6.0.2

# Рабочая директория
WORKDIR /workspace

# Копируем воркфлоу
COPY user_workflows/ /workspace/runpod-slim/ComfyUI/user_workflows/

# Копируем тот самый скрипт Смышникова для автозапуска
COPY scripts/pre_start.sh /workspace/pre_start.sh

# Даем права на запуск
RUN chmod +x /workspace/pre_start.sh

# Порт для ComfyUI
EXPOSE 8188

# Запуск системы
CMD ["python3", "main.py", "--listen", "--port", "8188"]
