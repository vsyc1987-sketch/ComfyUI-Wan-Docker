FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

RUN apt-get update && apt-get install -y git wget curl libgl1-mesa-glx libglib2.0-0 rsync && rm -rf /var/lib/apt/lists/*

# Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
WORKDIR /workspace/ComfyUI
RUN pip install --no-cache-dir -r requirements.txt

# Копируем твои файлы из GitHub в образ
WORKDIR /workspace
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/
RUN chmod +x /workspace/scripts/pre_start.sh

# Переменная как на его скриншоте
ENV USE_SAGE_ATTENTION="true"

# Вшиваем запуск его методом (через main.py)
RUN sed -i '1i import os\nos.system("bash /workspace/scripts/pre_start.sh")' /workspace/ComfyUI/main.py

EXPOSE 8188

CMD ["python3", "/workspace/ComfyUI/main.py", "--listen", "0.0.0.0", "--port", "8188"]
