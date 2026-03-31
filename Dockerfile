# Используем базовый образ ComfyUI
FROM runpod/stable-diffusion:comfy-ui-6.0.2

# Создаем рабочую директорию
WORKDIR /workspace

# Копируем твой пресет воркфлоу, чтобы он всегда был в меню
COPY user_workflows/ /workspace/runpod-slim/ComfyUI/user_workflows/

# Копируем pre_start.sh из твоей новой папки scripts в корень /workspace
# Именно здесь RunPod ищет этот файл для автозапуска
COPY scripts/pre_start.sh /workspace/pre_start.sh

# Даем права на выполнение обоим скриптам
RUN chmod +x /workspace/pre_start.sh

# Указываем стандартный порт
EXPOSE 8188

# Запуск основной команды (RunPod сам подхватит pre_start.sh перед этим)
CMD ["python3", "main.py", "--listen", "--port", "8188"]
