FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

# Установка системных зависимостей, как в оригинале
RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Копируем структуру файлов
COPY user_workflows/ /workspace/ComfyUI/user_workflows/
COPY scripts/pre_start.sh /workspace/pre_start.sh

# Даем права
RUN chmod +x /workspace/pre_start.sh

EXPOSE 8188

# Запуск через bash, чтобы pre_start.sh точно сработал
CMD ["/bin/bash", "-c", "/workspace/pre_start.sh && python3 main.py --listen --port 8188"]
