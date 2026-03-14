FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Установка ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
WORKDIR /workspace/ComfyUI

# Исправление PyTorch и зависимостей
RUN pip install --upgrade pip && \
    pip install torch==2.4.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
    pip install -r requirements.txt

# Скрипт запуска: качает модели в фоне и запускает ComfyUI + Jupyter
RUN echo '#!/bin/bash \n\
wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/vae/wan_2.1_vae.safetensors https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors & \n\
wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors & \n\
wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/diffusion_models/wan2.1_high.gguf https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf & \n\
wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/diffusion_models/wan2.1_low.gguf https://huggingface.co/vsyc1987/Artius-Wan21-1.3b-low-f16.gguf/resolve/main/Artius-Wan21-1.3b-low-f16.gguf & \n\
python3 main.py --listen --port 8188 & \n\
/usr/bin/python3 -m jupyterlab --allow-root --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token="" --NotebookApp.password=""' > /workspace/start.sh && chmod +x /workspace/start.sh

CMD ["/workspace/start.sh"]
