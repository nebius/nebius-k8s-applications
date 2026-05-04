# FiftyOne

## Description

FiftyOne is an open source tool from Voxel51 for building, curating, visualizing, and evaluating computer vision datasets and models. This application deploys the FiftyOne App server on Nebius Managed Service for Kubernetes so users can inspect datasets through a browser.

The deployment runs the FiftyOne server on port `5151`, runs a colocated MongoDB container for FiftyOne metadata, and stores MongoDB data, default datasets, dataset zoo cache, and model zoo cache on a persistent volume.

## Short description

Deploy the Voxel51 FiftyOne App for visual AI dataset exploration and model evaluation.

## Tutorial

Before installing, make sure your Nebius Managed Service for Kubernetes cluster has enough persistent storage for the datasets you plan to load. The default persistent volume size is `128Gi`.

During installation:

1. Select the target Kubernetes cluster.
2. Choose the application name and namespace.
3. Set the persistent volume size.
4. Install the application.

The application uses the upstream Voxel51 FiftyOne image and the upstream MongoDB image, both pinned to concrete tags.

## Usage

After installation, forward the FiftyOne service to your workstation:

```bash
kubectl --namespace <namespace> port-forward service/<release-name> 5151:5151
```

Open `http://127.0.0.1:5151` in your browser.

To load a sample dataset into the running pod:

```bash
kubectl --namespace <namespace> get pods -l app.kubernetes.io/name=fiftyone
kubectl --namespace <namespace> exec -it <pod-name> -- python -c "import fiftyone as fo, fiftyone.zoo as foz; foz.load_zoo_dataset('quickstart', dataset_name='quickstart', persistent=True)"
```

Refresh the browser after the dataset import completes.

## Use cases

- Inspect images, videos, labels, predictions, and embeddings in the FiftyOne App.
- Curate visual datasets before model training.
- Analyze model predictions and failure modes.
- Load public zoo datasets or persistent datasets into a shared Kubernetes environment.

## Links

- [FiftyOne documentation](https://docs.voxel51.com/)
- [FiftyOne source code](https://github.com/voxel51/fiftyone)
- [FiftyOne Dockerfile](https://github.com/voxel51/fiftyone/blob/develop/Dockerfile)
- [Voxel51 website](https://voxel51.com/)

## Legal

FiftyOne is distributed under the [Apache License 2.0](https://github.com/voxel51/fiftyone/blob/develop/LICENSE). By using this application, you are responsible for complying with the licenses and terms that apply to FiftyOne, its dependencies, and any datasets or models you load into the application.
