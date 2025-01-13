from openai import OpenAI
import gradio as gr
import os

base_url = os.environ.get("BASE_URL")

client = OpenAI(
     base_url = base_url,
     api_key="token"
    )

model = os.environ.get("MODEL")

auth_user = os.environ.get("AUTH_USER")
auth_password = os.environ.get("AUTH_PASSWORD")

def predict(message, history):
    history_openai_format = []
    for human, assistant in history:
        history_openai_format.append({"role": "user", "content": human })
        history_openai_format.append({"role": "assistant", "content":assistant})
    history_openai_format.append({"role": "user", "content": message})

    response = client.chat.completions.create(model=model,
        messages = history_openai_format,
        temperature = 1.0,
        stream = True)

    partial_message = ""
    for chunk in response:
        if chunk.choices[0].delta.content is not None:
              partial_message = partial_message + chunk.choices[0].delta.content
              yield partial_message

if (auth_user and auth_password):
    gr.ChatInterface(predict).launch(auth=[(auth_user, auth_password)])
else:
    gr.ChatInterface(predict).launch()
