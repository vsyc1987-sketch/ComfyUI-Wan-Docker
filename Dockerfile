FROM runpod/stable-diffusion:comfy-ui-6.0.1

WORKDIR /workspace

# Копируем твои папки (структура должна быть как у него)
COPY scripts/ /workspace/scripts/
COPY user_workflows/ /workspace/user_workflows/

# Даем права (это критично для автозапуска в этом образе)
RUN chmod +x /workspace/scripts/pre_start.sh
