# Nebius package for MLflow

## Description

MLflow is a platform for managing workflows and artifacts across the machine learning lifecycle, including tracking experiments, packaging code into reproducible runs, and sharing and deploying models. It has built-in integrations with many popular ML libraries (TensorFlow, PyTorch, XGBoost, etc), but can be used with any library, algorithm, or deployment tool. MLflow’s components are:

* MLflow Tracking: An API for logging parameters, code versions, metrics, model environment dependencies, and model artifacts when running your machine learning code.
* MLflow Models: A model packaging format and suite of tools that let you easily deploy a trained model for batch or real-time inference.
* MLflow Model Registry: A centralized model store, set of APIs, and UI focused on the approval, quality assurance, and deployment of an MLflow Model.
* MLflow Projects: A standard format for packaging reusable data science code that can be run with different parameters to train models, visualize data, or perform any other data science task.

## Short description

Manage your ML experiments in a Kubernetes cluster.

## Use cases

* Recording parameters and metrics from experiments, comparing results and exploring the solution space. Storing the outputs as models.
* Comparing the performance of different models and selecting the best for deployment. Registering the models and tracking performance of their production versions.
* Deploying ML models in diverse serving environments.
* Storing, annotating, discovering, and managing models in a central repository.
* Packaging data science code in formats that allow running it with different parameters on any platform and sharing it with others.

## Links

* [MLflow website](https://mlflow.org)
* [MLflow documentation](https://mlflow.org/docs/latest/index.html)
* [MLflow on GitHub](https://github.com/mlflow/mlflow/)

## License

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0).

## Tutorial

{% note warning %}

If you are going to use this product in production, we recommend to configure it according to the [MLflow recommendations](https://mlflow.org/docs/latest/index.html).

{% endnote %}

To install the product:

1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage

1. To check that MLflow is working:
   1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect).

   1. Get MLflow Tracking credentials:

      ```bash
      export MLFLOW_TRACKING_USERNAME=$(kubectl get secret mlflow-tracking -n <namespace> -o jsonpath="{.data.admin-user}" | base64 --decode)
      export MLFLOW_TRACKING_PASSWORD=$(kubectl get secret mlflow-tracking -n <namespace> -o jsonpath="{.data.admin-password}" | base64 --decode)
      echo $MLFLOW_TRACKING_USERNAME
      echo $MLFLOW_TRACKING_PASSWORD
      ```

   1. Set up port forwarding:

      ```bash
      kubectl port-forward service/mlflow-tracking 8000:80 -n <namespace>
      ```

   1. Go to [http://localhost:8000](http://localhost:8000) in your web browser and log into MLflow Tracking using the credentials you got earlier.

1. To track experiments with MLflow, call it in your code:

   ```python
   import os
   import mlflow
   
   mlflow_server = 'localhost:8000'
   
   mlflow.set_tracking_uri(f"http://{mlflow_server}")
   ```

   Run the code on the same machine you set up port forwarding on.
