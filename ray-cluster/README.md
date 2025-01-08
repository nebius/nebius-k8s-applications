# Nebius package for Ray cluster

## Description

[Ray](https://docs.ray.io/en/latest/ray-overview/index.html) is an open-source distributed computing framework built for the deployment and orchestration of scalable distributed computing environments for a variety of large-scale AI workloads. Ray Cluster provides a robust infrastructure for training complex machine learning models and running reinforcement learning algorithms at scale. Leveraging Kubernetes orchestration capabilities, Ray Cluster simplifies the deployment process, allowing users to efficiently allocate resources and manage workloads across clusters. With support for distributed execution and parallelism, Ray Cluster optimizes resource utilization and accelerates model training, enabling faster iteration and experimentation in AI research and development.

{% note warning %}

   Before installing Ray Cluster, you must install `NVIDIA® GPU Operator` on the cluster.

{% endnote %}

## Short description

Ray simplifies scalable AI workload deployment with Kubernetes orchestration.

## Tutorial

**Before installing this product:**

   1. [Create a node group](https://nebius.ai/docs/managed-kubernetes/operations/node-group/node-group-create) with GPUs in it. The product supports the following [VM platforms](https://nebius.ai/docs/compute/concepts/vm-platforms) with GPUs:

      * NVIDIA® H100 NVLink with Intel Sapphire Rapids

      {% note info %}

         It is strongly recommended that each node has at least 4 vCPUs and 8 GB of RAM.

      {% endnote %}

**To install the product:**

   1. Configure the application:

      {% note info %}

         It is stronly recommended to keep the default values for the [head pod](https://docs.ray.io/en/latest/cluster/kubernetes/user-guides/config.html#pod-configuration-headgroupspec-and-workergroupspecs) and worker pods without GPUs so that it takes up an entire node.
         For more details, see the [Ray documentation](https://docs.ray.io/en/latest/cluster/kubernetes/user-guides/config.html#resources).

      {% endnote %}

   1. Click **Install**.
   1. Wait for the application to change its status to `Deployed`.

## Usage

**To check that Ray is working:**

   1. Set up port forwarding:

      ```bash
      kubectl -n <namespace> port-forward \
        services/<application_name>-kuberay-head-svc 8265:8265
      ```

   1. Go to [http://localhost:8265/](http://localhost:8265/) in your web browser.

## Use cases

* Reinforcement learning research and development.
* Distributed model training for deep learning applications.
* High-performance computing for scientific simulations and data analysis.
* Large-scale data processing and analytics.
* Experimentation with parallel algorithms and distributed systems.
* Development and deployment of AI-powered applications in production environments.

## Links

* [Ray website](https://www.ray.io/)
* [Ray documentation](https://docs.ray.io/en/latest/index.html)
* [Ray on GitHub](https://github.com/ray-project/ray)
* [KubeRay on GitHub](https://github.com/ray-project/kuberay)

## Term of service

* [Apache 2.0](https://github.com/ray-project/kuberay/blob/master/LICENSE "additional-third-party-tos")

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [KubeRay](https://github.com/ray-project/kuberay/blob/master/LICENSE).
