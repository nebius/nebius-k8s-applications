# Nebius package for Jupyterhub

## Description

[JupyterHub](https://jupyter.org/hub) is a multi-user server for Jupyter notebooks, providing a collaborative environment for data science, machine learning, and scientific computing. This Kubernetes-compatible application includes PyTorch, a popular deep learning framework, and CUDA support for GPU acceleration. JupyterHub allows organizations to serve computational environments to multiple users, making it ideal for teams, academic courses, and research labs. PyTorch enables efficient tensor computations and dynamic neural networks, while CUDA support leverages NVIDIA GPUs for accelerated computing. You can deploy JupyterHub with PyTorch and CUDA in your Nebius AI [Managed Service for Kubernetes](https://nebius.ai/services/managed-kubernetes) clusters.

## Short description

Multi-user JupyterHub with PyTorch & CUDA, deployable on Kubernetes.

## Use cases

* Data preprocessing and exploration for machine learning projects
* Collaborative research in academic and scientific environments
* Training and fine-tuning deep learning models using PyTorch
* Accelerated computing tasks using NVIDIA GPUs
* Interactive coding and visualization for data analysis
* Educational purposes, such as teaching programming or data science courses
* Prototyping and experimenting with machine learning algorithms
* Sharing and reproducing research results in computational sciences
* Running distributed machine learning workloads across multiple nodes
* Developing and testing AI applications in a scalable environment

## Links

[JupyterHub website](https://jupyter.org/hub)
[JupyterHub on GitHub](https://github.com/jupyterhub/jupyterhub)
[JupyterHub documentation](https://docs.jupyter.org/en/latest/)
[PyTorch website](https://pytorch.org/)
[PyTorch documentation](https://pytorch.org/docs/stable/index.html)
[NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Jupyter Hub](https://jupyter.org/governance/projectlicense.html), [CUDA Toolkit](https://docs.nvidia.com/cuda/eula/index.html) and [PyTorch](https://github.com/pytorch/pytorch?tab=License-1-ov-file).

## Tutorial

{% note info %}

Each node in the group should have at least 8 GB of RAM.

To use GPU create GPU node group and install [NVIDIA® GPU Operator](https://console.eu.nebius.com/applications/overview/nebius/nvidia-gpu-operator)

{% endnote %}

**Install and configure the product:**

1. Configure the application:

    1. **JupyterHub accessibility**: Select a way to access the JupyterHub cluster:

        * **ClusterIP** for access by port-forwarding.
        * **LoadBalancer** for access from the Internet by IP or by port-forwarding.

      {% note warning %}

      LoadBalancer uses one IP address from the [Number of public IP addresses per cloud](https://nebius.ai/docs/overview/concepts/quotas-limits#vpc-quotas) quota.

      {% endnote %}

1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage

Depending on the way to access the cluster you have chosen while configuring the application, get the IP or use port-forwarding to access the JupyterHub UI:

{% list tabs %}

* LoadBalancer

    1. [Install](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure](https://nebius.ai/docs/managed-kubernetes/operations/connect/#kubectl-connect) `kubectl`, to get the IP using the following command:

    ```bash
    kubectl describe svc proxy-public -n <namespace> | grep "LoadBalancer Ingress:"
    ```

    1. Go to `http://<ip>` in your browser. On the login screen, specify the user as `admin` and enter a password that will be saved as the `admin`'s password.

* ClusterIP

    1. Set up port forwarding (you will need to [install](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure](https://nebius.ai/docs/managed-kubernetes/operations/connect/#kubectl-connect) `kubectl` for that):

       ```bash
       kubectl --namespace=<namespace> port-forward service/proxy-public 8080:http
       ```

    1. Go to <http://localhost:8080> in your browser. On the login screen, specify the user as `admin` and enter a password that will be saved as the `admin`'s password.

{% endlist %}

To create and manage users in JupyterHub:

1. In the top menu, click **File** → **Hub Control Panel**.
1. Click **Admin**.
1. Click **Add Users**.
1. Enter usernames, one per line. To make the new users admins and allow them to manage users, select the **Admin** checkbox.
1. Click **Add Users**.

When adding users, you will not create passwords for them. A new user creates their password themselves when they first log into JupyterHub.
