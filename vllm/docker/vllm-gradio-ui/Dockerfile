FROM python:3.10-slim

WORKDIR /usr/src/app
RUN pip install --no-cache-dir gradio=='4.*' openai=='1.61.*'
COPY app.py .
EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"

CMD ["python", "app.py"]
