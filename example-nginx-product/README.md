# Nebius package for Nginx

## Description

nginx is a high-performance web server, reverse proxy and load balancer, designed to handle large numbers of concurrent connections with low memory usage. It is widely used to serve dynamic and static content and to optimize traffic distribution in complex web applications.

## Short description

Open-source web server and reverse proxy

## Tutorial

{% note warning %}

This application exposes nginx as a `LoadBalancer` service with a public IP address. While your cluster is running, you will be charged for using this IP address. For details, see [Pricing in Managed Service for Kubernetes®](https://docs.nebius.com/kubernetes/resources/pricing/).

{% endnote %}

**Before installing this application:**

1. [Create a Kubernetes cluster](https://docs.nebius.com/kubernetes/clusters/manage/) and a [node group](https://docs.nebius.com/kubernetes/node-groups/manage/) in it.

**To install the application:**

1. Click **Install application**
1. Wait until the application changes its status to `Deployed`.

## Usage

**Connect to the application:**
{% list tabs %}

- Using port forwarding

    1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) if you haven't already.
    1. [Connect to your cluster using kubectl](https://docs.nebius.com/kubernetes/connect/).
    1. Set up port forwarding:

        ```bash
        kubectl --namespace=<namespace> port-forward service/proxy-public 8080:http
        ```

    1. Go to <http://localhost:8080> in your browser.

- Using service IP address
    1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) if you haven't already.
    1. [Connect to your cluster using kubectl](https://docs.nebius.com/kubernetes/connect/).
    1. Get the public IP address of the `nginx` service:

       ```bash
        kubectl describe svc nginx -n <namespace> | grep "LoadBalancer Ingress:"
       ```

    1. Go to `http://<ip_address>` in your browser.

{% endlist %}

## Use cases

- Serving static content.
- Load balancing.
- Reverse proxy.

## Links

[nginx documentation](https://nginx.org/en/docs/index.html)
[nginx on GitHub](https://github.com/nginx/nginx)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Nginx](https://nginx.org/LICENSE).
