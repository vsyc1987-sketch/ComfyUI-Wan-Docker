FROM runpod/pytorch:2.1.0-py3.10-cuda12.1.1-devel

WORKDIR /workspace

# Установка ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

# Установка зависимостей
RUN pip install -r requirements.txt

# Кастом ноды
WORKDIR /workspace/ComfyUI/custom_nodes
RUN git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite
RUN git clone https://github.com/comfyanonymous/ComfyUI-GGUF

# Workflow
WORKDIR /workspace
RUN wget -O workflow.json https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# Старт
WORKDIR /workspace/ComfyUI
CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "8188"]
