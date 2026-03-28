FROM runpod/comfyui:latest

USER root

RUN apt-get update && apt-get install -y git wget && apt-get clean && \
    git config --global --add safe.directory '*'

WORKDIR /workspace/runpod-slim/ComfyUI

# Скачиваем ноды в отдельную директорию /opt/custom_nodes
RUN mkdir -p /opt/custom_nodes && \
    git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager /opt/custom_nodes/ComfyUI-Manager && \
    git clone --depth 1 https://github.com/city96/ComfyUI-GGUF /opt/custom_nodes/ComfyUI-GGUF && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite /opt/custom_nodes/ComfyUI-VideoHelperSuite && \
    git clone --depth 1 https://github.com/ssitu/ComfyUI_UltimateSDUpscale /opt/custom_nodes/ComfyUI_UltimateSDUpscale && \
    git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader /opt/custom_nodes/ComfyUI-Model-Downloader

# Подготовка воркфлоу
RUN mkdir -p user/default/workflows web/scripts && \
    wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json && \
    wget -q -O user/default/workflows/Artius_Wan.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# Установка зависимостей
RUN pip install --no-cache-dir opencv-python-headless ffmpeg-python tqdm

# Сценарий запуска: копируем ноды, снимаем защиту и запускаем ComfyUI
CMD cp -r /opt/custom_nodes/* /workspace/runpod-slim/ComfyUI/custom_nodes/ && \
    python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security --user-directory /workspace/runpod-slim/ComfyUI
