# Nebius package for H2O-3

## Description

H2O is an open-source, in-memory, distributed platform for machine learning and predictive analytics on big data. Built with speed and scalability in mind, H2O enables you to effortlessly build and deploy high-quality models in an enterprise environment. H2O’s core code, written in Java, leverages a distributed key/value store and a distributed MapReduce framework for seamless data access and processing across nodes. With intelligent data parsing and support for multiple formats, H2O simplifies data ingestion from various sources.

## Short description

A distributed, in-memory machine learning and predictive analytics platform.

## Use cases

- Financial services: credit scoring, personalized offers, customer churn, anti-money laundering, trading strategies.

- Healthcare: clinical workflow, capacity simulation, diagnosis assistance, infectious disease forecasting, pricing, claims assessment.

- Insurance: fraud detection and mitigation, claims management, personalized rate management and product bundling.

- Manufacturing: predictive design and maintenance, transportation optimization.

- Marketing: audience segmentation, content personalization, next best offer and next best action.

- Retail: assortment and price optimization.

- Telecom: customer support, fleet maintenance.

## Links

- [H2O.ai website](https://h2o.ai/)
- [H2O.ai use cases](https://h2o.ai/solutions/use-case/)
- [H2O-3 documentation](https://docs.h2o.ai/h2o-3/index.html)
- [H2O-3 source code on GitHub](https://github.com/h2oai/h2o-3)
- [H2O tutorials and learning materials on GitHub](https://github.com/h2oai/h2o-tutorials)
- [H2O.ai security bulletins](https://h2o.ai/security/bulletins/)
- [H2O.ai customer support portal](https://support.h2o.ai/support/home)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0 "default-tos").

## Tutorial

{% note warning %}

If you want to use H2O-3 with GPUs and have them in your node group, install the [NVIDIA® GPU Operator](https://console.eu.nebius.com/applications/overview/nebius/nvidia-gpu-operator) on the cluster.

{% endnote %}

Before installing this product:

1. [Create a Kubernetes cluster](https://nebius.ai/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create) and a [node group](https://nebius.ai/docs/managed-kubernetes/operations/node-group/node-group-create) in it.
1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl), and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect).

To install the product:

1. Click **Install**.
2. Wait for the application to change its status to `Deployed`.

## Usage

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect)
1. To check that H2O-3 is working, launch [H2O Flow](https://docs.h2o.ai/h2o/latest-stable/h2o-docs/flow.html), the H2O-3 user interface:

    1. Configure port forwarding:

        ```bash
        kubectl port-forward <application-name>-0 8080:54321 -n <namespace>
        ```

    1. Go to [http://localhost:8080](http://localhost:8080) in your web browser.
