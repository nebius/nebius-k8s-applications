FROM cr.ai.nebius.cloud/crng6buqs6ev01fc6sff/nebius/stable-diffusion-webui/cuda:12.2.2-base-ubuntu20.04
ENV VERSION=1
ENV DEBIAN_FRONTEND=noninteractive 

COPY apt.conf /etc/apt/apt.conf.d/clean
COPY deadsnakes.list /etc/apt/sources.list.d/deadsnakes.list
COPY deadsnakes.gpg /etc/apt/trusted.gpg.d/deadsnakes.gpg

COPY tools /usr/local/sbin/
RUN chmod a+x /usr/local/sbin/* && rm -fr /var/log/* /tmp/*

RUN apt-install gnupg2 openssl ca-certificates libffi7 apt-utils git
