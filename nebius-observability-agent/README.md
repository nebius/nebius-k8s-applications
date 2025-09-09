# Nebius observability agent for Kubernetes

## Description

Nebius Observability Agent for Kubernetes is a Helm chart developed and maintained by Nebius AI Cloud, specifically designed for Managed Service for Kubernetes® clusters. The agent provides comprehensive observability capabilities with minimal configuration overhead and tight integration with Nebius AI Cloud infrastructure.

Nebius Observability Agent provides:

* Out-of-the-box metrics collection with minimal configuration
* Built-in metric enrichment (e.g., adds cluster ID and other metadata)
* High reliability and tight integration with Nebius AI Cloud
* Unified observability agent that can collect both logs and metrics

The agent collects various types of telemetry data including system and application metrics, infrastructure monitoring data, performance statistics, and health status information. **All collected logs are automatically stored in Nebius AI Cloud Logging service, while metrics are stored in Nebius AI Cloud Monitoring**, providing centralized observability for your entire Kubernetes environment. This observability data is crucial for maintaining cluster health, troubleshooting issues, and optimizing resource utilization in your Nebius Cloud environment.

## Short description

A unified observability agent for Kubernetes clusters that provides comprehensive telemetry collection with built-in Nebius Cloud integration.

## Use cases

* Collecting logs from application workloads and storing them in Nebius AI Cloud Logging service for centralized analysis
* Collecting metrics from application workloads and storing them in Nebius AI Cloud Monitoring for performance tracking

## Links

* [Nebius Observability Agent Documentation](https://docs.nebius.com/observability/agents/nebius-observability-agent-for-kubernetes)
* [Nebius Cloud Documentation](https://nebius.com/docs/)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE).

## Tutorial

The Nebius Observability Agent is a comprehensive monitoring solution that automatically collects logs and metrics from your Kubernetes cluster and sends them to Nebius AI Cloud services. This enables centralized observability, alerting, and analysis of your cluster's health and performance without requiring complex manual configuration.

Before installing this product:

* Ensure you have access to a Managed Service for Kubernetes cluster

To install the product:

1. Configure the application using the form or create a custom values.yaml file. For detailed configuration options, see the [Nebius Observability Agent Configuration Documentation](https://docs.nebius.com/observability/agents/nebius-o11y-agent#configuration)
2. Click **Deploy application**
3. Wait for the application to change its status to `Deployed`

## Usage

To check that Nebius Observability Agent is working:

1. [Connect to your Managed Service for Kubernetes cluster](https://docs.nebius.com/kubernetes/connect)

2. Check the agent pods status:

   ```bash
   kubectl get pods --namespace nebius-observability-agent
   ```

3. View agent logs to verify operation:

   ```bash
   kubectl logs -l app.kubernetes.io/name=nebius-observability-agent-helm  --namespace nebius-observability-agent
   ```

## Configuration

### Basic configuration

You can customize the Nebius Observability Agent behavior by creating a values.yaml file:

```yaml
config:
  logs:
    enabled: true
    collectAgentLogs: false
    excludedNamespaces:
      - kube-system

  metrics:
    enabled: true
    collectAgentMetrics: false
    collectK8sClusterMetrics: false
```

### Configuration options

#### Log collection settings

* `config.logs.enabled`: Enable or disable log collection. Default: true.
* `config.logs.collectAgentLogs`: An option to collect logs from the Nebius Observability Agent itself. Default: false.
* `config.logs.excludedNamespaces`: List of namespaces to exclude from log collection.

#### Metrics collection settings

* `config.metrics.enabled`: Enable or disable metrics collection. Default: true.
* `config.metrics.collectAgentMetrics`: An option to collect metrics from the Nebius Observability Agent itself. Default: false.
* `config.metrics.collectK8sClusterMetrics`: An option to collect Kubernetes cluster-level metrics. Default: false.
* `config.metrics.excludedNamespaces`: List of namespaces to exclude from metrics collection.

### Advanced configuration examples

#### Logs-only configuration

To collect only logs, configure the values.yaml file in the following way:

```yaml
config:
  logs:
    enabled: true
    collectAgentLogs: false
    excludedNamespaces:
      - kube-system

  metrics:
    enabled: false
```

#### Metrics-only configuration

To collect only metrics, configure the values.yaml file in the following way:

```yaml
config:
  logs:
    enabled: false

  metrics:
    enabled: true
    collectAgentMetrics: false
    collectK8sClusterMetrics: false
```

#### Combined logs and metrics configuration

To collect both logs and metrics, configure the values.yaml file in the following way:

```yaml
config:
  logs:
    enabled: true
    collectAgentLogs: false
    excludedNamespaces:
      - kube-system

  metrics:
    enabled: true
    collectAgentMetrics: false
    collectK8sClusterMetrics: false
```

#### Namespace exclusions

By default, the agent excludes the kube-system namespace to avoid collecting system-level logs and metrics. You can exclude additional namespaces by adding them to the excludedNamespaces list:

```yaml
config:
  logs:
    excludedNamespaces:
      - kube-system
      - monitoring
      - cert-manager
      - istio-system

  metrics:
    excludedNamespaces:
      - kube-system
      - monitoring
      - cert-manager
      - istio-system
```

## Updating the agent

To update the Nebius Observability Agent to a newer version, use the following command:

```bash
helm upgrade nebius-observability-agent oci://cr.nebius.cloud/observability/public/nebius-observability-agent-helm \
  --version $(curl https://nebius-o11y-agent.storage.eu-north1.nebius.cloud/nebius-observability-agent-helm/latest-release) \
  --namespace observability \
  --values values.yaml
```
