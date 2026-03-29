FROM runpod/comfyui:latest

USER root

# Системные настройки
RUN apt-get update && apt-get install -y git wget && apt-get clean

# ИСПОЛЬЗУЕМ СТАНДАРТНЫЙ ПУТЬ ОБРАЗА
WORKDIR /workspace/ComfyUI

# Скачиваем воркфлоу в папку, которую образ точно подхватит
RUN mkdir -p user/default && \
    wget -q -O user/default/comfy_default.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/refs/heads/main/presets/Artius_wan2_2_14.json"

# Установка нод при старте (чтобы избежать проблем с правами при сборке)
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
    python3 main.py --listen 0.0.0.0 --port 8188 --workspace-load-file /workspace/ComfyUI/user/default/comfy_default.json
