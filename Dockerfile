FROM runpod/comfyui:latest

USER root

# 1. Системные настройки
RUN apt-get update && apt-get install -y git wget && apt-get clean && \
    git config --global http.sslVerify false && \
    git config --global --add safe.directory '*'

WORKDIR /workspace/runpod-slim/ComfyUI

# 2. ИСПРАВЛЕНИЕ: Кладем воркфлоу туда, где ComfyUI v0.17.2 его ТОЧНО увидит
# Мы создаем файл comfy_default.json — это главный файл автозагрузки
RUN mkdir -p user/default && \
    wget -q -O user/default/comfy_default.json https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/refs/heads/main/presets/Artius_wan2_2_14.json

# 3. Зависимости
RUN pip install --no-cache-dir opencv-python-headless ffmpeg-python tqdm

# 4. Запуск с принудительной загрузкой воркфлоу
CMD git config --global --add safe.directory '*' && \
    mkdir -p custom_nodes && cd custom_nodes && \
    for repo in \
        https://github.com/ltdrdata/ComfyUI-Manager \
        https://github.com/city96/ComfyUI-GGUF \
        https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite \
        https://github.com/ssitu/ComfyUI_UltimateSDUpscale \
        https://github.com/smyshnikof/ComfyUI-Model-Downloader; \
    do \
        dir_name=$(basename $repo); \
        [ -d "$dir_name" ] || git clone --depth 1 "$repo"; \
    done && \
    cd .. && \
    python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security \
    --workspace-load-file /workspace/runpod-slim/ComfyUI/user/default/comfy_default.json
