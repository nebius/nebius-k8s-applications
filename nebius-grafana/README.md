# Grafana® solution by Nebius

## Description

[Grafana®](https://grafana.com/) is a data monitoring, analysis and visualization platform. It provides a customizable way to build context-rich visualizations through charts and other methods of presenting data, which makes it suitable for the needs of a specific software development project.

Dashboards in Grafana give insightful meaning to collected data, helping teams better understand it. With Grafana, you can create, explore and share all your data with team members through beautiful, flexible dashboards.

By default, the Nebius Grafana solution comes with pre-installed dashboards and data sources to display the data collected from Nebius services. These data sources allow you to work with Nebius Monitoring and Nebius Logging services.

## Short description

The platform and the tool to collect, monitor and analyze cluster performance metrics and build context-rich visualizations.

## Use cases

Context-rich data monitoring, alerting, analysis and visualization with flexible dashboards that support heatmaps, graphs, tables and free-text panel types.

## Legal

By using the application, you agree to the terms and conditions of the [Helm chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Grafana](https://github.com/grafana/helm-charts/blob/main/LICENSE) and [Prometheus](https://github.com/prometheus-community/helm-charts/blob/main/LICENSE).

## Tutorial

Before installing this product, select or create a Kubernetes cluster.

To install the product:

1. Configure the application:
   1. To get your **Nebius project ID**, expand the tenant list in the top-left corner. Next to your project name, click ... → Copy project ID.
   1. To get a **Nebius access token**:
      1. [Create a service account](https://console.eu.nebius.com/iam/service-accounts) and ensure it is assigned to at least the [Viewer group](https://docs.nebius.com/iam/authorization/groups) to grant read access to the data.
      1. Copy its ID.
      1. [Install Nebius AI Cloud CLI](https://docs.nebius.com/cli/quickstart).
      1. Run the following command:
      ```
      nebius iam static-key issue \
        --account-service-account-id <service_account_ID> \
        --service observability --parent-id <project_ID>
      ```
1. Click **Deploy**.
1. Wait for the application to change its status to `Deployed`.
