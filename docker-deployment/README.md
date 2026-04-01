# Nebius package for Custom Docker Containers

## Description
With **Custom Docker Containers**, you can easily deploy your own Docker containers into a managed Kubernetes cluster without writing YAML manifests by hand.

When you launch a product, the following Kubernetes resources will be created automatically:
- **Deployment** – runs your containers (including init containers, if specified).
- **Service** – created for exposed ports (either `LoadBalancer` or `ClusterIP` or both).
- **PersistentVolumeClaim (PVC)** – created if storage is requested.
- **emptyDir** – used automatically if you choose ephemeral storage.
- **ConfigMap** – used to provide files you specify through the interface.
- **Secrets** – store registry credentials if you use private container images.
- **CronJob** – optional: stops the deployment automatically (downscale or removal) if you configure auto-shutdown.

### Key features
- **Multiple containers per deployment** – define one or more containers within a single deployment.
- **Init containers** – run initialization logic before the main containers start.
- **Resources** – configure CPU, memory and GPU requests/limits to fit your workload.
- **Networking** – expose container ports with `LoadBalancer` or `ClusterIP`.
    - For `ClusterIP`, an auto-generated link to the container’s UI will appear in the product card.
- **Commands, arguments, environment variables** – full control over runtime execution.
- **Storage** – attach `PersistentVolumeClaim` (PVC) or `emptyDir` to your containers.
    - Create one or more files using the built-in editor; these files will be automatically available inside containers at startup.
- **Auto-shutdown policy** – define time-based rules to either downscale to zero or delete the deployment automatically.
- **Other options** – set replica count and node selectors for advanced placement.

### Why it matters
This product is useful for anyone who needs flexibility in running their own workloads. It helps to:

- Launch and adjust custom docker containers without writing Kubernetes manifests manually.
- Allocate GPUs, memory, and CPUs for experiments or services.
- Deploy tools, dashboards, or lightweight services in a straightforward way.
- Package code and dependencies into a container and reproduce results consistently.

Custom Docker Containers reduces the overhead of Kubernetes setup while still allowing control over important runtime parameters.


## Short description
Run any containers in your managed Kubernetes cluster with full flexibility.

## Tutorial

Here are some tips to help you configure your **Custom Docker Containers** product:

- **Storage & Files**  
  Any storage you attach (PVC or `emptyDir`) will be mounted into **all containers**, including init containers. Files you provided will also be available inside every container at startup.

- **Ports & Networking**  
  For `ClusterIP` ports, convenient access links can be generated in the **Endpoints** section after deployment. `LoadBalancer` ports will be exposed externally as usual.

- **Resources & Environment**  
  Set CPU, memory, and GPU requests/limits according to your workload. Environment variables, commands, and arguments will be applied to all containers as specified.

- **Auto-shutdown**  
  If you configure an auto-shutdown schedule, the deployment will scale down or be removed automatically when the time is reached. This helps avoid leaving idle workloads running.

## Usage

Once your **Custom Docker Containers** product is deployed, you can interact with it as follows:

- **Accessing services**  
  If you exposed ports with type `ClusterIP`, you can generate convenient access links in the **Endpoints** section on the right side of the product page.

- **Kubernetes resources**  
  The Deployment, Pods, Services, PVCs, ConfigMaps, Secrets, and any other resources are created in the Kubernetes cluster under the namespace you specified. You can inspect, modify, or monitor them directly using your Kubernetes tools.

- **Managing storage and files**  
  Any files you added to the storage are mounted inside the containers and available at runtime.

- **Auto-shutdown**  
  If you configured auto-shutdown, the Deployment will either scale down or be removed automatically according to the schedule you set.


## Use cases
- **ML model experimentation**
Launch a container with frameworks like PyTorch or TensorFlow, request a GPU, and attach storage with Python scripts. Run training or inference directly inside the cluster without extra setup.

- **Data science tools**
Deploy Jupyter Notebook or a dashboard container. Mount persistent storage for notebooks and data files, so results are kept between restarts.

- **Custom APIs and microservices**
Package your REST or gRPC service in a container, expose ports with LoadBalancer or ClusterIP, and instantly get a working endpoint or auto-generated link to the UI.

- **CI/CD test environments**
Spin up containers with custom commands and environment variables for integration or end-to-end tests. Auto-shutdown policies help clean up environments automatically after a set time.

- **One-off jobs and pipelines**
Use init containers to prepare data or dependencies, then run the main workload. For example, preload a model into storage in an init container, and let the main container serve it.

## Links

## Term of service

## Legal
