# Используем твой базовый образ (укажи свой, если он отличается)
FROM runpod/comfyui:latest

# 1. Устанавливаем рабочую директорию точно по твоему пути
WORKDIR /workspace/runpod-slim/ComfyUI

# 2. Установка всех необходимых кастомных нод (без моделей)
RUN cd custom_nodes && \
    git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager && \
    git clone --depth 1 https://github.com/city96/ComfyUI-GGUF && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite && \
    git clone --depth 1 https://github.com/ssitu/ComfyUI_UltimateSDUpscale && \
    git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader

# 3. Подготовка структуры папок для шаблонов
RUN mkdir -p user/default/workflows && mkdir -p web/scripts

# 4. Загрузка твоего workflow (заменяем дефолтный и добавляем в шаблоны)
# Ссылка на твой RAW файл с GitHub
ADD https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json web/scripts/default_workflow.json
ADD https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json user/default/workflows/Artius_Wan.json

# 5. Установка зависимостей для нод (чтобы не было ошибок импорта)
RUN pip install --no-cache-dir \
    opencv-python-headless \
    ffmpeg-python \
    tqdm

# 6. Команда запуска
# --disable-security ОБЯЗАТЕЛЕН для работы ноды Смышникова
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "8188", "--preview-method", "auto", "--disable-security"]
