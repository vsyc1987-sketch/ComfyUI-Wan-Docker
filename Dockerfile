# ИСПОЛЬЗУЕМ БАЗУ (ВЫБЕРИ СВОЮ, НАПРИМЕР, RUNPOD-SLIM ИЛИ ОБЫЧНУЮ)
FROM runpod/stable-diffusion:comfy-ui-v1.0.0

# УСТАНОВКА ЗАВИСИМОСТЕЙ
RUN apt-get update && apt-get install -y wget git && rm -rf /var/lib/apt/lists/*

# СОЗДАНИЕ ПАПКИ ДЛЯ ПРЕСЕТОВ
RUN mkdir -p /tmp/presets && \
    wget -q -O /tmp/presets/comfy_default.json "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/presets/flf/Artius_wan2_2_14.json"

# УСТАНОВКА ТВОЕГО PROVISIONING СКРИПТА
RUN wget -q -O /workspace/provisioning.sh "https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/provisioning.sh" && \
    chmod +x /workspace/provisioning.sh

# ЗАПУСК
CMD ["/workspace/provisioning.sh"]
