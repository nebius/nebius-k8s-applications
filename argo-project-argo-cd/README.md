## Description

[Argo CD](https://argo-cd.readthedocs.io/en/stable/) is a declarative, GitOps continuous delivery tool for Kubernetes. It allows you to develop and maintain your Kubernetes application using a declarative approach, and set up automated and auditable deployment and lifecycle management. Argo CD is implemented as a Kubernetes controller that compares the current state of your application with its declared target state, reports and visualizes the differences, and provides facilities to synchronize the states.

## Short description

GitOps tool for declarative, automated Kubernetes app deployment & sync.

## Use cases

- Automating deployment of Kubernetes applications.
- Managing multiple Kubernetes clusters at the same time
- Setting up Git as a source of truth for application configurations.
- Integrating applications with single sign-on (SSO) providers.
- Gathering metrics related to application health, sync history etc.

## Links

- [Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/)
- [Argo CD on GitHub](https://github.com/argoproj/argo-cd)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Argo CD](https://github.com/argoproj/argo-cd/blob/master/LICENSE).

## Tutorial

1. Configure the application.

1. Click **Install**.

1. Wait for the application to change its status to `Deployed`.

## Usage

1. [Install the kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/#kubectl-connect).

1. To access the Argo CD UI:

   1. Get the administrator’s password:

      ```bash

      kubectl --namespace <namespace> get secret argocd-initial-admin-secret \

        --output jsonpath="{.data.password}" | base64 -d

      ```

   1. Set up port forwarding:

      ```bash

      kubectl port-forward service/<application_name>-argocd-server \

        --namespace <namespace> 8080:443

      ```

   1. Go to [http://localhost:8080](http://localhost:8080){target="\_blank"} and use the following credentials to log in:

      - Username: `admin`.

      - Password: The administrator's password you obtained earlier.
