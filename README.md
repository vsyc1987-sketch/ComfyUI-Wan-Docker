# ⚡ Artius Wan 2.2 High-Performance Workflow

<div align="center">
  <img src="https://raw.githubusercontent.com/vsyc1987-sketch/ComfyUI-Wan-Docker/main/logo/runpod.txt" alt="Logo" width="600">
  <br />
  <p align="center">
    <strong>Ultimate Video Generation Stack: Wan 2.2 + SageAttention + RTX 4090</strong>
  </p>
</div>

---

## 🚀 О проекте

Профессиональный Docker-образ для **RunPod**, созданный на базе архитектуры Смышленникова. Оптимизирован специально для работы с видео-моделями семейства **Wan 2.2 (14B)**. 

### Основные фишки:
* **SageAttention & Chatention**: Встроенная поддержка ядер ускорения внимания для мгновенной генерации на картах серии 4090/3090.
* **GGUF Native**: Полная поддержка сжатых моделей 14B для экономии VRAM.
* **Auto-Workflow**: Автоматическая загрузка твоего пресета `Artius_wan2_2_14B_flf2v.json`.
* **Pro-Stack**: Включает все необходимые ноды (KJNodes, WanVideoWrapper, Impact Pack и др.).

---

## 🛠 Установка и запуск

1. **Развертывание**: Используй этот образ в RunPod (Template).
2. **Автоматизация**: При старте контейнер сам создаст структуру папок и начнет загрузку весов в фоне:
   - `wan_2.1_vae.safetensors`
   - `Artius-Wan22-14b-I2V-high-Q4_K_M-v2.gguf`
3. **Доступ**:
   - **ComfyUI**: порт `8188`
   - **Jupyter Lab**: порт `8888`
   - **SSH**: порт `22`

---

## 📂 Структура репозитория

* `/custom_nodes.txt` — Полный список профессиональных нод.
* `/scripts/start.sh` — Скрипт инициализации окружения и загрузки моделей.
* `/presets` — Твои уникальные воркфлоу для Wan 2.2.

---

## 💻 Системные требования

| Компонент | Требование |
| :--- | :--- |
| **GPU** | NVIDIA RTX 3090 / 4090 (24GB VRAM) |
| **CUDA** | 12.1+ |
| **Storage** | 50GB+ (для моделей и кэша) |

---

<div align="center">
  <sub>Создано с любовью к качественной генерации видео. 2026.</sub>
</div>
