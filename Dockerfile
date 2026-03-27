# Используем стабильный образ
FROM runpod/comfyui:latest

# Устанавливаем рабочую директорию, которую мы видели в твоем Jupyter
WORKDIR /workspace/runpod-slim/ComfyUI

# 1. УСТАНОВКА КАСТОМНЫХ НОД
# Мы делаем это через RUN, чтобы они стали частью образа
RUN cd custom_nodes && \
    git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager && \
    git clone --depth 1 https://github.com/city96/ComfyUI-GGUF && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite && \
    git clone --depth 1 https://github.com/ssitu/ComfyUI_UltimateSDUpscale && \
    git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader

# 2. ПОДГОТОВКА ПАПОК ДЛЯ ШАБЛОНОВ
RUN mkdir -p user/default/workflows web/scripts

# 3. ЗАГРУЗКА ВОРКФЛОУ
# Используем wget вместо ADD, чтобы избежать капризов кэша Docker Buildx
RUN wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json && \
    wget -q -O user/default/workflows/Artius_Wan.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json

# 4. УСТАНОВКА ЗАВИСИМОСТЕЙ (чтобы ноды не были красными)
RUN pip install --no-cache-dir opencv-python-headless ffmpeg-python tqdm

# 5. КОМАНДА ЗАПУСКА С ОТКЛЮЧЕНИЕМ ЗАЩИТЫ
# --disable-security: снимает ту самую защиту для скачивания моделей
# --user-directory: принудительно указывает ComfyUI искать настройки в нашей папке
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "8188", "--preview-method", "auto", "--disable-security", "--user-directory", "/workspace/runpod-slim/ComfyUI"]
