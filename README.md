# Nebius Kubernetes applications library of helm charts

Welcome to the **Nebius Kubernetes Applications** repository! This repository contains the configuration, manifests and Helm charts for deploying and managing Nebius' Kubernetes applications.

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

This repository serves as a central hub for managing and deploying Kubernetes applications built for the Nebius platform. These applications are designed to ensure high availability, scalability and seamless integration with the Nebius ecosystem.

---

## Applications

- [NVIDIA® GPU Operator](nvidia-gpu-operator/README.md)
- [NVIDIA® Network Operator](nvidia-netwrok-operator/README.md)
- [Ray Cluster](ray-cluster/README.md)

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
1.Fork the repository.
1.Create a new branch for your feature or bugfix.
1.Submit a pull request with a detailed explanation of your changes.

## License

This project is licensed under the [Apache License 2.0](LICENSE).

## Support

For support or to report issues, please create an issue in this repository.
