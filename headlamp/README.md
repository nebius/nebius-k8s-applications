## Description

[Headlamp](https://headlamp.dev/) is a modern, extensible Kubernetes web UI. It provides a clean interface for exploring and managing your cluster resources, with plugin support for customization.

Key features:
- **Modern UI**: Clean, responsive interface for navigating cluster resources
- **Plugin system**: Extend functionality with community and custom plugins
- **In-cluster deployment**: Runs inside the cluster with automatic service account authentication
- **Multi-cluster support**: Connect and switch between multiple clusters
- **Resource management**: View and edit Pods, Deployments, Services, ConfigMaps, and more
- **Terminal access**: Open a terminal session to running containers
- **Log viewer**: Stream and search container logs

This is the recommended replacement for the deprecated Kubernetes Dashboard.

## Short description

A modern, extensible Kubernetes web UI with plugin support.

## Tutorial

This is a standard installation that requires no configuration.
Simply install the product and start using Headlamp.

After installation, the Headlamp UI will be accessible via the tunnel endpoint shown on the product's page in the cloud console.

## Usage

Open the tunnel endpoint URL to access the Headlamp UI. The application runs with a cluster-admin service account, providing full read/write access to cluster resources.

## Use cases

- **Monitor cluster resources** — view Nodes, Pods, Deployments, Services, and more with a modern interface
- **Manage workloads** — create, edit, and delete Kubernetes resources directly from the UI
- **Troubleshoot issues** — access container logs, open terminal sessions, and inspect resource events
- **Explore cluster state** — navigate namespaces, check resource usage, and view configurations
- **Extend with plugins** — install plugins to add custom views, actions, and integrations

## Links

- [Headlamp website](https://headlamp.dev/)
- [Headlamp on GitHub](https://github.com/kubernetes-sigs/headlamp)
- [Headlamp documentation](https://headlamp.dev/docs/latest/)
- [Plugin catalog](https://headlamp.dev/docs/latest/development/plugins/)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Headlamp](https://github.com/kubernetes-sigs/headlamp/blob/main/LICENSE).
