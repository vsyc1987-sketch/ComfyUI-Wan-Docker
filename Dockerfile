FROM runpod/stable-diffusion:models-1.0.0

WORKDIR /workspace/ComfyUI

# Создаем папки (это всегда работает)
RUN mkdir -p models/diffusion_models models/vae models/text_encoders

# Просто запускаем ComfyUI. Модели скачаем внутри самого RunPod за 5 минут.
CMD ["python3", "main.py", "--listen", "--port", "8188"]
