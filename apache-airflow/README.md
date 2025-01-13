# Nebius package for Apache Airflow™

## Description

[Apache Airflow™](https://github.com/apache/airflow) is an open-source platform for orchestrating batch workflows. In Airflow, pipelines are defined in Python code as directed acyclic graphs (DAGs), meaning you can generate workflows dynamically and connect them with virtually any technology, either through ready-made packages from third-party providers or your own extensions. A modular architecture of Airflow and a built-in message queue ensures its high scalability. Airflow’s user interface provides overviews and in-depth views of pipelines and tasks.

## Short description

Scalable open-source tool for orchestrating batch workflows in Python.

## Use cases

- Developing, maintaining, and scheduling workflows as code.
- Connecting workflows with other technologies.
- Monitoring workflows and tasks.

## Links

- [Apache Airflow™ website](https://airflow.apache.org/)
- [Apache Airflow documentation](https://airflow.apache.org/docs/)
- [Apache Airflow on GitHub](https://github.com/apache/airflow/)

## Tutorial

{% note warning %}

If you are going to use this product in production, we recommend to configure it according to the [Airflow recommendations](https://airflow.apache.org/docs/apache-airflow/stable/).

{% endnote %}

**Before installing this product:**

1. Generate a secret key for the Airflow webserver:

   ```bash
   python3 -c 'import secrets; print(secrets.token_hex(16))'
   ```

   For each Managed Service for Kubernetes cluster that you install Airflow on, you should generate a new webserver secret key. For more details, see the [Airflow documentation](https://airflow.apache.org/docs/helm-chart/stable/production-guide.html#webserver-secret-key).

1. Create a repository with your DAGs on GitHub or other platform.

**To install the product:**

1. Configure the application.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/#kubectl-connect).
1. To check that Airflow is working, access its UI:

   1. Set up port forwarding:

      ```bash
      kubectl -n <namespace> port-forward \
        services/<application_name>-webserver 8080:8080
      ```

   1. Go to [http://localhost:8080](http://localhost:8080) in your browser and log into the UI as `admin` using the password you created earlier.
   1. After logging in, reset the admin's password: under the user picture, click **Your profile** → **Reset my password**.

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Apache Airflow™](https://github.com/apache/airflow/blob/main/LICENSE).
