FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# 1. Системные пакеты (нужны для сборки нод)
RUN apt-get update && apt-get install -y git wget ffmpeg libgl1 build-essential cmake ninja-build && apt-get clean

# 2. Клонируем базу ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
WORKDIR /workspace/ComfyUI

# 3. Клонируем ComfyUI-Manager отдельно (фундамент)
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager.git /workspace/ComfyUI/custom_nodes/ComfyUI-Manager

# 4. Установка нод по твоему списку (Безопасный цикл для GitHub Actions)
COPY custom_nodes.txt /workspace/custom_nodes.txt
RUN cd /workspace/ComfyUI/custom_nodes && \
    while read -r url || [ -n "$url" ]; do \
        [ -z "$url" ] && continue; \
        dir_name=$(basename "$url" .git); \
        if [ ! -d "$dir_name" ]; then \
            echo "Cloning $dir_name..."; \
            git clone --recursive "$url"; \
        fi; \
    done < /workspace/custom_nodes.txt

# 5. Установка SageAttention и зависимостей для 4090
# Мы ставим SageAttention через pip, чтобы ноды могли его импортировать
RUN pip install --upgrade pip && \
    pip install torch==2.4.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
    pip install sageattention triton transformers accelerate xformers && \
    pip install -r requirements.txt

# 6. Массовая установка requirements для всех скачанных нод
RUN find /workspace/ComfyUI/custom_nodes -maxdepth 2 -name "requirements.txt" -exec pip install --no-cache-dir -r {} \;

# 7. Подготовка скрипта запуска
COPY scripts/start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

CMD ["/workspace/start.sh"]
