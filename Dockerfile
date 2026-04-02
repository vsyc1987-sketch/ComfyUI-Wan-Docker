FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

WORKDIR /workspace

RUN apt-get update && apt-get install -y git wget libgl1-mesa-glx libglib2.0-0 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/comfyanonymous/ComfyUI.git .
RUN pip install --no-cache-dir -r requirements.txt

COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/
RUN chmod +x /workspace/scripts/pre_start.sh

EXPOSE 8188

# ИМЕННО ЭТА СТРОКА делает как у Смышникова:
CMD ["/bin/bash", "-c", "bash /workspace/scripts/pre_start.sh && python3 main.py --listen 0.0.0.0 --port 8188"]
