FROM cr.ai.nebius.cloud/crng6buqs6ev01fc6sff/nebius/stable-diffusion-webui/cuda:12.2.2

ARG PYTHON_VERSION=3.10
ARG STABLE_DIFFUSION_VERSION=1.7.0

RUN install-python ${PYTHON_VERSION}
RUN apt-install wget libgl1 libglib2.0-0

ADD requirements.txt /tmp/

RUN git clone -b v${STABLE_DIFFUSION_VERSION} https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /stable-diffusion-webui
RUN python${PYTHON_VERSION} -m venv /usr/share/stable-diffusion-webui \
  && /usr/share/stable-diffusion-webui/bin/pip install -Ur /tmp/requirements.txt \
  && /usr/share/stable-diffusion-webui/bin/pip install -Ur /stable-diffusion-webui/requirements_versions.txt

WORKDIR /stable-diffusion-webui
RUN cp launch.py /tmp/launch.py \
  && sed -i -e 's/    start()/    #start()/g' launch.py \
  && /usr/share/stable-diffusion-webui/bin/python launch.py --skip-torch-cuda-test \
  && mv /tmp/launch.py launch.py

EXPOSE 80
CMD /usr/share/stable-diffusion-webui/bin/python launch.py  --xformers --listen  --cors-allow-origins=* --api --port=80 --enable-insecure-extension-access
