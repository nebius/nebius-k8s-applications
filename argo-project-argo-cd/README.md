# Nebius package for Argo CD

## Description

[Argo CD](https://argo-cd.readthedocs.io/en/stable/) is a declarative, GitOps continuous delivery tool for Kubernetes. It allows you to develop and maintain your Kubernetes application using a declarative approach, and set up automated and auditable deployment and lifecycle management. Argo CD is implemented as a Kubernetes controller that compares the current state of your application with its declared target state, reports and visualizes the differences, and provides facilities to synchronize the states.

## Short description

GitOps tool for declarative, automated Kubernetes app deployment & sync.

## Tutorial

1. Configure the application:
   - Set the admin password (or generate a random one).

1. Click **Install**.

1. Wait for the application to change its status to `Deployed`.

## Usage

After installation, the Argo CD UI is accessible via the tunnel endpoint shown on the product's page in the cloud console.

To log in, use the following credentials:
- Username: `admin`
- Password: The password you set during installation.

If you left the password field empty during installation, Argo CD generates a random password. To retrieve it:

```bash
kubectl -n <namespace> get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Use cases

- Automating deployment of Kubernetes applications.
- Managing multiple Kubernetes clusters at the same time.
- Setting up Git as a source of truth for application configurations.
- Integrating applications with single sign-on (SSO) providers.
- Gathering metrics related to application health, sync history etc.

## Links

- [Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/)
- [Argo CD on GitHub](https://github.com/argoproj/argo-cd)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Argo CD](https://github.com/argoproj/argo-cd/blob/master/LICENSE).
