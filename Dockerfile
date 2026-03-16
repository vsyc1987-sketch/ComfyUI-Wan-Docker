ARG BASE_IMAGE="runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04"
FROM ${BASE_IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1

WORKDIR /workspace

# 1. Системные пакеты
RUN apt-get update && apt-get install --yes --no-install-recommends \
    git wget curl bash nginx-light ffmpeg build-essential cmake ninja-build \
    libgl1 libglib2.0-0 && apt-get clean

# 2. Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install --no-cache-dir -r requirements.txt

# 3. Установка SageAttention (для твоей 4090)
RUN pip install --no-cache-dir sageattention triton transformers accelerate xformers

# 4. Безопасное клонирование нод (Цикл Смышленникова)
COPY custom_nodes.txt /custom_nodes.txt
RUN cd custom_nodes && \
    while read -r url || [ -n "$url" ]; do \
        [ -z "$url" ] && continue; \
        dir_name=$(basename "$url" .git); \
        if [ ! -d "$dir_name" ]; then git clone --recursive "$url"; fi; \
    done < /custom_nodes.txt && \
    find . -maxdepth 2 -name "requirements.txt" -exec pip install --no-cache-dir -r {} \;

# 5. Настройка приветствия (исправлено)
RUN mkdir -p /root/.local/bin && \
    echo '#!/bin/bash' > /root/.local/bin/welcome.sh && \
    echo 'if [ -f /workspace/logo/runpod.txt ]; then cat /workspace/logo/runpod.txt; fi' >> /root/.local/bin/welcome.sh && \
    chmod +x /root/.local/bin/welcome.sh && \
    echo 'sh /root/.local/bin/welcome.sh' >> /root/.bashrc

# 6. Копируем скрипты запуска
COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8188 8888 22
CMD ["/start.sh"]
