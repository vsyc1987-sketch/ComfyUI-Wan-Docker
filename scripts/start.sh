#!/bin/bash

# 1. ЖЕСТКИЙ ПОИСК ПУТИ (Никаких "угадываний")
# Мы ищем, где лежит исполняемый файл ComfyUI, и работаем только от него.
COMFY_ROOT=$(find /workspace -name "main.py" -path "*/ComfyUI/*" | head -n 1 | xargs dirname)
echo "Определен реальный путь ComfyUI: $COMFY_ROOT"
cd "$COMFY_ROOT"

# 2. ПРЯМЫЕ ССЫЛКИ
WORKFLOW_URL="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# 3. ПОДГОТОВКА СТРУКТУРЫ (Создаем папки там, где они ДОЛЖНЫ быть)
mkdir -p "$COMFY_ROOT/web/scripts"
mkdir -p "$COMFY_ROOT/user/default/workflows"
mkdir -p "$COMFY_ROOT/custom_nodes"

# 4. УСТАНОВКА НОД (Проверяем наличие каждой)
install_node() {
    if [ ! -d "$COMFY_ROOT/custom_nodes/$2" ]; then
        git clone --depth 1 "$1" "$COMFY_ROOT/custom_nodes/$2"
    fi
}

install_node "https://github.com/ltdrdata/ComfyUI-Manager" "ComfyUI-Manager"
install_node "https://github.com/smyshnikof/ComfyUI-Model-Downloader" "ComfyUI-Model-Downloader"
install_node "https://github.com/city96/ComfyUI-GGUF" "ComfyUI-GGUF"
install_node "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite" "ComfyUI-VideoHelperSuite"
install_node "https://github.com/ssitu/ComfyUI_UltimateSDUpscale" "ComfyUI_UltimateSDUpscale"

# 5. ЗАГРУЗКА ВОРКФЛОУ (Заменяем дефолт и добавляем в шаблоны)
wget -q -O "$COMFY_ROOT/web/scripts/default_workflow.json" "$WORKFLOW_URL"
wget -q -O "$COMFY_ROOT/user/default/workflows/Artius_Wan_2_2.json" "$WORKFLOW_URL"

# 6. ФИНАЛЬНЫЙ ЗАПУСК
# --disable-security: чтобы нода Смышникова могла качать файлы
# --user-directory: чтобы ComfyUI не терял созданные нами папки
python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security --user-directory "$COMFY_ROOT"
