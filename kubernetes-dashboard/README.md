## Description
Kubernetes Dashboard is a web-based UI for conveniently inspecting the state of your Kubernetes cluster.  
This package deploys the Dashboard together with an automatically created **ServiceAccount** that is granted the built-in **`view`** (read-only) ClusterRole, **with additional permissions to view Nodes, StorageClasses, and PersistentVolumes**.
Key features:
- **Automatic authentication**: a ServiceAccount is created during installation and used for seamless login to the Dashboard.
- **Secure token rotation**: the authentication token is regenerated automatically every hour.
- **Read-only access**: the `view` role allows inspection of most cluster resources but **does not provide access** to:
    - Secrets
    - Role and RoleBinding
    - ClusterRole and ClusterRoleBinding
    - ServiceAccount tokens and TokenRequest
    - Any objects requiring elevated privileges

This makes the Dashboard safe to use: you can explore resources and their state without the risk of accidental modifications or exposure of sensitive data.

After installation, a direct link to the Dashboard will be available on the product’s page in the cloud console.

## Short description
Kubernetes Dashboard with automatic read-only access setup via ServiceAccount

## Tutorial
This is a standard installation that requires no configuration.  
Simply install the product and start using the Kubernetes Dashboard.

## Usage
For convenient access to the UI, create an Endpoint link in the **Endpoints** block and open it to launch the Dashboard.

## Use cases

- **Monitor cluster resources** – view Nodes, Pods, Deployments, Services (including IP addresses), and more.
- **Check workload status** – inspect the state of running Pods, ReplicaSets, and Jobs.
- **View events** – track cluster events to understand what’s happening in real-time.
- **Inspect configurations** – review ConfigMaps, PersistentVolumeClaims, and other non-sensitive objects.
- **Troubleshoot issues safely** – debug and explore resources without risk of modifying sensitive data.

## Support

## Links

## Term of service

## Legal

