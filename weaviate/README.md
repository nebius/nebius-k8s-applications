## Description
[Weaviate](https://weaviate.io/) is a platform that provides the advantages of both vector and keyword search right out of the box. It allows to store and retrieve data objects and vector embeddings, improves semantic understanding and accuracy. Weaviate has pre-built modules for popular ML models and frameworks, enabling faster development and iteration. At the same time, it is possible to connect to your favorite ML models to build intuitive, reliable AI applications that scale. Weaviate has an active community that helps developers of all levels build end-to-end AI applications.

You can deploy Weaviate in your Nebius AI [Managed Service for Kubernetes](https://nebius.ai/services/managed-kubernetes) clusters using this Marketplace product.

{% note warning %}

If you are going to use this product in production, we recommend to configure it according to the [Weaviate recommendations](https://weaviate.io/developers/weaviate).

{% endnote %}


## Short description
An open source, AI-native vector database. Deploy Weaviate in Nebius AI.


## Tutorial
Before installing this product:

1. [Create a Kubernetes cluster](https://docs.nebius.com/kubernetes/clusters/manage) and a [node group](https://docs.nebius.com/kubernetes/node-groups/manage) in it. Each node in the group should have at least 8 GB of RAM.
1. [install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl), and [configure it to work with the created cluster](https://docs.nebius.com/kubernetes/connect).

To install the product:

1. On the cluster page in the management console, go to the **Marketplace** tab, select the product, and click **Install**.
1. Configure the application:

   * **Namespace**: Select a [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) or create a new one.
   * **Application name**: Enter an application name.
   * **User**: Create a user name to access the Weaviate UI.
   * **Password**: Create a password for the user name.
   * **Enable module text2vec-contextionary**: Check the box to enable Weaviate to obtain vectors locally using a lightweight model, well-suited for testing purposes.
   * **Enable module text2vec-transformers**: Check the box to enable Weaviate to obtain vectors locally using a transformers-based model that helps to boost inference speed.
   * **Enable module text2vec-gpt4all**: Check the box to enable Weaviate to obtain vectors using the [gpt4all](https://docs.gpt4all.io/gpt4all_python_embedding.html) library.
   * **Enable more modules**: To enable more modules check out the Compose tab to edit the YAML configuration directly.

1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.
1. To check that Weaviate is working:

   1. Check the access to Weaviate's UI:

      ```bash
      kubectl port-forward pods/weaviate-0 8080:8080
      ```

   1. Go to [http://localhost:8080](http://localhost:8080) in your web browser to access the UI.


## Use cases
* Similarity search on and across any modalities, such as text or images, and their combinations.

* Addressing some of the limitations of LLMs, such as hallucinations, by helping to retrieve the relevant information to provide to the LLM as part of its input.

* Automatic, real-time classification of unseen, new concepts based on its semantic understanding.

* Named entity recognition, spell checking, and more.


## Support
Nebius AI does not provide technical support for the product. If you have any issues, please refer to the developer’s information resources.


## Links
- [Weaviate website](https://weaviate.io/)
- [Weaviate documentation](https://weaviate.io/developers/weaviate)
- [Weaviate on GitHub](https://github.com/weaviate/weaviate)


## Term of service
- [Terms of Use of Nebius Applications](https://docs.nebius.com/legal/specific-terms/applications "default-tos")
- [BSD-3](https://github.com/weaviate/weaviate?tab=BSD-3-Clause-1-ov-file#readme "default-tos")


