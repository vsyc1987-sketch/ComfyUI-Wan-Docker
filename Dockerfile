FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

# КРИТИЧЕСКИЙ ШАГ: Обновляем Torch до 2.4+, чтобы не было ошибки custom_op
RUN pip install --upgrade pip
RUN pip install torch==2.4.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Ставим остальные зависимости
RUN pip install -r requirements.txt

# Создаем папки
RUN mkdir -p models/diffusion_models models/vae models/text_encoders

# Запуск
CMD ["python3", "main.py", "--listen", "--port", "8188"]
