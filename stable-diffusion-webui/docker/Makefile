CI_REGISTRY ?= cr.ai.nebius.cloud/crng6buqs6ev01fc6sff/nebius/stable-diffusion-webui

define build
$(eval IMAGE := ${CI_REGISTRY}/$(2):$(3))
@docker build --tag ${IMAGE} $(1)
@docker push ${IMAGE}
endef

build-cuda:
	$(call build,cuda,cuda,12.2.2)

build-models:
	$(call build,models,models,1.7.0)

build-webui:
	$(call build,stable-diffusion,stable-diffusion-webui,1.7.0)

all: build-cuda build-models build-webui
