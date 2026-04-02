import gradio as gr
import os
import subprocess

def download_models():
    # Вызов твоего скрипта скачивания
    process = subprocess.Popen(["bash", "/workspace/scripts/download_wan.sh"], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    for line in process.stdout:
        yield line

def launch_comfy(preset):
    # Копируем твой загруженный файл Artius_wan2_2_14.json как дефолтный
    if preset == "First Last Frame (Wan 2.2)":
        subprocess.run(["cp", "/workspace/user_workflows/Artius_wan2_2_14.json", "/workspace/ComfyUI/web/scripts/default_workflow.json"])
    
    # Запуск ComfyUI
    subprocess.Popen(["python3", "/workspace/ComfyUI/main.py", "--listen", "0.0.0.0", "--port", "8188"])
    return "🚀 ComfyUI запущен! Перейдите на порт 8188."

with gr.Blocks(title="Artois Wan Launcher") as demo:
    gr.Markdown("# 🚀 Artois-Wan 2.2 Launcher (RTX 30-series Optimized)")
    
    with gr.Row():
        with gr.Column():
            gr.Markdown("### 1. Модели")
            btn_dl = gr.Button("📥 Download Wan 2.2 Models", variant="primary")
            output = gr.Textbox(label="Логи", lines=10)
        
        with gr.Column():
            gr.Markdown("### 2. Запуск")
            mode = gr.Dropdown(["First Last Frame (Wan 2.2)", "Empty"], label="Пресет", value="First Last Frame (Wan 2.2)")
            btn_go = gr.Button("🚀 Start ComfyUI")
            status = gr.Label(label="Статус")

    btn_dl.click(download_models, outputs=output)
    btn_go.click(launch_comfy, inputs=mode, outputs=status)

demo.launch(server_name="0.0.0.0", server_port=3000)
