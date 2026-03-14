FROM smyshnikov/comfyui:base-torch2.8.0-cu128

WORKDIR /workspace/runpod-slim/ComfyUI

# Создаем папки
RUN mkdir -p models/diffusion_models models/vae models/text_encoders

# Прописываем токен и качаем модели (чтобы они всегда были внутри)
ENV HF_TOKEN=hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh

RUN wget --header="Authorization: Bearer ${HF_TOKEN}" -O models/vae/wan_2.1_vae.safetensors https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors
RUN wget --header="Authorization: Bearer ${HF_TOKEN}" -O models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors
RUN wget --header="Authorization: Bearer ${HF_TOKEN}" -O models/diffusion_models/wan2.1_high.gguf https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf

# Добавляем менеджер пресетов
RUN cd custom_nodes && git clone https://github.com/smisnikov/comfyui-preset-download-manager
