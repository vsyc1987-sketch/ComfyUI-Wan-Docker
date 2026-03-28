FROM runpod/comfyui:latest

USER root

# 1. Подготовка системы и прав
RUN apt-get update && apt-get install -y git wget && apt-get clean
# Исправляем ошибку 128: разрешаем Git работать в любых папках контейнера
RUN git config --global --add safe.directory '*'

# 2. Рабочая директория
WORKDIR /workspace/runpod-slim/ComfyUI

# 3. Установка кастомных нод (с очисткой перед клонированием)
RUN mkdir -p custom_nodes && \
    rm -rf custom_nodes/* && \
    git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager && \
    git clone --depth 1 https://github.com/city96/ComfyUI-GGUF custom_nodes/ComfyUI-GGUF && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite custom_nodes/ComfyUI-VideoHelperSuite && \
    git clone --depth 1 https://github.com/ssitu/ComfyUI_UltimateSDUpscale custom_nodes/ComfyUI_UltimateSDUpscale && \
    git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader custom_nodes/ComfyUI-Model-Downloader

# 4. Загрузка воркфлоу в системные папки
RUN mkdir -p user/default/workflows web/scripts && \
    wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json && \
    wget -q -O user/default/workflows/Artius_Wan.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# 5. Установка необходимых зависимостей для нод
RUN pip install --no-cache-dir opencv-python-headless ffmpeg-python tqdm

# 6. Запуск с полным доступом и отключенной защитой
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "8188", "--preview-method", "auto", "--disable-security", "--user-directory", "/workspace/runpod-slim/ComfyUI"]
