##!/bin/bash
G='\033[0;32m'; Y='\033[1;33m'; R='\033[0;31m'; NC='\033[0m'

# Удаляем метку готовности, чтобы принудительно применить исправления
rm -f /workspace/ready.txt

echo -e "${Y}--- КРИТИЧЕСКОЕ ОБНОВЛЕНИЕ СИСТЕМЫ ---${NC}"

# 1. Исправляем PyTorch и NumPy (это решит ошибку AttributeError и NumPy crash)
# Ставим версию 2.4.0, где custom_op уже точно есть
echo -e "${Y}Обновляю компоненты (может занять 2-3 минуты)...${NC}"
pip install --upgrade torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 --quiet
pip install "numpy<2" --quiet

# 2. Поиск папки ComfyUI
COMFY_DIR=$(find /workspace -maxdepth 2 -name "main.py" -exec dirname {} \; | head -n 1)

# 3. Ссылки на твой Artois Wan 2.2
WFLOW="https://raw.githubusercontent.com/vsyck/ComfyUI-Wan-Docker/main/presets/Artius_wan2_2_14.json"
MODEL="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/unet/wan2.1_t2v_1.3b_bf16.safetensors"
VAE="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"

# 4. Проверка моделей
mkdir -p "$COMFY_DIR/models/unet" "$COMFY_DIR/models/vae"
[ -f "$COMFY_DIR/models/vae/wan_2.1_vae.safetensors" ] || wget -q -c -O "$COMFY_DIR/models/vae/wan_2.1_vae.safetensors" "$VAE"
[ -f "$COMFY_DIR/models/unet/wan2.1_t2v_1.3b_bf16.safetensors" ] || wget -q -c -O "$COMFY_DIR/models/unet/wan2.1_t2v_1.3b_bf16.safetensors" "$MODEL"

# 5. Установка твоего шаблона
mkdir -p "$COMFY_DIR/web/scripts"
wget -q -O "$COMFY_DIR/web/scripts/default_workflow.json" "$WFLOW"

# Ставим метку, что всё исправлено
touch /workspace/ready.txt

echo -e "${G}!!! СИСТЕМА ОБНОВЛЕНА И ГОТОВА. ЗАПУСК... !!!${NC}"
cd "$COMFY_DIR"
python3 main.py --listen 0.0.0.0 --port 8188
