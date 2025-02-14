# Nebius package for Clear Ml agent

## Description

[ClearML](https://clear.ml/) is an open-source, end-to-end AI Platform designed to streamline AI adoption and the entire development lifecycle. ClearML integrates seamlessly with multiple tools, frameworks, and infrastructures, offering unmatched flexibility and control for AI builders and DevOps teams building, training, and deploying models at every scale on AI infrastructure.

This Kubernetes-compatible application deploys a [ClearML Agent](https://clear.ml/docs/latest/docs/clearml_agent) in your Nebius AI [Managed Service for Kubernetes](https://nebius.ai/services/managed-kubernetes) cluster. It helps to scale AI/ML workflows on multiple GPU machines.

## Short description

A ClearML Agent for scaling AI/ML workflows on multiple GPU machines.

## Use cases

- Reproducing experiments, including their complete environments.
- Scaling workflows on multiple target machines.

## Links

- [ClearML website](https://clear.ml/)
- [ClearML on GitHub](https://github.com/allegroai/clearml)
- [ClearML Agent documentation](https://clear.ml/docs/latest/docs/clearml_agent)
- [ClearML community forum](https://forum.clear.ml/)

## Tutorial

**Before installing this product:**

1. Clear ML agent works with GPUs:

   - NVIDIA® H100 NVLink with Intel Sapphire Rapids (Types A, B, C)

   {% note info %}

   It is strongly recommended that each node has at least 4 vCPUs and 8 GB of RAM.

   {% endnote %}

**To install the product:**

1. Configure the application.
1. Generate credentials
       - for cloud version: [https://app.clear.ml/settings/workspace-configuration](https://app.clear.ml/settings/workspace-configuration){target="_blank"}
       - Fill Glue basic auth key and Glue basic auth secret
       - Set queue to watch, could be multiple like queue1, queue2
       - Set necessary number of GPUs available for worker
       - Optionaly change URL of `API Server`, `File Server`, `Web Server` if you have hosted OSS version.
       - Adjust `ClearML configuration` if needed.
1. Click Install.
1. Wait for the application to change its status to `Deployed`.

## Usage

After agent appears in the web ui workers list you can submit a job to attached queue

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [ClearML Apache 2.0 License](https://github.com/allegroai/clearml/blob/master/LICENSE).
