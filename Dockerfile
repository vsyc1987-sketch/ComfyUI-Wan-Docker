FROM runpod/pytorch:2.4.0-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

# Обновляем pip и ставим самый свежий Torch для нод Егора
RUN pip install --upgrade pip
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Ставим зависимости
RUN pip install -r requirements.txt

# Создаем папки
RUN mkdir -p models/diffusion_models models/vae models/text_encoders

CMD ["python3", "main.py", "--listen", "--port", "8188"]
