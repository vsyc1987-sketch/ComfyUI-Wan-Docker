FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

# Установка системных зависимостей
RUN apt-get update && apt-get install -y git wget curl libgl1-mesa-glx libglib2.0-0 && rm -rf /var/lib/apt/lists/*

# Копирование структуры папок
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/
RUN chmod +x /workspace/scripts/pre_start.sh

# Клонируем ComfyUI по стандартному пути
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
WORKDIR /workspace/ComfyUI
RUN pip install --no-cache-dir -r requirements.txt

# ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ (Один в один как у него)
ENV WORKFLOW_JSON_URL=""
ENV PROMPT_PATH="/workspace/user_workflows/workflow.json"
ENV COMFY_DEFAULT_WORKFLOW="/workspace/ComfyUI/web/scripts/default_workflow.json"

EXPOSE 8188

# Запуск через CMD, который вызывает престарт перед сервером
CMD ["/bin/bash", "-c", "bash /workspace/scripts/pre_start.sh && python3 main.py --listen 0.0.0.0 --port 8188"]
