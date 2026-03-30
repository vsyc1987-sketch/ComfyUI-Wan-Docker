FROM runpod/comfyui:latest

# Устанавливаем только системные зависимости
RUN apt-get update && apt-get install -y wget git curl && rm -rf /var/lib/apt/lists/*

# Пустая рабочая директория, всё остальное сделает provisioning.sh при старте пода
WORKDIR /workspace
