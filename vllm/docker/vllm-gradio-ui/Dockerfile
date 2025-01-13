FROM python:3.10-slim

WORKDIR /usr/src/app
RUN pip install --no-cache-dir gradio openai
COPY app.py .
EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"

CMD ["python", "app.py"]
