# Makefile for updating multiple Helm charts from upstream repositories

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Temporary directory for downloads
TEMP_DIR := .tmp-upstream

# Chart configurations - Add your charts here
# Format: <target-name>_REPO_NAME, <target-name>_REPO_URL, <target-name>_CHART, <target-name>_VERSION, <target-name>_LOCAL_PATH

# NVDP Chart
NVDP_GITHUB_ORG := NVIDIA
NVDP_GITHUB_REPO := k8s-device-plugin
NVDP_VERSION := "0.17.2"
NVDP_CHART_FILE := nvidia-device-plugin-$(NVDP_VERSION).tgz 
NVDP_LOCAL_PATH := ./chart/

# NFD Chart
NFD_REPO_NAME := nfd
NFD_REPO_URL := https://kubernetes-sigs.github.io/node-feature-discovery/charts
NFD_CHART := node-feature-discovery
NFD_VERSION := "v0.17.2"
NFD_LOCAL_PATH := ./chart/charts/node-feature-discovery

# DCGM Exporter
DCGM_REPO_NAME := dcgm
DCGM_REPO_URL := https://nvidia.github.io/dcgm-exporter/helm-charts
DCGM_CHART := dcgm-exporter
DCGM_VERSION :=  "v4.0.3"
DCGM_LOCAL_PATH := ./chart/charts/dcgm-exporter

.PHONY: update
update: ## Update all configured helm charts
	@echo "$(GREEN)Updating all helm charts...$(NC)"
	@$(MAKE) update-nvdp
	@$(MAKE) update-nfd
	@$(MAKE) update-dcgm
	@patch -p0 < nebius-changes/diff.patch
	@echo "$(GREEN)✓ All charts updated successfully!$(NC)"

.PHONY: update-nvdp
update-nvdp: ## Update NVDP chart
	@echo "$(YELLOW)Updating NVDP chart...$(NC)"
	@$(MAKE) update-github-chart \
		GITHUB_ORG=$(NVDP_GITHUB_ORG) \
		GITHUB_REPO=$(NVDP_GITHUB_REPO) \
		VERSION=$(NVDP_VERSION) \
		CHART_FILE=$(NVDP_CHART_FILE) \
		LOCAL_PATH=$(NVDP_LOCAL_PATH)

.PHONY: update-nfd
update-nfd: ## Update NFD chart
	@echo "$(YELLOW)Updating NFD chart...$(NC)"
	@$(MAKE) update-chart \
		REPO_NAME=$(NFD_REPO_NAME) \
		REPO_URL=$(NFD_REPO_URL) \
		CHART=$(NFD_CHART) \
		VERSION=$(NFD_VERSION) \
		LOCAL_PATH=$(NFD_LOCAL_PATH)

.PHONY: update-dcgm
update-dcgm: ## Update DCGM Exporter chart
	@echo "$(YELLOW)Updating DCGM Exporter chart...$(NC)"
	@$(MAKE) update-chart \
		REPO_NAME=$(DCGM_REPO_NAME) \
		REPO_URL=$(DCGM_REPO_URL) \
		CHART=$(DCGM_CHART) \
		VERSION=$(DCGM_VERSION) \
		LOCAL_PATH=$(DCGM_LOCAL_PATH)

