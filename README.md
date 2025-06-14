# Nebius library of applications for Kubernetes®

Welcome to the **Nebius library of applications for Kubernetes** repository! This repository contains the configuration, manifests and Helm charts for deploying and managing applications for Kubernetes.

---

## Table of contents

1. [Overview](#overview)
1. [Applications](#applications)
1. [Getting started](#getting-started)
1. [Contributing](#contributing)
1. [License](#license)
1. [Support](#support)

---

## Overview

This repository serves as a central hub for managing and deploying applications for Kubernetes built for the Nebius platform. These applications are designed to ensure high availability, scalability and seamless integration with the Nebius ecosystem.

---

## Applications

- [Airflow](apache-airflow/README.md)
- [Argo CD](argo-project-argo-cd/README.md)
- [CVAT](cvat-cvat/README.md)
- [Flowise](flowise/README.md)
- [H2O](h2o-3/README.md)
- [h2oGPT](h2oai-h2ogpt/README.md)
- [JupyterHub](jupyterhub/README.md)
- [Milvus](milvus-milvus/README.md)
- [MLflow](ml-flow/README.md)
- [NVIDIA® GPU Operator](nvidia-gpu-operator/README.md)
- [NVIDIA® Network Operator](nvidia-network-operator/README.md)
- [Qdrant](qdrant-qdrant/README.md)
- [Ray Cluster](ray-cluster/README.md)
- [Stable Diffusion WebUI](stable-diffusion-webui/README.md)
- [vLLM](vllm/README.md)
- [Grafana Loki](loki/README.md)
- [Grafana and Prometheus](grafana-and-prometheus/README.md)
- [Grafana® solution by Nebius](nebius-grafana/README.md)
- [Ollama](ollama/README.md)
- [Volcano](volcano-volcano/README.md)
- [Clear ML agent](clearml-agent/README.md)

---

## Getting started

### To publish your product

Read [Create application guide](Create-Application-Guide.md)

### To run Application in Managed Service for Kubernetes

1. Sign up at [Nebius](https://nebius.com)
1. Create Managed Service for Kubernetes
1. Select and install Application from the Applications tab

### To run Application in your own Kubernetes

Run:

```bash
helm --kube-context <local-kube-context-name> install <chart-path> [-f values.yaml] -n <namespace> --generate-name --create-namespace
```

## Contributing

We welcome contributions from the community! To contribute:

1. Fork the repository.
1. Create a new branch for your feature or bugfix.
1. Submit a pull request with a detailed explanation of your changes.

## License

This project is licensed under the [Apache License 2.0](LICENSE).

## Support

For support or to report issues, please create an issue in this repository.

---
_Kubernetes® is a registered trademark of The Linux Foundation®_
