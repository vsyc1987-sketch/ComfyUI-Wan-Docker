FROM runpod/comfyui:latest

USER root

# 1. Системные инструменты
RUN apt-get update && apt-get install -y git wget && apt-get clean

# 2. Рабочая директория
WORKDIR /workspace/runpod-slim/ComfyUI

# 3. Решение ошибки 128 (Dubious ownership)
# Разрешаем Git работать в этой директории без проверки владельца
RUN git config --global --add safe.directory /workspace/runpod-slim/ComfyUI && \
    git config --global --add safe.directory /workspace/runpod-slim/ComfyUI/custom_nodes

# 4. Чистая установка нод
# Сначала удаляем, потом создаем пустую папку, потом клонируем
RUN rm -rf custom_nodes && mkdir custom_nodes && \
    git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager && \
    git clone --depth 1 https://github.com/city96/ComfyUI-GGUF custom_nodes/ComfyUI-GGUF && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite custom_nodes/ComfyUI-VideoHelperSuite && \
    git clone --depth 1 https://github.com/ssitu/ComfyUI_UltimateSDUpscale custom_nodes/ComfyUI_UltimateSDUpscale && \
    git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader custom_nodes/ComfyUI-Model-Downloader

# 5. Загрузка воркфлоу
RUN mkdir -p user/default/workflows web/scripts && \
    wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json && \
    wget -q -O user/default/workflows/Artius_Wan.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# 6. Зависимости
RUN pip install --no-cache-dir opencv-python-headless ffmpeg-python tqdm

# 7. Запуск БЕЗ ЗАЩИТЫ
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "8188", "--preview-method", "auto", "--disable-security", "--user-directory", "/workspace/runpod-slim/ComfyUI"]
