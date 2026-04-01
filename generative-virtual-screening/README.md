# Generative Virtual Screening

## Description
The NVIDIA Blueprint: Virtual Screening demonstrates a streamlined virtual screening workflow that leverages generative AI and GPU-accelerated NIM microservices to predict protein structures, generate optimized small molecules, and perform protein-ligand docking—built for speed, flexibility, and scientific rigor. This reference framework simplifies deployment via containerized microservices (e.g., MSA-Search, OpenFold2, GenMol, DiffDock), enabling researchers to accelerate the hit-to-lead pipeline with state-of-the-art tools. For more info of the Blueprint, visit the [blueprint card](https://build.nvidia.com/nvidia/generative-virtual-screening-for-drug-discovery/blueprintcard). 

JupyterHub is deployed to enable rapid experimentation, accompanied by a sample Python notebook demonstrating how to use the Blueprint.

## Short description
Accelerating drug discovery with generative AI; smarter, faster, and at scale.

## Use cases

Computational drug designers face the challenge of selecting promising chemical structures from an immense pool. To identify molecules suitable for clinical testing, the process must be highly targeted and efficient. Drug discovery typically begins with identifying a biological target and its mechanism, followed by finding molecules that bind to that target and optimizing them for safety and therapeutic effect. Each step involves uncovering subtle patterns in large datasets and iterating through cycles of biological experiments, chemical synthesis, and validation; making the process complex and resource-intensive.

Generative AI offers a new approach by pre-optimizing molecules and simulating their interactions with target proteins. This NIM Agent Blueprint demonstrates how virtual screening can be transformed using NVIDIA microservices for protein folding, molecule generation, and docking—accelerating development and improving the quality of candidate molecules.

## Links

[NVIDIA BioNeMo Blueprint](https://build.nvidia.com/nvidia/generative-virtual-screening-for-drug-discovery)
[NVIDIA BioNeMo Framework](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/clara/containers/bionemo-framework)
[JupyterHub website](https://jupyter.org/hub)
[JupyterHub on GitHub](https://github.com/jupyterhub/jupyterhub)
[JupyterHub documentation](https://docs.jupyter.org/en/latest/)

## Legal

This application is provided under a bring-your-own-license model. By deploying this application, you represent and warrant that you hold, and will maintain throughout the use of the application, a valid and sufficient NVIDIA AI Enterprise (NVAIE) license. Use of the application without such license is strictly prohibited. If you do not currently possess the required license, please refer to the [documentation page](https://docs.nebius.com/applications/kubernetes/nvidia-blueprint-virtual-screening/licenses) for available options.

By using the items listed below, you agree with the relevant licenses:

| Package            | License |
| ------             | ------ |
|    JupyterHub      |  [BSD-3 Clause](https://github.com/jupyterhub/jupyterhub#BSD-3-Clause-1-ov-file)      |
|    NIM             |  [NVIDIA Software License Agreement](https://www.nvidia.com/en-us/agreements/enterprise-software/nvidia-software-license-agreement/) and [Product-Specific Terms for AI Products](https://www.nvidia.com/en-us/agreements/enterprise-software/product-specific-terms-for-ai-products/)     |
|    MSA-Search      |  [MIT](https://github.com/soedinglab/MMseqs2?tab=MIT-1-ov-file)     |
|    OpenFold2 model |  [NVIDIA Community Model License](https://www.nvidia.com/en-us/agreements/enterprise-software/nvidia-community-models-license/). ADDITIONAL INFORMATION: [Apache 2.0 License](https://choosealicense.com/licenses/apache-2.0/).      |
|    Diffdock model  |  [MIT](https://github.com/gcorso/DiffDock/blob/main/LICENSE)      |
|    GenMol model    |  [NVIDIA Community Model License](https://www.nvidia.com/en-us/agreements/enterprise-software/nvidia-community-models-license/)      |

## Tutorial

{% note info %}
- This application can only be installed on an already existing Kubernetes® cluster. If you already have a cluster, please make sure that your cluster fulfills the pre-requisites, which are described below.
- This application will take around 2-3 hours to be installed and ready.
{% endnote %}

Before installing the application, please ensure that your Kubernetes® cluster is prepared:
* Create a new Managed Service for Kubernetes cluster with the public endpoint enabled.
* Create a node group, with at latest 4 GPUs. 
* Install [NVIDIA® GPU Operator](https://console.eu.nebius.com/applications/overview/nebius/nvidia-gpu-operator) and [NVIDIA® Device Plugin](https://console.eu.nebius.com/applications/overview/nebius/nvidia-device-plugin) on the cluster.

Once you have the cluster ready, install and configure the application:
1. Make sure that you are installing the application on the cluster that has been prepared above.
2. Configure the application:
    1. **NGC API Key**: You can obtain the key by following our [guide](https://docs.nebius.com/applications/kubernetes/nvidia-blueprint-virtual-screening/licenses) 
    2. **Disk Size**: Select a disk size. It needs minimum 2 TB of storage.
    3. **JupyterHub admin password**: Set a password for the JupyterHub admin.
    4. **JupyterHub accessibility**: Select a way to access the JupyterHub cluster:

        * **ClusterIP** for access by port-forwarding.
        * **LoadBalancer** for access from the internet by IP or by port-forwarding.

      {% note warning %}

      LoadBalancer uses one IP address from the [Public IP addresses (allocations) per region](https://docs.nebius.com/vpc/resources/quotas-limits) quota.

      {% endnote %}

3. Click **Deploy application**.
4. Wait for the application to change its status to `Deployed`.

## Usage

Depending on the way to access the cluster you have chosen while configuring the application, get the IP or use port-forwarding to access the JupyterHub UI:

{% list tabs %}

* LoadBalancer

    1. [Install](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure](https://docs.nebius.com/kubernetes/connect) `kubectl`, to get the IP using the following command:

    ```bash
    kubectl describe svc proxy-public -n <namespace> | grep "LoadBalancer Ingress:"
    ```

    1. Go to http://<ip> in your browser. On the login screen, specify the user as `admin` and enter a password that will be saved as the `admin`'s password.

* ClusterIP
    1. Set up port forwarding (you will need to [install](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure](https://docs.nebius.com/kubernetes/connect) `kubectl` for that):

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