.PHONY: update-chart
update-chart: ## Generic chart update function (used internally)
	@helm repo add $(REPO_NAME) $(REPO_URL) --force-update >/dev/null 2>&1
	@helm repo update $(REPO_NAME) >/dev/null 2>&1
	@mkdir -p $(TEMP_DIR)
	@if [ "$(VERSION)" = "latest" ]; then \
		helm pull $(REPO_NAME)/$(CHART) --untar --untardir $(TEMP_DIR) >/dev/null 2>&1; \
	else \
		helm pull $(REPO_NAME)/$(CHART) --version $(VERSION) --untar --untardir $(TEMP_DIR) >/dev/null 2>&1; \
	fi
	@if [ -d "$(TEMP_DIR)/$(CHART)" ]; then \
    rm -rf $(LOCAL_PATH) ; \
		mkdir -p $(LOCAL_PATH); \
		cp -r $(TEMP_DIR)/$(CHART)/* $(LOCAL_PATH)/; \
		echo "$(GREEN)✓ $(CHART) templates updated$(NC)"; \
	else \
		echo "$(RED)✗ $(CHART) templates directory not found$(NC)"; \
		exit 1; \
	fi
	@rm -rf $(TEMP_DIR)

.PHONY: update-github-chart
update-github-chart: ## Update chart from GitHub release (used internally)
	@mkdir -p $(TEMP_DIR)
	@echo "  Downloading from https://github.com/$(GITHUB_ORG)/$(GITHUB_REPO)/releases/download/v$(VERSION)/$(CHART_FILE)"
	curl -sL "https://github.com/$(GITHUB_ORG)/$(GITHUB_REPO)/releases/download/v$(VERSION)/$(CHART_FILE)" -o $(TEMP_DIR)/$(CHART_FILE)
	tar -xzf $(TEMP_DIR)/$(CHART_FILE) -C $(TEMP_DIR)
	@CHART_DIR=$$(find $(TEMP_DIR) -maxdepth 1 -type d | tail -1); \
	if [ -n "$$CHART_DIR" ]; then \
		rm -rf $(LOCAL_PATH) ; \
		mkdir -p $(LOCAL_PATH); \
		cp -r $$CHART_DIR/* $(LOCAL_PATH)/; \
		echo "$(GREEN)✓ Chart updated from GitHub$(NC)"; \
	else \
		echo "$(RED)✗ Chart not found in GitHub release$(NC)"; \
		exit 1; \
	fi
	@rm -rf $(TEMP_DIR)

.PHONY: list
list: ## List all configured charts
	@echo "$(GREEN)Configured charts:$(NC)"
	@echo "  • NVDP: $(NFD_REPO_NAME)/$(NFD_CHART) → $(NFD_LOCAL_PATH)"
	@echo "  • NFD: $(NVDP_REPO_NAME)/$(NVDP_CHART) → $(NVDP_LOCAL_PATH)"
	@echo "  • DCGM Exporter: $(DCGM_REPO_NAME)/$(DCGM_CHART) → $(DCGM_LOCAL_PATH)"

.PHONY: validate
validate: ## Validate all local charts
	@echo "$(YELLOW)Validating all charts...$(NC)"
	@for chart in $(NFD_LOCAL_PATH) $(NVDP_LOCAL_PATH) $(DCGM_LOCAL_PATH) $(PROMETHEUS_LOCAL_PATH) $(CERTMANAGER_LOCAL_PATH); do \
		if [ -d "$$chart" ]; then \
			echo -n "Validating $$chart... "; \
			if helm lint $$chart >/dev/null 2>&1; then \
				echo "$(GREEN)✓$(NC)"; \
			else \
				echo "$(RED)✗$(NC)"; \
			fi; \
		fi; \
	done

.PHONY: diff-all
diff-all: ## Show differences for all charts
	@$(MAKE) diff-nvdp
	@$(MAKE) diff-nfd
	@$(MAKE) diff-dcgm

.PHONY: diff-nvdp
diff-nvdp: ## Show differences for NVDP chart
	@echo "$(YELLOW)NVDP differences:$(NC)"
	@$(MAKE) diff-chart \
		REPO_NAME=$(NFD_REPO_NAME) \
		REPO_URL=$(NFD_REPO_URL) \
		CHART=$(NFD_CHART) \
		VERSION=$(NFD_VERSION) \
		LOCAL_PATH=$(NFD_LOCAL_PATH)

.PHONY: diff-ndp
diff-ndp: ## Show differences for NDP chart
	@echo "$(YELLOW)NDP differences:$(NC)"
	@$(MAKE) diff-chart \
		REPO_NAME=$(NVDP_REPO_NAME) \
		REPO_URL=$(NVDP_REPO_URL) \
		CHART=$(NVDP_CHART) \
		VERSION=$(NVDP_VERSION) \
		LOCAL_PATH=$(NVDP_LOCAL_PATH)

.PHONY: diff-dcgm
diff-dcgm: ## Show differences for DCGM Exporter chart
	@echo "$(YELLOW)Dcgm differences:$(NC)"
	@$(MAKE) diff-chart \
		REPO_NAME=$(DCGM_REPO_NAME) \
		REPO_URL=$(DCGM_REPO_URL) \
		CHART=$(DCGM_CHART) \
		VERSION=$(DCGM_VERSION) \
		LOCAL_PATH=$(DCGM_LOCAL_PATH)

.PHONY: diff-chart
diff-chart: ## Generic diff function (used internally)
	@helm repo add $(REPO_NAME) $(REPO_URL) --force-update >/dev/null 2>&1
	@helm repo update $(REPO_NAME) >/dev/null 2>&1
	@mkdir -p $(TEMP_DIR)
	@if [ "$(VERSION)" = "latest" ]; then \
		helm pull $(REPO_NAME)/$(CHART) --untar --untardir $(TEMP_DIR) >/dev/null 2>&1; \
	else \
		helm pull $(REPO_NAME)/$(CHART) --version $(VERSION) --untar --untardir $(TEMP_DIR) >/dev/null 2>&1; \
	fi
	@diff -ur $(LOCAL_PATH)/ $(TEMP_DIR)/$(CHART)/ 2>/dev/null || true
	@rm -rf $(TEMP_DIR)

.PHONY: clean
clean: ## Clean temporary files
	@rm -rf $(TEMP_DIR)

.PHONY: help
help: ## Show this help message
	@echo 'Usage:'
	@echo '  make [target]'
	@echo ''
	@echo 'Main targets:'
	@echo '  $(GREEN)update$(NC)              Update all configured charts'
	@echo '  $(GREEN)list$(NC)                List all configured charts'
	@echo '  $(GREEN)validate$(NC)            Validate all local charts'
	@echo '  $(GREEN)diff-all$(NC)            Show differences for all charts'
	@echo ''
	@echo 'Individual chart targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 !~ /^(update-chart|diff-chart|update|list|validate|diff-all|clean|help)$$/) printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ''
	@echo 'Run "make list" to see all configured charts and their sources.'

# Default target
.DEFAULT_GOAL := help
