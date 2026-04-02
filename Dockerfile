FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

# 1. Системные пакеты
RUN apt-get update && apt-get install -y \
    git wget libgl1-mesa-glx libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 2. Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .
RUN pip install --no-cache-dir -r requirements.txt

# 3. Копируем папки из GitHub (ВАЖНО: scripts должна быть в репозитории)
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/

# 4. Даем права (теперь путь 100% верный)
RUN chmod +x /workspace/scripts/pre_start.sh

EXPOSE 8188

# 5. ЗАПУСК: Я добавил "|| true", чтобы даже если скрипт споткнется, ComfyUI все равно запустился
CMD ["/bin/bash", "-c", "bash /workspace/scripts/pre_start.sh || true; python3 main.py --listen 0.0.0.0 --port 8188"]
