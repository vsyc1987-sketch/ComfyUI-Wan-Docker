FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

# Установка зависимостей
RUN apt-get update && apt-get install -y git wget curl libgl1-mesa-glx libglib2.0-0 rsync && rm -rf /var/lib/apt/lists/*

# Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
WORKDIR /workspace/ComfyUI
RUN pip install --no-cache-dir -r requirements.txt

# --- СНАЧАЛА КОПИРУЕМ ФАЙЛЫ ИЗ ТВОЕГО REPO ---
WORKDIR /workspace
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/
RUN chmod +x /workspace/scripts/pre_start.sh

# --- ТЕПЕРЬ ДЕЛАЕМ ПОДМЕНУ (Теперь файл точно на месте) ---
RUN mkdir -p /workspace/ComfyUI/web/scripts/ && \
    cp /workspace/user_workflows/workflow.json /workspace/ComfyUI/web/scripts/default_workflow.json

# Переменная как у Смышникова
ENV USE_SAGE_ATTENTION="true"

# Вшивка запуска
RUN sed -i '1i import os\nos.system("bash /workspace/scripts/pre_start.sh")' /workspace/ComfyUI/main.py

EXPOSE 8188

CMD ["python3", "/workspace/ComfyUI/main.py", "--listen", "0.0.0.0", "--port", "8188"]
