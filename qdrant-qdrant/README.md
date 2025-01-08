# Nebius package for Qdrant

## Description

[Qdrant](https://qdrant.tech/) is an easy-to-use API that provides the OpenAPI v3 specification, allowing the generation of client libraries in various programming languages. Users can leverage pre-built clients for Python and other languages with additional functionality. The system implements a customised version of the Hierarchical Navigable Small World (HNSW) algorithm for Approximate Nearest Neighbor Search, ensuring fast and accurate searches with state-of-the-art speed. Qdrant allows for efficient filtering of search results without compromising accuracy.

One of Qdrant's key features is its filterable support for additional payloads associated with vectors. Unlike Elasticsearch post-filtering, Qdrant guarantees the retrieval of all relevant vectors. The vector payload supports a wide range of data types and query conditions, including string matching, numeric ranges, geo-locations and more. Users can apply filter conditions to the payload to build custom business logic on top of similarity matching.

## Short description

Vector database and vector similarity search engine in your Kubernetes cluster.

## Use cases

- E-commerce search: precise and personalized results without manual synonym lists, visual search, allowing users to find items through images and ensuring size availability.

- Customer support and sales optimization: reducing repetitive tasks and improving quality control.

- HR & Job search: job matching by automatically mapping roles, improving recommendations.

- Advertising: flexible neural network ad recommendations, ensuring relevance without compromising speed.

- Biometric identification: authentication, enabling secure transactions without credit cards.

- Food discovery: selecting meals based on appearance, revolutionising food discovery.

- Fintech: aiding fraud detection by combining similarity search with manual rules for comprehensive identification.

- Law case search: using vector similarity search to compare court decisions.

- Media and games: personalized entertainment recommendations with real-time updates of user preference vectors.

- Medical diagnostics: searching for similar cases based on patient history and medical data.

## Links

- [Qdrant website](https://qdrant.tech/)
- [Qdrant Documentation](https://qdrant.tech/documentation/)
- [Qdrant on GitHub](https://github.com/qdrant/qdrant)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE), [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0).

## Tutorial

{% note warning %}

If you are going to use this product in production, we recommend to configure it according to the [Qdrant recommendations](https://qdrant.tech/documentation/).

{% endnote %}

To install the product:

1. Configure the application:
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Usage

1. To check that Qdrant is working:

   1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/##kubectl), and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/##kubectl-connect).

   1. Check the access to its UI:

      ```bash
      kubectl port-forward svc/<application-name> 6333:6333 -n <namespace>

      ```

   1. Go to [http://localhost:6333/dashboard](http://localhost:6333/dashboard) in your web browser to access the UI.
