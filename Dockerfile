FROM runpod/stable-diffusion:models-1.0.0

WORKDIR /workspace/ComfyUI

# Устанавливаем wget, если его нет
RUN apt-get update && apt-get install -y wget

# Создаем скрипт загрузки, который сработает ПРИ ЗАПУСКЕ пода
RUN echo '#!/bin/bash \n\
mkdir -p models/diffusion_models models/vae models/text_encoders \n\
if [ ! -f models/diffusion_models/wan2.1_high.gguf ]; then \n\
  wget --header="Authorization: Bearer hf_CfUcojEzeWjpZFrwHjAsUxfqzUesteZdh" -O models/diffusion_models/wan2.1_high.gguf https://huggingface.co/vsyc1987/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf/resolve/main/Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf \n\
fi \n\
# Аналогично для остальных файлов (добавь по желанию или скачай вручную через терминал) \n\
python3 main.py --listen --port 8188' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]
