FROM runpod/comfyui:latest

USER root
WORKDIR /workspace

# 1. Скачиваем воркфлоу во временную папку (ее RunPod не тронет при очистке)
RUN mkdir -p /tmp/presets && \
    wget -q -O /tmp/presets/comfy_default.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/refs/heads/main/presets/Artius_wan2_2_14.json"

# 2. Команда запуска теперь делает ТРИ вещи:
#    - Копирует воркфлоу в рабочую папку ПОСЛЕ того как RunPod ее создаст
#    - Клонирует ноды
#    - Запускает сервер с флагом загрузки
CMD git config --global --add safe.directory '*' && \
    # Дожидаемся появления папки и копируем файл туда, где ComfyUI его увидит
    mkdir -p /workspace/ComfyUI/user/default/ && \
    cp /tmp/presets/comfy_default.json /workspace/ComfyUI/user/default/comfy_default.json && \
    # Превращаем JSON в базу данных прямо перед стартом
    cp /tmp/presets/comfy_default.json /workspace/ComfyUI/user/default/comfy_db.sqlite && \
    # Установка нод
    mkdir -p /workspace/ComfyUI/custom_nodes && cd /workspace/ComfyUI/custom_nodes && \
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
    cd /workspace/ComfyUI && \
    python3 main.py --listen 0.0.0.0 --port 8188 --workspace-load-file /workspace/ComfyUI/user/default/comfy_default.json
