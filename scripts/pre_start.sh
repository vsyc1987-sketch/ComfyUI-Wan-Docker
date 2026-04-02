FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    git wget libgl1-mesa-glx libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/comfyanonymous/ComfyUI.git .
RUN pip install --no-cache-dir -r requirements.txt

# Создаем папку заранее, чтобы Docker не ругался
RUN mkdir -p /workspace/scripts /workspace/user_workflows

# Копируем содержимое папок из GitHub
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/

# Даем права (теперь файл точно будет там)
RUN chmod +x /workspace/scripts/pre_start.sh

EXPOSE 8188

# Запуск строго по пути scripts
CMD ["/bin/bash", "-c", "bash /workspace/scripts/pre_start.sh && python3 main.py --listen 0.0.0.0 --port 8188"]
