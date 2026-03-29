FROM runpod/comfyui:latest

USER root

# 1. Работаем ТОЛЬКО в стандартной папке (никаких runpod-slim!)
WORKDIR /workspace/ComfyUI

# 2. Системные настройки
RUN apt-get update && apt-get install -y git wget && apt-get clean

# 3. Скачиваем воркфлоу и СРАЗУ делаем его базой данных
# Это тот самый секрет, чтобы всё загрузилось "само" без ручного импорта
RUN mkdir -p user/default && \
    wget -q -O user/default/comfy_default.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/refs/heads/main/presets/Artius_wan2_2_14.json" && \
    cp user/default/comfy_default.json user/default/comfy_db.sqlite

# 4. Установка нод в CMD (чтобы не было проблем с доступом)
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
