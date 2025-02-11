# Nebius package for Grafana Loki

## Description
[Grafana Loki](https://grafana.com/oss/loki/) is a horizontally scalable, highly available, multi-tenant log aggregation system. It supports a wide range of log formats, sources, and clients, and allows formatting logs at query time rather than at ingestion. Loki only indexes the metadata of a log line which significantly reduces space required to store logs and makes working with them simpler and faster. Integrations with Prometheus, Grafana, and Kubernetes are supported natively, providing a one-stop-shop UI for metrics, logs, and traces.


## Short description
Scalable, highly available log aggregation system in your Kubernetes cluster. Deploy Grafana Loki in Nebius AI.


## Use cases
Aggregating and storing logs.


## Links
* [Grafana Loki](https://grafana.com/oss/loki/)
* [Grafana Loki documentation](https://grafana.com/docs/loki/latest/)
* [Grafana Loki on GitHub](https://github.com/grafana/loki)

## Legal
* [AGPLv3](https://github.com/grafana/loki/blob/main/LICENSE "additional-third-party-tos")
* [Nebius AI Marketplace Terms of Service](https://nebius.ai/docs/legal/marketplace-terms "default-tos")


## Tutorial
Before installing this product:

1. Configure storage:

   1. [Create a service account](https://docs.nebius.com/iam/service-accounts/manage) and [assign](https://docs.nebius.com/iam/authorization/groups) the `storage.editor` roles to it.
   1. [Create a static access key](https://docs.nebius.com/iam/service-accounts/access-keys) for the service account.
   1. [Create an Object Storage bucket](https://docs.nebius.com/object-storage) for chunks and ruler with following template `<bucketPrefix>-chunks` `<bucketPrefix>-ruler`.

To install the product:

1. Configure the application:
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage
1. To check that Grafana Loki is working, check that its pods are running:

   ```bash
   kubectl get pods -n <namespace> | grep 'loki'
   ```
1. After product is deployed you can access logs via Grafana and Prometheus dashboard.
