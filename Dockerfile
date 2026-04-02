# База как у Смышникова
FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

# 1. Установка системных пакетов
RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 2. Клонируем официальный ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# 3. Установка зависимостей Python
RUN pip install --no-cache-dir -r requirements.txt

# 4. Создаем структуру папок ПЕРЕД копированием
RUN mkdir -p /workspace/user_workflows /workspace/scripts /workspace/web/scripts

# 5. Копируем твои файлы из репозитория GitHub
COPY user_workflows/ /workspace/user_workflows/
COPY scripts/pre_start.sh /workspace/scripts/pre_start.sh

# 6. Даем права на исполнение
RUN chmod +x /workspace/scripts/pre_start.sh

EXPOSE 8188

# 7. Запуск: сначала скрипт настройки, потом сам Comfy
CMD ["/bin/bash", "-c", "/workspace/scripts/pre_start.sh && python3 main.py --listen 0.0.0.0 --port 8188"]
