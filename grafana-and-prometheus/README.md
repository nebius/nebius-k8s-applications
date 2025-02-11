# Nebius package for Grafana and Prometheus

## Description

Grafana® is a data monitoring, analysis and visualization platform. It provides a tailored and customizable way to build context-rich visualization through charts and other methods of presenting data, which makes it suitable for the needs of a specific software development project. Dashboards in Grafana give insightful meaning to the data collected, helping to understand your data. With Grafana you can create, explore and share all of your data with team members through beautiful, flexible dashboards. The platform can be connected to Graphite, OpenTSDB, InfluxDB, MySQL, PostgreSQL and many other engines.

Prometheus is an open-source system monitoring and alerting toolkit, which collects and stores its metrics as time series data. Metrics information is stored with the corresponding timestamp, together with optional key-value pairs called labels. It is a multi-dimensional data model with time series data identified by metric name and key/value pairs. PromQL, a flexible query language, allows to leverage this dimensionality. Prometheus uses pull model to collect time series over HTTP and targets are discovered via service discovery or static configuration.

Grafana provides out-of-the-box support for Prometheus which allows users to import Prometheus performance metrics as a data source, and render and visualize them as graphs and dashboards. This image provides both these products.

## Short description

The platform and the tool to collect, monitor and analyze cluster performance metrics and build context-rich visualizations.

## Use cases

* Collecting, storing, checking and querying purely numeric time series metrics.
* Context-rich data monitoring, alerting, analysing and visualizing with flexible dashboards that support heatmaps, graphs, tables and free text panel types.

## Links

* [Grafana website](https://grafana.com/)

* [Grafana documentation](https://grafana.com/docs/grafana/latest/)
* [Get started with Grafana and Prometheus – Grafana documentation](https://grafana.com/docs/grafana/latest/getting-started/get-started-grafana-prometheus/)
* [Prometheus website](https://prometheus.io/)
* [Prometheus documentation](https://prometheus.io/docs/introduction/overview/)
* [Grafana support for Prometheus – Prometheus documentation](https://prometheus.io/docs/visualization/grafana/)
* [Grafana source code](https://github.com/grafana/grafana)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Grafana](https://github.com/grafana/helm-charts/blob/main/LICENSE) and [Prometheus](https://github.com/prometheus-community/helm-charts/blob/main/LICENSE).

## Tutorial

Before installing this product:

To install the product:

1. Configure the application:
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage

To check that Grafana and Prometheus for Kubernetes is working, access its UI:

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect).
1. Set up port forwarding:

   ```bash
   kubectl port-forward service/<application-name>-grafana 3000:80 -n <namespace>
   ```

1. Go to <http://localhost:3000> in your browser and login with the user “admin” and the password specified in the **Grafana admin password**.
