# Nebius package for Ray h2oGPT

## Description

[h2oGPT](https://h2o.ai/platform/open-source-gpt-and-llm-studio/) is a suite of components designed to facilitate the deployment and utilization of large language models (LLMs), specifically leveraging the power of the GPT architecture. The components included in the suite are a large language model, an embedding model, a database for document embeddings, and a graphical user interface. h2oGPT enables users to harness the capabilities of advanced language models for a variety of applications, from text generation to sentiment analysis. It maintains control over your data and ensures privacy while still having access to powerful language processing capabilities. This product offers commercially usable code, data, and models. It supports several types of documents including plain text (.txt), comma-separated values (.csv), Word (.docx and .doc), PDF, Markdown (.md), HTML, EPUB, and email files (.eml and .msg).

## Short description

Create private GPT-based LLMs in your Kubernetes cluster.

## Use cases

- Text generation for chatbots, virtual assistants, and content creation.

- Sentiment analysis and opinion mining for social media monitoring and customer feedback analysis.

- Text summarization and document clustering for information retrieval and organization.

- Question answering systems for knowledge management and customer support automation.

- Natural language understanding for contextual understanding and semantic analysis.

- Dialog systems for interactive user experiences and conversational interfaces.

- Text classification and categorization for content moderation and information filtering.

- Language modeling for text completion and predictive typing applications.

- Speech recognition and transcription for audio-to-text conversion and voice-enabled applications.

## Links

- [h2oGPT website](https://h2o.ai/platform/open-source-gpt-and-llm-studio/)
- [h2oGPT on GitHub](https://github.com/h2oai/h2ogpt)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)

## Tutorial

{% note warning %}

If you want to use h2oGPT with GPUs and have them in your node group, install the [NVIDIA® GPU Operator](https://console.eu.nebius.com/applications/overview/nebius/nvidia-gpu-operator) on the cluster.

{% endnote %}

1. Click **Install**.
2. Wait for the application to change its status to `Deployed`.

## Usage

To check that h2oGPT is working, access its UI:

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect).
1. Set up port forwarding:

    ```bash
    kubectl -n <namespace> port-forward \
      service/h2ogpt-web 8080:80
    ```

1. Go to [http://localhost:8080/](http://localhost:8080/) in your web browser.
