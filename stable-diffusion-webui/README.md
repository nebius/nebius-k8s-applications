# Nebius package for Stable Diffusion web UI

## Description

The [Stable Diffusion web UI](https://github.com/AUTOMATIC1111/stable-diffusion-webui), developed by [AUTOMATIC1111](https://github.com/AUTOMATIC1111), is an easy-to-use browser interface for one of the most popular text-to-image deep learning models. Powered by [Gradio](https://www.gradio.app/), the UI features basic and advanced Stable Diffusion capabilities, such as original txt2img and img2img modes, outpainting, inpainting and upscaling, weighted prompts and prompt matrices, loopback, and many more.

## Short description

An easy-to-use interface to work with Kubernetes-hosted.

## Tutorial

**To install the product:**

1. Configure the application.

1. Click **Install**.

1. Wait for the application to change its status to `Deployed`.

## Usage

**To check that the Stable Diffusion Web UI is working:**

1. Forward the port:

    ```bash
    export POD_NAME=$(kubectl get pods --namespace <namespace> -l "app.kubernetes.io/name=stable-diffusion,app.kubernetes.io/instance=<application-name>" -o jsonpath="{.items[0].metadata.name}")

    export CONTAINER_PORT=$(kubectl get pod --namespace <namespace> $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")

    echo "Visit http://127.0.0.1:8080 to use your application"
    kubectl --namespace <namespace> port-forward $POD_NAME 8080:$CONTAINER_PORT
    ```

1. Go to [http://localhost:8080](http://localhost:8080) in your web browser to access the UI.

## Use cases

- Generating images from text or other images.
- Creating artwork, graphics, and logos.
- Creating video and animations.
- Editing images.

## Links

- [Stable Diffusion web UI on GitHub](https://github.com/AUTOMATIC1111/stable-diffusion-webui)
- [Stable Diffusion web UI documentation](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Stable Diffusion web UI](https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/LICENSE.txt).
