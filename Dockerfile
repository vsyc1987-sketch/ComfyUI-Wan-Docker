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

# 2. Клонируем ComfyUI (если его еще нет в базовом слое)
RUN git clone https://github.com/comfyanonymous/ComfyUI.git . || true
RUN pip install --no-cache-dir -r requirements.txt

# 3. Копируем ТВОИ файлы из GitHub в образ
# Копируем папку со скриптами и папку с воркфлоу
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/

# 4. Даем права на запуск (обязательно!)
RUN chmod +x /workspace/scripts/pre_start.sh

EXPOSE 8188

# 5. ЗАПУСК: строго через bash и по полному пути
# Мы используем bash -c, чтобы сначала выполнить скрипт, а потом запустить ComfyUI
CMD ["/bin/bash", "-c", "bash /workspace/scripts/pre_start.sh && python3 main.py --listen 0.0.0.0 --port 8188"]
