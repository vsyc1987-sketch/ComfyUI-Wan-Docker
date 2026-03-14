FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Скачиваем сам ComfyUI прямо при сборке
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

# Устанавливаем зависимости (нужно для работы кнопок)
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
RUN pip install -r requirements.txt

# Создаем папки для твоих моделей
RUN mkdir -p models/diffusion_models models/vae models/text_encoders

# Запуск
CMD ["python3", "main.py", "--listen", "--port", "8188"]
