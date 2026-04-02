FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace
RUN apt-get update && apt-get install -y git wget curl libgl1-mesa-glx libglib2.0-0 rsync && rm -rf /var/lib/apt/lists/*

# Установка ComfyUI (версия проверена)
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI && \
    cd /workspace/ComfyUI && git checkout v0.3.15 && \
    pip install --no-cache-dir -r requirements.txt

# Установка только необходимых менеджеров и Gradio для интерфейса
RUN pip install gradio
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
    git clone https://github.com/yolain/ComfyUI-Easy-Use.git

# Копируем твои файлы (скрипты и воркфлоу)
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/
RUN chmod +x /workspace/scripts/*.sh

# Порты: 3000 (Лаунчер), 8188 (ComfyUI)
EXPOSE 3000 8188

# Запуск панели управления
CMD ["python3", "/workspace/scripts/dashboard.py"]
