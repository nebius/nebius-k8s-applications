# Nebius package for Ollama

## Description

[Ollama](https://www.ollama.com)  is an open-source tool that runs large language models (LLMs) on your server. This makes it particularly appealing to AI developers, researchers, and businesses concerned with data control and privacy. By running models on your server, you maintain full data ownership and avoid the potential security risks associated with cloud storage. Offline AI tools like Ollama also help reduce latency and reliance on external servers, making them faster and more reliable.

## Short description

Runs LLMs on your server, ensuring data privacy and control. Ideal for AI developers and businesses.

## Use cases

- **Financial services**: Run LLMs to analyze financial data, detect fraud, and generate personalized financial advice while ensuring data privacy.
- **Healthcare**: Use LLMs for patient data analysis, diagnosis assistance, and predictive healthcare management without compromising sensitive information.
- **Insurance**: Implement LLMs for claims processing, risk assessment, and customer service automation, maintaining control over customer data.
- **Manufacturing**: Optimize production processes, predictive maintenance, and supply chain management using LLMs on-premises.
- **Marketing**: Enhance customer segmentation, content personalization, and campaign optimization with LLMs, keeping marketing data secure.
- **Retail**: Improve inventory management, pricing strategies, and customer experience by running LLMs locally.
- **Telecom**: Utilize LLMs for network optimization, customer support automation, and predictive maintenance, ensuring data control and security.

## Links

- [Ollama website](https://www.ollama.com)
- [Ollama on GitHub](https://github.com/ollama/ollama)
- [Ollama list of models](https://ollama.com/search)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [MIT](https://github.com/ollama/ollama/blob/main/LICENSE).

## Tutorial

To install the product:

1. Click **Install**.
1. You can find model name in [Ollama library](https://ollama.com/search)
1. Wait for the application to change its status to `Deployed`.
1. Install the [NVIDIA® GPU Operator](https://console.eu.nebius.com/applications/overview/nebius/nvidia-gpu-operator) on the cluster.

## Usage

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect)
1. Check that Ollama pods are running:

   ```bash
   kubectl get pods -n <namespace>
   ```

1. You can use [JupyterHub](https://console.eu.nebius.com/applications/overview/nebius/jupyterhub) to interact with Ollama
1. Interact with Ollama

- **Ollama documentation can be found [HERE](https://github.com/ollama/ollama/tree/main/docs)**
- Interact with RESTful API: [Ollama API](https://github.com/ollama/ollama/blob/main/docs/api.md)
- Interact with official clients libraries: [ollama-js](https://github.com/ollama/ollama-js#custom-client)
  and [ollama-python](https://github.com/ollama/ollama-python#custom-client)
- Interact with langchain: [langchain-js](https://github.com/ollama/ollama/blob/main/docs/tutorials/langchainjs.md)
  and [langchain-python](https://github.com/ollama/ollama/blob/main/docs/tutorials/langchainpy.md)
