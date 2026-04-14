# Headlamp Marketplace Product

For internal operations (publishing, mirroring, debugging), see `products/AGENTS.md` in the monorepo.

## Upstream Source
- Chart: [kubernetes-sigs/headlamp](https://github.com/kubernetes-sigs/headlamp/tree/main/charts/headlamp)
- Helm repo: `https://kubernetes-sigs.github.io/headlamp/`
- Current version: **0.41.0** (appVersion 0.41.0)

## How to Update the Helm Chart

### 1. Pull the new upstream chart
```bash
helm repo update headlamp
helm search repo headlamp/headlamp --versions
helm pull headlamp/headlamp --version <NEW_VERSION> --untar --untardir /tmp/headlamp-upstream
```

### 2. Update the dependency version
In `chart/Chart.yaml`, bump the headlamp dependency version.

### 3. Check image changes
The upstream image is `ghcr.io/headlamp-k8s/headlamp`. Mirror the new version:
```bash
REGISTRY="cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/headlamp"

docker pull --platform linux/amd64 ghcr.io/headlamp-k8s/headlamp:<NEW_VERSION>
docker tag ghcr.io/headlamp-k8s/headlamp:<NEW_VERSION> $REGISTRY/headlamp:<NEW_VERSION>
docker push $REGISTRY/headlamp:<NEW_VERSION>
```

### 4. Update values.yaml
Update the image tag in `chart/values.yaml`.

### 5. Update manifest.yaml
Update `imagesMapping` with the new tag.

### 6. Run helm dependency update
```bash
cd chart && helm dependency update .
```

### 7. Lint and publish
```bash
helm lint chart/
```
See common instructions in [products/AGENTS.md](../../AGENTS.md).

## Marketplace Customizations

This is a **wrapper chart** around the upstream headlamp chart. Customizations in `values.yaml`:
- `config.inCluster: true` — runs inside the cluster
- `service.type: ClusterIP` — Tunna handles external access
- Image redirected to Nebius registry

No template modifications. Single image (`headlamp-k8s/headlamp`).

## Tunna Integration

Headlamp uses Tunna for secure HTTP/2 tunnel access to the web UI.

### How it works
- `graph.yaml` creates the tunnel infrastructure
- Service target: `<release-name>-headlamp:80`
- Single tunnel service: `headlamp`
- `tunna-agent` disabled by default, enabled via `graph.yaml`

### When updating the chart
After updating the upstream dependency, preserve:
1. The `tunna-agent` dependency in `Chart.yaml`
2. The `tunna-agent` default config in `values.yaml`
3. Run `helm dependency update chart/`
