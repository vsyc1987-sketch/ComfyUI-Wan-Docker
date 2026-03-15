FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# 1. Клонируем основной репозиторий
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI

# 2. Устанавливаем все необходимые ноды (включая GGUF для твоих моделей)
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
    git clone https://github.com/crystian/ComfyUI-Crystools.git && \
    git clone https://github.com/Tav9ls/ComfyUI-Custom-Presets-Manager.git && \
    git clone https://github.com/city96/ComfyUI-GGUF.git

WORKDIR /workspace/ComfyUI

# 3. Обновление PyTorch и установка зависимостей всех нод
RUN pip install --upgrade pip && \
    pip install torch==2.4.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
    pip install -r requirements.txt && \
    pip install -r custom_nodes/ComfyUI-Manager/requirements.txt && \
    pip install -r custom_nodes/ComfyUI-Crystools/requirements.txt

# 4. Создание скрипта запуска: создание папок, фоновая загрузка, запуск сервисов
RUN echo '#!/bin/bash \n\
# Создаем папки для моделей, если их нет \n\
mkdir -p models/vae models/text_encoders models/diffusion_models \n\
# Фоновая загрузка моделей \n\
wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/vae/wan_2.1_vae.safetensors https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors & \n\
wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors & \n\
wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/diffusion_models/wan2.1_high.gguf https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf & \n\
wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/diffusion_models/wan2.1_low.gguf https://huggingface.co/vsyc1987/Artius-Wan21-1.3b-low-f16.gguf/resolve/main/Artius-Wan21-1.3b-low-f16.gguf & \n\
# Загрузка воркфлоу \n\
wget -O workflow_artius.json https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14B_flf2v.json & \n\
# Запуск сервисов \n\
nohup jupyter lab --allow-root --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token="" --NotebookApp.password="" > /workspace/jupyter.log 2>&1 & \n\
python3 main.py --listen --port 8188' > /workspace/start.sh && chmod +x /workspace/start.sh

CMD ["/workspace/start.sh"]
