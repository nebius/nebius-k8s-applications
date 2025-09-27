# Nebius package for NVIDIA® GPU Operator

## Description

[NVIDIA® GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/index.html) helps you provision GPUs in Kubernetes clusters. Using the [operator pattern](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) to extend Kubernetes, NVIDIA GPU Operator automatically manages the components needed to provision GPUs, such as the NVIDIA drivers (to enable CUDA), Kubernetes device plugin for GPUs, the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker), automatic node labelling using [GFD](https://github.com/NVIDIA/gpu-feature-discovery), [DCGM](https://developer.nvidia.com/dcgm) based monitoring and others.

## Short description

NVIDIA® GPU Operator automates GPU setup in Kubernetes clusters.

## Tutorial

1. Configure the application:

   * **RDMA**: Select this option to enable GPUDirect RDMA and boost the data exchange speed between GPUs. It is recommended to select the option.

1. Click **Install**.

## Usage

**To check that the NVIDIA GPU Operator is working:**

1. [Install the kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/#kubectl-connect).
1. Check that NVIDIA GPU Operator pods are running:

   ```bash
   kubectl get pods -n <namespace>
   ```

## Use cases

* Automating management of GPU software components in Kubernetes clusters.
* Scaling GPU deployments in Kubernetes.

## Links

* [NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/index.html)
* [Using node groups with GPUs](https://nebius.ai/docs/managed-kubernetes/tutorials/driverless-gpu)

## Term of service

* [NVIDIA GPU Operator Licenses](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/index.html#licenses-and-contributing "additional-first-party-tos")

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [NVIDIA GPU Operator Licenses](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/index.html#licenses-and-contributing).
