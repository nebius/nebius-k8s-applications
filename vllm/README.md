# Nebius package for vLLM

## Description

[vLLM](https://vllm.ai/) is a fast and easy-to-use library for LLM inference and serving. With its PagedAttention algorithm that manages attention keys and values efficiently, vLLM delivers state-of-the-art high-throughput serving. The library is flexible and easy-to-use as it provides seamless integration with popular Hugging Face models, support of various decoding algorithms, an OpenAI-compatible API server, and more. With vLLM, you can deploy and scale LLM applications seamlessly, leveraging Kubernetes' flexibility and scalability to meet the demands of modern AI workloads.

## Short description

A fast and easy-to-use library for LLM inference and serving.

## Tutorial

**Before installing this product:**

   1. [Create a node group](https://docs.nebius.com/kubernetes/node-groups/manage) with GPUs in it. The product supports the following [VM platforms](https://docs.nebius.com/compute/virtual-machines/types) with GPUs:

      - NVIDIA® H100 NVLink with Intel Sapphire Rapids
      - NVIDIA® H200 NVLink with Intel Sapphire Rapids
      - NVIDIA® B200 NVLink with Intel Emerald Rapids
      - NVIDIA® L40S with Intel Ice Lake
      - NVIDIA® L40S with AMD Genoa

      Make sure that boot disk of the nodes have enough storage space for model.

      If model required more than one host, [GPU cluster](https://docs.nebius.com/compute/clusters/gpu) must be used.

        {% note warning %}

        Before installing vLLM, you must install [NVIDIA® GPU Operator](https://console.eu.nebius.com/applications/overview/nebius/nvidia-gpu-operator) on the cluster.

        If GPU cluster is in use [NVIDIA® Network Operator](https://console.eu.nebius.com/applications/overview/nebius/nvidia-network-operator) is required.

        {% endnote %}

**To install the product:**

  1. Configure the application:

      {% note info %}

      To enable authentication in Gradio, you should set both username and password. If they are not set, Gradio will be available without authentication.

      {% endnote %}

  1. Click **Install**.
  1. Wait for the application to change its status to `Deployed`.

## Usage

   **To check that vLLM is working, test the OpenAI Completions API served by vLLM:**

   1. Set up port forwarding:

      ```bash
      kubectl -n <namespace> port-forward \
        services/<application_name>-serve-svc 8000:8000
      ```

   1. Send a request to the API (the example uses the default `Qwen/Qwen2.5-7B-Instruct` model; you can modify it):

      ```bash
      curl -s http://localhost:8000/v1/chat/completions \
        -H "Content-Type: application/json" \
        -d '{
          "model": "Qwen/Qwen2.5-7B-Instruct",
          "messages": [
            {"role": "user", "content": "Hello"}
          ],
          "temperature": 0.7
        }'
      ```

    1. Additional Ray dashboard is also available by address http://localhost:8265 after port-forward:
      ```bash
      NAMESPACE=<namespace>
      kubectl -n $NAMESPACE port-forward \
        services/$(kubectl -n $NAMESPACE get svc -l app.kubernetes.io/created-by=kuberay-operator,ray.io/node-type=head \
        -o custom-columns=":metadata.name" | tail -n 1) 8265:8265
      ```


If you enabled Gradio, to check that it is working, access it:

   1. Set up port forwarding:

      ```bash
      kubectl -n <namespace> port-forward \
        services/<application_name>-gradio-ui 7860:7860
      ```

   1. Go to [http://localhost:7860/](http://localhost:7860/) in your web browser. If you have set credentials when installing the product, use them to log into the UI.

## Accessing via Tunna (Application Tunnel)

When installed through the Nebius console, vLLM is accessible via a secure HTTP/2 tunnel (Tunna) without requiring port forwarding or a public IP.

After installation, the tunnel endpoints are available in the application details page:

- **vLLM API** — OpenAI-compatible endpoint for sending inference requests
- **Gradio UI** — Web interface for interacting with the model (if Gradio is enabled)

To send a request to the vLLM API via the tunnel:

   ```bash
   curl -s https://<tunnel-endpoint>/v1/chat/completions \
     -H "Content-Type: application/json" \
     -d '{
       "model": "Qwen/Qwen2.5-7B-Instruct",
       "messages": [
         {"role": "user", "content": "Hello"}
       ],
       "temperature": 0.7
     }'
   ```

## Use cases

* Natural language understanding (NLU) applications requiring efficient inference with large language models.
* Sentiment analysis and text classification tasks in various industries such as social media monitoring, customer feedback analysis, and content moderation.
* Language translation services requiring high-throughput and low-latency inference for real-time translation.
* Question answering systems for knowledge bases, customer support, and virtual assistants.
* Recommendation systems for personalized content delivery in e-commerce, streaming platforms, and social networks.
* Chatbots and conversational AI applications for interactive user experiences in customer service, healthcare, and education.
* Text summarization and information retrieval for content curation, search engines, and document management systems.
* Named entity recognition (NER) and entity linking for information extraction and knowledge graph construction in data analytics and research.

## Links

* [vLLM website](https://vllm.ai)
* [vLLM on GitHub](https://github.com/vllm-project/vllm)
* [vLLM documentation](https://docs.vllm.ai/en/latest/)
* [Gradio website](https://www.gradio.app/)
* [Gradio on GitHub](https://github.com/gradio-app/gradio)
* [Gradio documentation](https://www.gradio.app/docs)
* [Ray website](https://www.ray.io/)
* [Ray documentation](https://docs.ray.io/en/latest/index.html)
* [Ray on GitHub](https://github.com/ray-project/ray)
* [KubeRay on GitHub](https://github.com/ray-project/kuberay)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [vLLM](https://github.com/vllm-project/vllm/blob/main/LICENSE).
By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [KubeRay](https://github.com/ray-project/kuberay/blob/master/LICENSE).
