# База как у Смышникова
FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

# Установка системных пакетов
RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Копируем твои файлы в структуру
COPY user_workflows/ /workspace/ComfyUI/user_workflows/
COPY scripts/pre_start.sh /workspace/pre_start.sh

# Права на запуск
RUN chmod +x /workspace/pre_start.sh

EXPOSE 8188

# Запуск в точности по его логике
CMD ["/bin/bash", "-c", "/workspace/pre_start.sh && python3 main.py --listen --port 8188"]
