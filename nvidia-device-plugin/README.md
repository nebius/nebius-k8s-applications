# Nebius package for NVIDIA® Device Plugin

## Description

[NVIDIA® Device Plugin](https://github.com/NVIDIA/k8s-device-plugin) is automatic node labelling application using [GFD](https://github.com/NVIDIA/gpu-feature-discovery)

## Short description

NVIDIA® Device Plugin automates GPU nodes labeling in Kubernetes clusters.

## Tutorial

1. Click **Install**.

## Usage

**To check that the NVIDIA® Device Plugin is working:**

1. [Install the kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure it to work with the created cluster](https://docs.nebius.com/kubernetes/connect).
1. Check that NVIDIA® Device Plugin pods are running:

   ```bash
   kubectl get pods -n <namespace>
   ```

## Use cases

* Automating management of GPU software components in Kubernetes clusters.
* Scaling GPU deployments in Kubernetes.

## Links

* [NVIDIA® Device Plugin](https://github.com/NVIDIA/k8s-device-plugin)
* [GFD](https://github.com/NVIDIA/gpu-feature-discovery)
* [Using node groups with GPUs](https://docs.nebius.com/kubernetes/gpu/set-up)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [NVIDIA® Device Plugin License](https://github.com/NVIDIA/k8s-device-plugin/blob/main/LICENSE).
