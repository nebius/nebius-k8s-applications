# JupyterHub Marketplace Product

For internal operations (publishing, mirroring, debugging), see `products/AGENTS.md` in the monorepo.

## Upstream Source
- Chart: [jupyterhub/zero-to-jupyterhub-k8s](https://github.com/jupyterhub/zero-to-jupyterhub-k8s)
- Helm repo: `https://hub.jupyter.org/helm-chart/`
- Current version: **4.3.3** (appVersion 5.4.4)

## How to Update the Helm Chart

### 1. Pull the new upstream chart
```bash
helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
helm repo update jupyterhub
helm search repo jupyterhub/jupyterhub --versions
helm pull jupyterhub/jupyterhub --version <NEW_VERSION> --untar --untardir /tmp/jupyterhub-upstream
```

### 2. Copy upstream files over
Replace all chart files with upstream, **except** these custom files which must be preserved:
- `chart/files/notebooks/default.ipynb` — Nebius welcome notebook
- `chart/templates/default-notebooks-configmap.yaml` — ConfigMap for the notebook

### 3. Re-apply marketplace customizations to `values.yaml`
After copying the upstream `values.yaml`, re-apply these changes:

#### Auth config (replace `hub.config` section)
```yaml
hub:
  config:
    JupyterHub:
      authenticator_class: firstuseauthenticator.FirstUseAuthenticator
    Authenticator:
      admin_users:
        - admin
    FirstUseAuthenticator:
      create_users: False
      min_password_length: 15
      admin_users:
        - admin
    NativeAuthenticator:
      open_signup: True
      allowed_failed_logins: 5
      check_common_password: True
      minimum_password_length: 15
```

#### Proxy service type (ClusterIP, tunna handles access)
```yaml
proxy:
  service:
    type: ClusterIP
    annotations: {}
```

#### CHP memory request
```yaml
proxy:
  chp:
    resources:
      requests:
        memory: 2Gi
```

#### Disable image pre-pullers
```yaml
prePuller:
  hook:
    enabled: false
  continuous:
    enabled: false
```

#### Tunna-agent (at end of values.yaml)
```yaml
tunna-agent:
  enabled: false
  config:
    logging:
      level: error
      format: json
```

#### Singleuser profileList (two notebook profiles)
```yaml
singleuser:
  profileList:
    - display_name: "Default Jupyterhub Image"
      description: "Default image, runs on any node."
      kubespawner_override:
        image: quay.io/jupyter/base-notebook:notebook-7.3.2
        lifecycle_hooks:
          postStart:
            exec:
              command: ["/bin/sh", "-c", "sudo apt update && sudo apt install -y git curl wget;cat /home/jovyan/default.ipynb || cp /tmp/jupyterhub/notebooks/default.ipynb /home/jovyan"]
    - display_name: "Image with GPU support and PyTorch library (Jupyterhub)"
      description: "Only runs on nodes with GPUs, fails to start if there is no such node available."
      kubespawner_override:
        image: quay.io/jupyter/pytorch-notebook:cuda12-notebook-7.3.2
        extra_resource_limits:
          nvidia.com/gpu: 1
        lifecycle_hooks:
          postStart:
            exec:
              command: ["/bin/sh", "-c", "cat /home/jovyan/default.ipynb || cp /tmp/jupyterhub/notebooks/default.ipynb /home/jovyan"]
```

#### Network egress (allow all namespaces + private IPs)
```yaml
singleuser:
  networkPolicy:
    egress:
      - to:
          - namespaceSelector: {}
    egressAllowRules:
      privateIPs: true
```

#### Sudo/root access
```yaml
singleuser:
  extraEnv:
    GRANT_SUDO: "yes"
    NOTEBOOK_ARGS: "--allow-root"
  allowPrivilegeEscalation: true
  uid: 0
```

#### Storage (50Gi + default-notebooks configmap)
```yaml
singleuser:
  storage:
    capacity: 50Gi
    extraVolumes:
      - name: pytorch-notebook
        configMap:
          name: default-notebooks
    extraVolumeMounts:
      - name: pytorch-notebook
        mountPath: /tmp/jupyterhub/notebooks
        readOnly: false
```

### 4. Update `manifest.yaml`
Update all image tags in `imagesMapping` to match the new versions from the upstream `Chart.yaml` annotations.

### 5. Run helm dependency update
```bash
cd chart && helm dependency update .
```
This pulls the `tunna-agent` chart dependency.

### 6. Verify
```bash
helm lint chart/
diff -rq chart/ /tmp/jupyterhub-upstream/jupyterhub/ --exclude='.DS_Store'
```
The only differences should be:
- `values.yaml` — marketplace customizations listed above
- `files/notebooks/` — custom directory (not in upstream)
- `templates/default-notebooks-configmap.yaml` — custom template (not in upstream)

### Files that do NOT need customization
These are taken directly from upstream without changes:
- `README.md`, `.helmignore`
- `files/hub/jupyterhub_config.py`, `files/hub/z2jh.py`
- All templates (except `default-notebooks-configmap.yaml` which is custom)

### Files with marketplace-only changes (not in upstream)
- `Chart.yaml` — has `tunna-agent` dependency added
- `values.schema.json` — has `tunna-agent` property added to allow the dependency config

## Tunna Integration
JupyterHub uses Tunna for secure access instead of direct LoadBalancer exposure. The `graph.yaml` creates a service account, RSA key pair, access binding, and application tunnel with service name `jupyterhub`.

The tunna-agent targets `proxy-public:80` — this is the actual k8s service name (JupyterHub chart does NOT prefix service names with the release name).

## registry.k8s.io Images Workaround

Images from `registry.k8s.io` (kube-scheduler, pause) must be mirrored to the Nebius container registry and referenced by their mirrored path in `values.yaml` instead of the upstream `registry.k8s.io` path.

This applies to: `scheduling.userScheduler.image.name`, `scheduling.userPlaceholder.image.name`, `prePuller.pause.image.name`.

The `imagesMapping` in `manifest.yaml` must also use the mirrored registry path as both source and destination for these images.
