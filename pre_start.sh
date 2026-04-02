# 1. Базовая среда (PyTorch + CUDA)
FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

# 2. Установка системных утилит
RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 3. Клонируем ComfyUI в корень /workspace
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# 4. Установка зависимостей Python
RUN pip install --no-cache-dir -r requirements.txt

# 5. Копируем ТВОИ файлы из корня GitHub в образ
# Копируем pre_start.sh (теперь он в корне репозитория)
COPY pre_start.sh /workspace/pre_start.sh
# Копируем папку с воркфлоу
COPY user_workflows/ /workspace/user_workflows/

# 6. Даем права на выполнение скрипта
RUN chmod +x /workspace/pre_start.sh

# Открываем порт для интерфейса
EXPOSE 8188

# 7. ЗАПУСК (Логика Смышникова):
# Сначала принудительно запускаем bash со скриптом, и только потом основной процесс
CMD ["/bin/bash", "-c", "bash /workspace/pre_start.sh && python3 main.py --listen 0.0.0.0 --port 8188"]
