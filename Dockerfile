FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

# Обновляем pip и ставим зависимости
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Создаем папки для моделей
RUN mkdir -p models/diffusion_models models/vae models/text_encoders

# Запуск
CMD ["python3", "main.py", "--listen", "--port", "8188"]
