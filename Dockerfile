FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

RUN apt-get update && apt-get install -y git wget curl libgl1-mesa-glx libglib2.0-0 && rm -rf /var/lib/apt/lists/*

# Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
WORKDIR /workspace/ComfyUI
RUN pip install --no-cache-dir -r requirements.txt

# ПЕРЕМЕННЫЕ (Полностью заполнены)
ENV WORKFLOW_JSON_URL="https://raw.githubusercontent.com/Artois-wan/Artois-wan-2.2/main/user_workflows/workflow.json"
ENV PROMPT_PATH="/workspace/user_workflows/workflow.json"
ENV COMFY_DEFAULT_WORKFLOW="/workspace/ComfyUI/web/scripts/default_workflow.json"
ENV USE_SAGE_ATTENTION="true"

# Копируем твои скрипты и воркфлоу из репозитория в образ
WORKDIR /workspace
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/
RUN chmod +x /workspace/scripts/pre_start.sh

# Вшиваем автозапуск скрипта прямо в код ComfyUI (чтобы RunPod не проигнорировал)
RUN sed -i '1i import os\nos.system("bash /workspace/scripts/pre_start.sh")' /workspace/ComfyUI/main.py

EXPOSE 8188

# Запуск сервера
CMD ["/bin/bash", "-c", "cd /workspace/ComfyUI && python3 main.py --listen 0.0.0.0 --port 8188"]
