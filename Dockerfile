# Используем тег latest - он никогда не выдаст "not found"
FROM runpod/stable-diffusion:comfy-ui-latest

WORKDIR /workspace

# Копируем пресеты
COPY user_workflows/ /workspace/runpod-slim/ComfyUI/user_workflows/

# Копируем скрипт автозапуска Смышникова
COPY scripts/pre_start.sh /workspace/pre_start.sh

# Даем права на запуск
RUN chmod +x /workspace/pre_start.sh

EXPOSE 8188

# Команда запуска
CMD ["python3", "main.py", "--listen", "--port", "8188"]
