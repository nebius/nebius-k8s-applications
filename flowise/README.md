# Nebius package for Flowise

## Description

[Flowise](https://flowiseai.com/) is a platform designed for seamless innovation with a low-code approach and convenient UI. It brings about the transition from testing to production through fast and easy iterations. Benefit from LLM Orchestration, [Langchain](https://python.langchain.com/docs/get_started/introduction), and versatile integrations with over 100 integration options. Create autonomous agents and explore custom tools for flexibility. Utilize APIs, SDK, and [embedded chat](https://docs.flowiseai.com/using-flowise/embed) for seamless integration. Experience open source LLMs like [HuggingFace](https://huggingface.co/models) and [Ollama](https://ollama.ai/library) ones, with options for self-hosting in Nebius AI.

## Short description

Open source visual UI tool to build your own customized LLM orchestration flow and AI agents in Kubernetes.

## Use cases

- Creating chatbots to answer any questions, for example, about the product catalogue.
- Generating product description from given product specifications.
- Using natural language to query SQL database.
- Summarizing and creating follow-up tasks from customer support tickets.
- Generating or extracting structured data to be used for downstream tasks.

## Links

- [Flowise website](https://flowiseai.com/)
- [Flowise GitHub](https://github.com/FlowiseAI/Flowise)
- [Flowise documentation](https://docs.flowiseai.com/)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Apache 2.0](https://github.com/FlowiseAI/Flowise/blob/main/LICENSE.md "default-tos")

## Tutorial

To install the product:

1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage

1. To check that Flowise is working:

   1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl), and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect).

   1. Check the access to its UI:

      ```bash
      kubectl port-forward <application-name> 3000:3000 -n <namespace>
      ```

   1. Go to [http://localhost:3000](http://localhost:3000) in your web browser to access the UI.
