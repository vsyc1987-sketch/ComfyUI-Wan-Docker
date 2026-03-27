#!/bin/bash

# 1. Автоматически находим, где реально лежит ComfyUI
REAL_PATH=$(find /workspace -name "main.py" -path "*/ComfyUI/*" | head -n 1 | xargs dirname)
echo "ComfyUI найден здесь: $REAL_PATH"
cd "$REAL_PATH"

# 2. Ссылка на твой воркфлоу
WORKFLOW_URL="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# 3. Создаем папку для шаблонов именно там, где их видит ComfyUI
mkdir -p "$REAL_PATH/user/default/workflows/"
mkdir -p "$REAL_PATH/web/scripts/"

# 4. Скачиваем файл в правильные места
wget -q -O "$REAL_PATH/user/default/workflows/Artius_Wan.json" "$WORKFLOW_URL"
wget -q -O "$REAL_PATH/web/scripts/default_workflow.json" "$WORKFLOW_URL"

# 5. Установка нод (если их нет)
cd "$REAL_PATH/custom_nodes"
[ -d "ComfyUI-Manager" ] || git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager
[ -d "ComfyUI-GGUF" ] || git clone --depth 1 https://github.com/city96/ComfyUI-GGUF
[ -d "ComfyUI-VideoHelperSuite" ] || git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite
[ -d "ComfyUI_UltimateSDUpscale" ] || git clone --depth 1 https://github.com/ssitu/ComfyUI_UltimateSDUpscale

# 6. Запуск из правильной папки
cd "$REAL_PATH"
python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security
