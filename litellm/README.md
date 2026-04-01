# Nebius package for LiteLLM

## Description

LiteLLM is an open-source Python SDK and proxy gateway that lets developers access and manage over 100 large language model (LLM) APIs through a single, unified interface that mimics the structure of OpenAI’s API—think of it as a universal remote for LLMs. This approach enables switching between models from providers like OpenAI, Anthropic, Google (Gemini), AWS (Bedrock/SageMaker), Hugging Face, and many more without changing your underlying code.

## Short description

LLM Gateway to provide model access, fallbacks and spend tracking across 100+ LLMs. All in the OpenAI format.

## Use cases

- Translate inputs to provider's `completion`, `embedding`, and `image_generation` endpoints.
- [Consistent output](https://docs.litellm.ai/docs/completion/output), text responses will always be available at `['choices'][0]['message']['content']`.
- Retry/fallback logic across multiple deployments (e.g. Azure/OpenAI) - [Router](https://docs.litellm.ai/docs/routing).
- Track spend & set budgets per project [LiteLLM Proxy Server](https://docs.litellm.ai/docs/simple_proxy).

## Links

[LiteLLM website](https://www.litellm.ai/)
[LiteLLM on GitHub](https://github.com/BerriAI/litellm)
[LiteLLM documentation](https://docs.litellm.ai/docs/)

## Legal

By using the application, you agree to their [terms and conditions](https://github.com/BerriAI/litellm/blob/main/LICENSE).

## Tutorial

**Install and configure the product:**

1. Find a provider that you want to use [LiteLLM documentation](https://docs.litellm.ai/docs/providers).
1. Configure the model based on LiteLLM documentation.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage


