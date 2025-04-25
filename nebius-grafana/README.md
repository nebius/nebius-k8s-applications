# Nebius Grafana solution 

## Description

Grafana® is a data monitoring, analysis and visualization platform. It provides a tailored and customizable way to build context-rich visualization through charts and other methods of presenting data, which makes it suitable for the needs of a specific software development project. Dashboards in Grafana give insightful meaning to the data collected, helping to understand your data. With Grafana you can create, explore and share all of your data with team members through beautiful, flexible dashboards. 
By default, Nebius Grafana solution comes with pre-installed dashboards and data sources to display data collected from Nebius services.
With data sources it's possible to work with Nebius Monitoring and Nebius Logging services. 

## Short description

The platform and the tool to collect, monitor and analyze cluster performance metrics and build context-rich visualizations.

## Use cases

Context-rich data monitoring, alerting, analysing and visualizing with flexible dashboards that support heatmaps, graphs, tables and free text panel types.

## Links

* [Grafana website](https://grafana.com/)
* [Nebius Monitoring documentation](TODO: links)
* [Nebius Logging documentation](TODO: links)
* [Nebius Service Provider Dashboards](TODO: links from https://grafana.com/grafana/dashboards/)

* [Grafana documentation](https://grafana.com/docs/grafana/latest/)
* [PromQL documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/)
* [LogQL documentation](https://grafana.com/docs/loki/latest/query/)
* [Grafana Alerting documentation](https://grafana.com/docs/grafana/latest/alerting/)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Grafana](https://github.com/grafana/helm-charts/blob/main/LICENSE) and [Prometheus](https://github.com/prometheus-community/helm-charts/blob/main/LICENSE).

## Tutorial

Before installing this product:

To install the product:

1. Configure the application:
   1. To get *Nebius Project ID* you can expand the top-left tenants list. Next to the Peoject's name, click ... → Copy project ID
   1. To obtain *Nebius Access Token*:
      1. Create [Service account](https://console.eu.nebius.com/iam/service-accounts)
      1. Install [Nebius cli](https://docs.nebius.com/cli/quickstart)
      1. Run `nebius iam static-key issue --account-service-account-id {SERVICE_ACCOUNT_ID} --service observability  --parent-id {PROJECT_ID}`
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage

To check that Nebius Grafana solution for Kubernetes is working, access its UI:

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect).
1. Set up port forwarding:

   ```bash
   kubectl port-forward service/<application-name>-grafana 3000:80 -n <namespace>
   ```

1. Go to <http://localhost:3000> in your browser and login with the user “admin” and the password specified in the **Grafana admin password**.
