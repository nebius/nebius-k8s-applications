## Description
NVIDIA Osmo is a cloud-native orchesation and workflow management platform designed to streamline robotics and AI development across simulation and real-world environments. It enables teams to coordinate simulation jobs, synthetic data generation, model training, validation, and deployment pipelines through a unified interface. By integrating with NVIDIA’s simulation and AI ecosystem, Osmo helps automate complex, distributed workloads while ensuring scalability, reproducibility, and efficient resource utilization in the cloud.

## Short description
Cloud-native orchestration and simulation workflows for robotics development.

## Tutorial

1. Save the generated passwords securely. You might need them later.
1. [Create an Object Storage bucket](https://docs.nebius.com/object-storage/buckets/manage). Enter the bucket name and select its region in the drop down.
1. [Create a service account](https://docs.nebius.com/iam/service-accounts/manage) and grant it access to edit the bucket. Enter the access key and secret key values in the form.
1. Click **Deploy application**.

## Usage

**To check that the OSMO is working:**

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure it to work with the created cluster](https://docs.nebius.com/kubernetes/connect).
1. Check that the OSMO pods are running:

   ```bash
   kubectl get pods -n <namespace>
   ```

**To access the application:**

* ClusterIP
    1. Set up port forwarding (you will need to [install](https://kubernetes.io/docs/tasks/tools/#kubectl) and [configure](https://docs.nebius.com/kubernetes/connect) `kubectl` for that):

       ```bash
       kubectl --namespace=<namespace> get svc

       kubectl --namespace=<namespace> port-forward service/<release-name>-ingress-nginx-controller 8080:http
       ```

    1. Go to <http://localhost:8080> in your browser.

* Install the [OSMO CLI](https://nvidia.github.io/OSMO/main/user_guide/getting_started/install/index.html) and continue with the NVIDIA OSMO user guide.

## Use cases
Osmo is ideal for robotics developers, autonomy teams, and AI engineers building physical AI systems. Typical use cases include running large-scale simulation experiments, generating synthetic datasets for perception models, orchestrating continuous training and evaluation pipelines, and managing end-to-end workflows from development to deployment. It is particularly valuable for organizations developing autonomous vehicles, industrial robots, drones, and other intelligent machines that require robust simulation-to-reality iteration cycles.

## Support

## Links

- [NVIDIA OSMO](https://developer.nvidia.com/osmo)
- [OSMO User Guide](https://nvidia.github.io/OSMO/main/user_guide/index.html)
- [OSMO Github repository](https://github.com/NVIDIA/OSMO)

## Legal
By using this application, you agree to the terms and conditions: [the helm chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) 
and [NVIDIA Osmo](https://github.com/NVIDIA/OSMO#Apache-2.0-1-ov-file)
