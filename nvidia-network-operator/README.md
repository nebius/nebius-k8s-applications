# Nebius package for NVIDIA® Network Operator

## Description

The [NVIDIA® Network Operator](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/cloud-native/containers/network-operator) is an application for Kubernetes designed for managing and optimizing software components for networking between NVIDIA GPUs in the cloud. The operator automates many tasks related to network setup, including the configuration of high-performance networking features like RDMA (Remote Direct Memory Access) and GPUDirect, which are crucial for applications requiring low latency and high throughput. This tool is particularly beneficial for environments where NVIDIA GPUs are deployed for compute-intensive tasks, as it ensures that the network can support the high data transfer demands of such applications.

Your cluster must have a node group attached to a Compute Cloud [GPU cluster](https://docs.nebius.com/compute/clusters/gpu).

## Short description

Optimize GPU networking in Kubernetes with NVIDIA® Network Operator on Nebius AI.

## Tutorial

**Before installing this product:**

1. [Create a GPU cluster](https://docs.nebius.com/compute/clusters/gpu#create-cluster) in Compute.
1. [Create a Kubernetes cluster](https://docs.nebius.com/kubernetes/clusters/manage) and a [node group](https://docs.nebius.com/kubernetes/node-groups/manage) in it. When creating the group, select the created GPU cluster for it.

**To install the product:**

1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage

**To check that the NVIDIA Network Operator is working:**

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure it to work with the created cluster](https://docs.nebius.com/kubernetes/connect).
1. Check that NVIDIA Network Operator pods are running:

   ```bash
   kubectl get pods -n <namespace>
   ```

## Use cases

* Automating management of software components for GPU networking in Kubernetes clusters.
* Building fast infrastructures for high-performance computing (HPC) and AI workloads.

## Links

* [NVIDIA Network Operator documentation](https://docs.nvidia.com/networking/display/cokan10/network+operator)
* [NVIDIA Network Operator in NVIDIA NGC Catalog](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/cloud-native/containers/network-operator)
* [NVIDIA Network Operator on GitHub](https://github.com/Mellanox/network-operator)

## Term of service

* [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0 "additional-first-party-tos")

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [NVIDIA® Network Operator](https://www.apache.org/licenses/LICENSE-2.0).
