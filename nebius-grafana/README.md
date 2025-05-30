# Grafana® solution by Nebius

## Description

[Grafana®](https://grafana.com/) is a data monitoring, analysis and visualization platform. It provides a customizable way to build context-rich visualizations through charts and other methods of presenting data, which makes it suitable for the needs of a specific software development project.

Dashboards in Grafana give insightful meaning to collected data, helping teams better understand it. With Grafana, you can create, explore and share all your data with team members through beautiful, flexible dashboards.

By default, the Nebius Grafana solution comes with pre-installed dashboards and data sources to display the data collected from Nebius services. These data sources allow you to work with Nebius Monitoring and Nebius Logging services.

## Short description

A ready-to-use solution to work with Nebius Monitoring and Logging services

## Use cases

Context-rich data monitoring, alerting, analysis and visualization with flexible dashboards that support heatmaps, graphs, tables and free-text panel types.

## Links

* [Grafana website](https://grafana.com/)
* [Nebius Monitoring](https://docs.nebius.com/observability/monitoring)
* [Nebius Logging](https://docs.nebius.com/observability/logging)
* [Nebius Dashboards for Grafana®](https://grafana.com/grafana/dashboards/?search=nebius)
* [Grafana® Documentation](https://grafana.com/docs/grafana/latest/)
* [PromQL Documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/)
* [LogQL documentation](https://grafana.com/docs/loki/latest/query/)

## Legal

By using the application, you agree to the terms and conditions of the [Helm chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Grafana](https://github.com/grafana/helm-charts/blob/main/LICENSE) and [Prometheus](https://github.com/prometheus-community/helm-charts/blob/main/LICENSE).

## Tutorial

To install the product:

1. Configure the application settings.
1. Click **Deploy**.

## Usage

To verify that Grafana® solution by Nebius is working with Kubernetes, access its UI:

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure it to work with the created cluster](https://docs.nebius.com/kubernetes/connect).
1. Set up port forwarding:
    ```bash
    kubectl port-forward service/<application-name> 3000:80 -n <namespace>
    ```
1. Log in [http://localhost:3000](http://localhost:3000) using the username **admin** and the Grafana admin password configured earlier.
