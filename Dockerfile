FROM runpod/stable-diffusion:models-1.0.0

WORKDIR /workspace/runpod-slim/ComfyUI

# Создаем только папки для моделей
RUN mkdir -p models/diffusion_models models/vae models/text_encoders

# Твой токен HuggingFace
ENV HF_TOKEN=hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh

# 1. Artius Wan 2.1 High
RUN wget --header="Authorization: Bearer ${HF_TOKEN}" -O models/diffusion_models/wan2.1_high.gguf https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf

# 2. Artius Wan 2.1 Low
RUN wget --header="Authorization: Bearer ${HF_TOKEN}" -O models/diffusion_models/wan2.1_low.gguf https://huggingface.co/vsyc1987/Artius-Wan21-1.3b-low-f16.gguf/resolve/main/Artius-Wan21-1.3b-low-f16.gguf

# 3. VAE
RUN wget --header="Authorization: Bearer ${HF_TOKEN}" -O models/vae/wan_2.1_vae.safetensors https://huggingface.co/vsyc1987/wan_2.1_vae.safetensors/resolve/main/wan_2.1_vae.safetensors

# 4. Text Encoder
RUN wget --header="Authorization: Bearer ${HF_TOKEN}" -O models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors https://huggingface.co/vsyc1987/umt5_xxl_fp8_e4m3fn_scaled.safetensors/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors

# Вычистили всё лишнее. Теперь это только ТВОЙ чистый шаблон.
