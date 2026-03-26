#!/bin/bash

# 1. Переходим в рабочую директорию
cd /workspace/ComfyUI

# 2. Установка необходимых кастомных нод (исправляем красные блоки)
cd custom_nodes

# Менеджер и загрузчик моделей
[ -d "ComfyUI-Manager" ] || git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager
[ -d "ComfyUI-Model-Downloader" ] || git clone --depth 1 https://github.com/smyshnikof/ComfyUI-Model-Downloader

# Ноды для работы Wan 2.1 и видео (UnetLoaderGGUF, VHS_VideoCombine)
[ -d "ComfyUI-GGUF" ] || git clone --depth 1 https://github.com/city96/ComfyUI-GGUF
[ -d "ComfyUI-VideoHelperSuite" ] || git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite

# Нода для апскейла (UltimateSDUpscale)
[ -d "ComfyUI_UltimateSDUpscale" ] || git clone --depth 1 https://github.com/ssitu/ComfyUI_UltimateSDUpscale

# 3. Настройка автоматической загрузки твоего Workflow
cd /workspace/ComfyUI
mkdir -p web/scripts

# Скачиваем твой JSON и делаем его стандартным (default)
wget -q -O web/scripts/default_workflow.json https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json
# Дублируем для надежности
cp web/scripts/default_workflow.json default_workflow.json

# 4. Запуск ComfyUI
# Флаг --disable-security ОБЯЗАТЕЛЕН для работы ноды Смышникова
# Флаг --user-directory сохраняет настройки на твой диск 40GB
python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security --user-directory /workspace/ComfyUI
