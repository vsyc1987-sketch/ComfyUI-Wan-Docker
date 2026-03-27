#!/bash/bin

# 1. Жесткие пути на основе твоего Jupyter (runpod-slim)
ROOT="/workspace/runpod-slim/ComfyUI"
WF_DIR="$ROOT/user/default/workflows"
SCRIPTS_DIR="$ROOT/web/scripts"
NODES_DIR="$ROOT/custom_nodes"

# Ссылка на твой воркфлоу
URL="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"

# 2. Создаем структуру папок (если их нет)
mkdir -p "$WF_DIR"
mkdir -p "$SCRIPTS_DIR"

# 3. Принудительно скачиваем воркфлоу во все нужные места
wget -q -O "$WF_DIR/Artius_Wan.json" "$URL"
wget -q -O "$SCRIPTS_DIR/default_workflow.json" "$URL"
wget -q -O "$ROOT/default_workflow.json" "$URL"

# 4. Установка нод (проверка на существование, чтобы не качать заново)
install_node() {
    if [ ! -d "$NODES_DIR/$2" ]; then
        git clone --depth 1 "$1" "$NODES_DIR/$2"
    fi
}

install_node "https://github.com/ltdrdata/ComfyUI-Manager" "ComfyUI-Manager"
install_node "https://github.com/city96/ComfyUI-GGUF" "ComfyUI-GGUF"
install_node "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite" "ComfyUI-VideoHelperSuite"
install_node "https://github.com/ssitu/ComfyUI_UltimateSDUpscale" "ComfyUI_UltimateSDUpscale"
install_node "https://github.com/smyshnikof/ComfyUI-Model-Downloader" "ComfyUI-Model-Downloader"

# 5. Запуск из правильной папки с отключенной защитой
cd "$ROOT"
python3 main.py --listen 0.0.0.0 --port 8188 --preview-method auto --disable-security --user-directory "$ROOT"
