FROM runpod/stable-diffusion:comfy-ui-7.1.0

WORKDIR /workspace

# Копируем пресеты
COPY user_workflows/ /workspace/runpod-slim/ComfyUI/user_workflows/

# Копируем скрипт автозапуска
COPY scripts/pre_start.sh /workspace/pre_start.sh

# Права на запуск
RUN chmod +x /workspace/pre_start.sh

EXPOSE 8188

CMD ["python3", "main.py", "--listen", "--port", "8188"]
