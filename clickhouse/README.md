# Nebius package for ClickHouse

## Description

[ClickHouse](https://clickhouse.com/) is an open-source, column-oriented database management system (DBMS), originally designed particularly for real-time analytical queries. It specializes in processing large-scale data with very high query performance, making it suitable for analytics, business intelligence, monitoring, log analysis, and datasets requiring rapid querying.

ClickHouse efficiently stores and processes analytical workloads using columnar storage, compression, and parallel processing. It provides scalability through distributed processing, reliability through replication, and integrates well with data sources including Kafka, S3, MySQL, PostgreSQL, and popular visualization tools.

## Short description

Fast, open-source column-oriented DBMS optimized for real-time analytics.

## Tutorial

**To install the product:**

1. Configure the application.

1. Click **Install**.

1. Wait for the application to change its status to `Deployed`.

## Usage

**Before using ClickHouse, install and configure kubectl:**

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl).
2. [Configure kubectl to connect to the Kubernetes cluster](https://docs.nebius.com/kubernetes/connect).

**To check the application is installed properly:**

1. Verify pods are running:

```bash
kubectl get pods -n <namespace>
```

1. Verify that the ClickHouse service is up:

```bash
kubectl get services -n <namespace>
```

1. Test access via port forwarding (recommended for initial testing):

```bash
kubectl port-forward svc/<clickhouse-service-name> 9000:9000 -n <namespace>
```

Replace `<clickhouse-service-name>` with your ClickHouse service name.

1. Open a new terminal and run ClickHouse client locally (assuming installed locally):

```bash
clickhouse-client --host localhost --port 9000
```

Or access via ClickHouse client pod within Kubernetes:

```bash
kubectl exec -it <clickhouse-pod-name> -n <namespace> -- bash
clickhouse-client
```

1. Execute a test query:

```sql
SELECT version();
```

If you receive the ClickHouse version, the installation succeeded.

**To start using ClickHouse:**

- Refer to the [ClickHouse documentation](https://clickhouse.com/docs/en/) for guides and advanced usage.
- Explore the [ClickHouse tutorial](https://clickhouse.com/docs/en/getting-started/tutorial/) section for practical examples.

## Use cases

- Real-time event and web analytics (clickstreams, metrics).
- Financial services market data analysis.
- IoT sensor data processing and analytics.
- Infrastructure monitoring and troubleshooting.
- Business intelligence dashboards and data visualization.

## Links

- [ClickHouse website](https://clickhouse.com/)
- [ClickHouse documentation](https://clickhouse.com/docs/en/)
- [ClickHouse on GitHub](https://github.com/ClickHouse/ClickHouse)

## Legal

By using this application, you agree to the following licenses:

- License for [Nebius Kubernetes Applications](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE).
- License for [ClickHouse](https://github.com/ClickHouse/ClickHouse/blob/master/LICENSE).
