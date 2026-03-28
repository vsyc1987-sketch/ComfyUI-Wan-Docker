FROM runpod/comfyui:latest

USER root

# 1. Системные настройки (проходит всегда)
RUN apt-get update && apt-get install -y git wget && apt-get clean && \
    git config --global http.sslVerify false && \
    git config --global --add safe.directory '*'

WORKDIR /workspace/runpod-slim/ComfyUI

# 2. Воркфлоу (через wget — он не требует токенов)
RUN mkdir -p user/default/workflows web/scripts && \
    wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json && \
    wget -q -O user/default/workflows/Artius_Wan.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# 3. Зависимости
RUN pip install --no-cache-dir opencv-python-headless ffmpeg-python tqdm

# 4. РЕШЕНИЕ ПРОБЛЕМЫ ТОКЕНОВ:
# Мы переносим установку нод в CMD. Это сработает ПРИ ЗАПУСКЕ на RunPod.
# Там нет ограничений GitHub Actions, и никакие токены не понадобятся.
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
    python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security --user-directory /workspace/runpod-slim/ComfyUI
