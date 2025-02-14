# Nebius package for Volcano

## Description

[Volcano](https://volcano.sh/) is a Kubernetes-native batch scheduling system designed to efficiently manage high-performance computing (HPC), machine learning (ML), deep learning, and other data-intensive workloads. It extends Kubernetes' batch scheduling capabilities, offering optimized resource sharing, job lifecycle management, and advanced scheduling features.

## Short description

Volcano enhances Kubernetes with powerful scheduling and resource management for complex workloads.

## Tutorial

**To install the product:**

   1. Configure the application.
   1. Click **Install**.
   1. Wait for the application to change its status to `Deployed`.

## Usage

**To check that Volcano is working:**

   1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl), and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect).

   1. Verify that Volcano components are running:

      ```sh
      kubectl get pods -n volcano-system
      ```

      You should see pods like `volcano-scheduler`, `volcano-admission`, etc.

   1. Refer to the [Volcano documentation](https://volcano.sh/docs/) for detailed guides and tutorials.

**To explore Volcano documentation**:

   1. Visit the [Volcano official documentation](https://volcano.sh/docs/) for in-depth tutorials and configuration guides.

## Use cases

* High-performance computing (HPC) workload management.
* Machine learning and deep learning model training.
* Batch processing and parallel job scheduling.
* Resource-intensive data processing applications.
* Bioinformatics data analysis and simulations.
* AI-powered research in production environments.

## Links

* [Volcano website](https://volcano.sh/)
* [Volcano documentation](https://volcano.sh/docs/)
* [Volcano on GitHub](https://github.com/volcano-sh/volcano)

## Legal

By using the application, you agree to their terms and conditions: [Nebius Applications License](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Volcano License](https://github.com/volcano-sh/volcano/blob/master/LICENSE).