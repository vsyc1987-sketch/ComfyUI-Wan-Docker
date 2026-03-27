FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

WORKDIR /workspace

# ставим git и wget
RUN apt-get update && apt-get install -y git wget

# ставим ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

# зависимости
RUN pip install -r requirements.txt

# кастом ноды
WORKDIR /workspace/ComfyUI/custom_nodes
RUN git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite
RUN git clone https://github.com/comfyanonymous/ComfyUI-GGUF

# workflow
WORKDIR /workspace
RUN wget -O workflow.json https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# стартовый скрипт
RUN echo '#!/bin/bash\n\
python /workspace/ComfyUI/main.py --listen 0.0.0.0 --port 8188 &\n\
sleep 10\n\
curl -X POST http://127.0.0.1:8188/load -H "Content-Type: application/json" -d @/workspace/workflow.json\n\
wait' > /workspace/start.sh

RUN chmod +x /workspace/start.sh

CMD ["/workspace/start.sh"]
