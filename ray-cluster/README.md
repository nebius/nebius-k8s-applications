# Nebius package for Ray cluster

## Description

During installation, you can select the number and parameters of worker groups, configure autoscaling, and set up the head node. Alternatively, you may provide your own configuration in YAML format.
Optionally, you can install the **KubeRay Operator**, which is required for Ray Cluster to function properly.
You may also optionally install the **Kubernetes Prometheus Stack**, which integrates with the KubeRay Operator and Ray Cluster for monitoring and observability.

### **Autoscaling**

By default, the installation parameters enable autoscaling and set the number of worker replicas to **0**.  
This means that as soon as a task is submitted, Ray Cluster will automatically create a worker for it. Once the task is finished, the worker will be deleted after a short grace period if it is not used anymore.

**Ray Cluster Autoscaling + Managed Service for Kubernetes® Cluster**  
Ray Cluster autoscaling and Managed Service for Kubernetes® cluster work seamlessly together.  
When Ray Cluster creates a worker and there is no suitable node available, the Kubernetes® cluster autoscaler will provision one. Similarly, once the worker is deleted, the node will also be removed after some time.

If you want to avoid paying for idle resources in the Managed Service for Kubernetes® cluster, the optimal setup is to configure autoscaling in both Ray Cluster and the Kubernetes® cluster so that the default number of workers and nodes is set to zero. This way, both workers and nodes will only be created when a task is executed and will be automatically removed afterwards.

### **Running Workers in a Specific Node Group**

**Below are the different ways to run workers on a specific node group.
Details of these sections can be found on the product installation page.**

If you have multiple node groups and want workers to run only in a specific one, you need to assign a `nodeSelector` to the worker during installation.  
For example, if you have one node group with **L40S GPUs** and another with **H100 GPUs**, and you want workers to run only in the **L40S group**, you should configure a node selector for that worker group.

#### When autoscaling is enabled and the node group has 0 nodes by default
In this case, the Managed Service for Kubernetes® cluster autoscaler cannot see labels like `node.kubernetes.io/instance-type` (because they appear only after a node starts).  
To fix this, you need to manually add labels to the node group template.

#### Using Custom Resources for Worker Groups

If you want multiple worker groups, each mapped to its own node group, and the ability to explicitly target them in tasks, you can assign **custom resources** to worker groups.
For maximum flexibility, you can combine both **node selectors** and **custom resources**.

### **Monitoring**

If you selected the installation of the **Kubernetes Prometheus Stack** during product setup, you will gain quick and easy access to **Grafana**, which comes preloaded with dashboards for both the KubeRay Operator and the Ray Cluster.

In addition, you will also have direct access to **Ray Cluster dashboards** for simplified monitoring and observability.


### **Connecting and Using Ray Cluster**

By default, the head node receives a public IP address during installation. You can use it to connect to the Ray Cluster and run tasks.

If the head service type is set to **ClusterIP**, the head node will not have a public IP address.  
In that case, the simplest way is to use `kubectl port-forward`.

You can find the details on the installed product page.

## Short description

Ray simplifies scalable AI workload deployment with Kubernetes orchestration.

## Tutorial

If you choose to install the **Kubernetes Prometheus Stack**, it will be fully integrated with the Ray Cluster.

By default, the installation parameters enable autoscaling and set the number of worker replicas to **0**.  

**Ray Cluster Autoscaling + Managed Service for Kubernetes® Cluster**
If you want to avoid paying for idle resources in the Managed Service for Kubernetes® cluster, the optimal setup is to configure autoscaling in both Ray Cluster and the Kubernetes® cluster so that the default number of workers and nodes is set to *0*.

### **Running Workers in a Specific Node Group**

For example, if you have one node group with **L40S GPUs** and another with **H100 GPUs**, and you want workers to run only in the **L40S group**, you should configure a node selector for that worker group.

To do this:
- Open **Advanced** settings for the worker group.
- Under **Resources**, specify the required node selector.  
  Example:
  ```
  node.kubernetes.io/instance-type: gpu-l40s-a
  ```

#### When autoscaling is enabled and the node group has 0 nodes by default
In this case, the Managed Service for Kubernetes® cluster autoscaler cannot see labels like `node.kubernetes.io/instance-type` (because they appear only after a node starts).  
To fix this, you need to manually add labels to the node group template:

1. Edit the node group template via CLI:
   ```
   nebius mk8s node-group edit --id=mk8snodegroup-<your_id>
   ```
2. Locate the section `spec > metadata > template` (empty by default).
3. Add your labels under `metadata > labels`.  
   Example:
   ```yaml
   metadata:
     ...
   spec:
     ...
     template:
       ...
       metadata:
         labels:
           <some_key>: <some_value>
   ```
4. Save changes.

After this, you can safely reference the label in your worker group configuration.

#### Using Custom Resources for Worker Groups

If you want multiple worker groups, each mapped to its own node group, and the ability to explicitly target them in tasks, you can assign **custom resources** to worker groups.

To do this:
- During installation, open **Advanced** settings for the worker group.
- Under **rayStartParams**, specify a custom resource.  
  Example:
  ```
  "{\"MyBestGPU\": 1}"
  ```

After installation, you can submit tasks to that worker group by specifying the resource:
```python
@ray.remote(resources={"MyBestGPU": 1})
```

For maximum flexibility, you can combine both **node selectors** and **custom resources**.


## Usage

For quick access to the **Ray cluster dashboards** or the **Grafana**, go to the Endpoints section, create a link, and follow it.
Since Grafana is embedded into Ray cluster dashboards via iFrame on port 3000, you need a local connection:
```bash
kubectl get svc -n <namespace> | grep grafana
kubectl port-forward svc/<grafana-service> 3000:80 -n <namespace>
```

### **Connecting and Using Ray Cluster**

By default, the head node receives a public IP address during installation. You can use it to connect to the Ray Cluster and run tasks.

To retrieve the public IP address:
```bash
kubectl get services -n <namespace>
```
Locate the service whose name ends with `head-svc` and copy the value from the **EXTERNAL-IP** column.

In your code, initialize Ray as follows:
```python
ray.init("ray://<head_ip_address>:10001")
```

If the head service type is set to **ClusterIP**, the head node will not have a public IP address.  
In that case, the simplest way is to use `kubectl port-forward` and then connect with the same code snippet above using **CLUSTER-IP** address.
For example: 
```bash
kubectl port-forward svc/<head_service_name> 10001:10001 -n <namespace>
```

## Use cases

* Reinforcement learning research and development.
* Distributed model training for deep learning applications.
* High-performance computing for scientific simulations and data analysis.
* Large-scale data processing and analytics.
* Experimentation with parallel algorithms and distributed systems.
* Development and deployment of AI-powered applications in production environments.

## Links

* [Ray website](https://www.ray.io/)
* [Ray documentation](https://docs.ray.io/en/latest/index.html)
* [Ray on GitHub](https://github.com/ray-project/ray)
* [KubeRay on GitHub](https://github.com/ray-project/kuberay)

## Term of service

* [Apache 2.0](https://github.com/ray-project/kuberay/blob/master/LICENSE "additional-third-party-tos")

## Legal

By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [KubeRay](https://github.com/ray-project/kuberay/blob/master/LICENSE).
