#docker build --no-cache -t comfy-base-image .
#docker tag comfy-base-image cr.eu-west1.nebius.cloud/marketplace/comfyui/comfy-base-image:0.5.0
#docker push cr.eu-west1.nebius.cloud/marketplace/comfyui/comfy-base-image:0.5.0

FROM pytorch/pytorch:2.8.0-cuda12.9-cudnn9-runtime

RUN apt-get update && apt-get install -y \
    git \
    curl \
    ffmpeg \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

RUN pip install comfy-cli

RUN mkdir -p /root/comfyui

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME ["/root/comfyui"]

EXPOSE 8188

CMD ["/usr/local/bin/entrypoint.sh"]
