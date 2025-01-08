# Nebius package for Cvat

## Description

CVAT (Computer Vision Annotation Tool) is an open-source, Kubernetes-native application designed to streamline the process of annotating images and videos for computer vision tasks. With CVAT, teams can efficiently label datasets, enabling the training of accurate and robust machine learning models. Deploying CVAT in your Kubernetes cluster provides a scalable and flexible solution for managing annotation workflows, enhancing collaboration among team members, and accelerating model development cycles. CVAT supports a wide range of annotation types, including bounding boxes, polygons, polylines, and keypoints, catering to diverse computer vision applications. By leveraging CVAT, organizations can unlock the full potential of their computer vision projects, from data preparation to model deployment.

## Short description

A tool for annotation workflows, efficient model training and inference.

## Use cases

* Annotation of objects within images and videos for tasks such as object detection, instance segmentation, and object tracking.

* Labelling images with corresponding categories or tags to train classification models for tasks like image recognition and content-based retrieval.

* Defining pixel-level annotations to create detailed masks for each object class, essential for applications such as scene understanding and image segmentation.

* Labelling video frames to generate annotated datasets for video understanding tasks, including action recognition, event detection, and surveillance.

## Links

* [CVAT website](https://www.cvat.ai/)
* [CVAT documentation](https://docs.cvat.ai/docs/)
* [CVAT on GitHub](https://github.com/cvat-ai/cvat)

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [MIT License](https://github.com/cvat-ai/cvat/blob/develop/LICENSE).

## Tutorial

1. Click **Install**.
2. Wait for the application to change its status to `Deployed`.

## Usage

To connect to the CVAT UI:

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure it to work with the created cluster](https://nebius.ai/docs/managed-kubernetes/operations/connect/#kubectl-connect).

1. Find out the CVAT server pod’s name:
   
    ```bash
    kubectl get pods -n <namespace> -l app=cvat-app -l component=server
    ```
   
1. Connect to the CVAT pod:

    ```bash
    kubectl -n <namespace> exec -it <CVAT-pod-name> -- /bin/sh
    ```

1. Create a privileged user:

    ```python
    python manage.py createsuperuser
    ```

1. Choose a name, email (optionally), and a password for the new user.

1. Enable port forwarding:

    ```bash
    kubectl port-forward service/<application-name>-traefik 8000:80 -n <namespace>
    ```

    For example, `kubectl port-forward service/cvat-traefik 8000:80 -n cvat`.

1. Add `127.0.0.1 <hostname>` line to the `/etc/hosts` file.


To check that CVAT is working:

1. Go to `http://<hostname>:8000` in your web browser to access the CVAT UI.

1. Log in with the credentials of the previously created user.

To store images and datasets in a Nebius AI Object Storage bucket:

1. [Create an Object Storage bucket](https://nebius.ai/docs/storage/operations/buckets/create).

1. Configure access to the bucket:

   1. [Create a service account](https://nebius.ai/docs/iam/operations/sa/create) and [add it to the `editors` group](https://nebius.ai/docs/iam/operations/groups/add-member).

   1. [Create a static access key](https://nebius.ai/docs/iam/operations/sa/create-access-key) for the service account.

1. Connect the bucket with CVAT:

   1. On the CVAT main page, open **Cloud Storages** tab in the top panel.
   1. On the right, click **+** to add a new cloud storage integration.
   1. Configure the storage:

       1. Choose a storage name and description.
       1. For the **Provider**, select **AWS**.
       1. For the **Authentication type**, select **Key id and secret access key pair**.
       1. Enter a name of the previously created Object Storage bucket and its access keys.
       1. For the **Endpoint URL**, enter `https://storage.eu-north1.nebius.cloud`.

   1. Click **Submit**.
   1. Open the advanced project settings in CVAT UI and enter the previously created storage name in the **Select cloud storage** field.
