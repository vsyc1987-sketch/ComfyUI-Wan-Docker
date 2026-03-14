# Берем образ, где точно есть ComfyUI и Python
FROM yanze/comfyui-wan:latest

# Переходим в рабочую папку
WORKDIR /workspace/ComfyUI

# Создаем структуру папок для твоих моделей
RUN mkdir -p models/diffusion_models models/vae models/text_encoders

# Команда запуска (в этом образе она стандартная)
CMD ["python3", "main.py", "--listen", "--port", "8188"]
