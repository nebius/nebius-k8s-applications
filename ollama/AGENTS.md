# Ollama Marketplace Product

For internal operations (publishing, mirroring, debugging), see `products/AGENTS.md` in the monorepo.

## Upstream Source
- Chart: [otwld/ollama-helm](https://github.com/otwld/ollama-helm)
- Helm repo: `https://otwld.github.io/ollama-helm/`
- Current version: **1.54.0** (appVersion 0.19.0)

## How to Update the Helm Chart

### 1. Pull the new upstream chart
```bash
git clone --depth 1 --branch ollama-<NEW_VERSION> https://github.com/otwld/ollama-helm.git /tmp/ollama-helm
```

### 2. Replace the chart directory
The upstream repo is a flat chart (no `charts/` subdirectory). Copy the relevant files:
```bash
rm -rf chart && mkdir chart
cp -r /tmp/ollama-helm/Chart.yaml /tmp/ollama-helm/templates /tmp/ollama-helm/values.yaml chart/
```

### 3. Re-apply marketplace customizations to `values.yaml`

#### Add model parameter (top of file, before `replicaCount`)
```yaml
model: llama3.2
```

#### Set explicit image tag
Upstream defaults to empty tag (uses appVersion). Set it explicitly:
```yaml
image:
  tag: "<NEW_APP_VERSION>"
```

#### Enable GPU by default
```yaml
ollama:
  gpu:
    enabled: true
```

#### Model pull/run defaults
Upstream defaults to empty lists. Keep them empty in values.yaml — the model is injected via `graph.yaml` at deploy time:
```yaml
ollama:
  models:
    pull: []
    run: []
```

#### Enable ingress
```yaml
ingress:
  enabled: true
```

### 4. Update `manifest.yaml`
Update the `imagesMapping` entry with the new image tag:
```yaml
imagesMapping:
  ollama/ollama:<NEW_APP_VERSION>:
    dst: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/ollama/ollama:<NEW_APP_VERSION>
```

### 5. Lint and publish
```bash
helm lint chart/
```
See common instructions in [products/AGENTS.md](../../AGENTS.md).

## Customizations vs Upstream
- `model: llama3.2` — default model, overridden by user via UI form
- `image.tag` set explicitly (upstream defaults to empty/appVersion)
- `ollama.gpu.enabled: true` (upstream: `false`)
- `ollama.models.pull/run` — empty by default, model injected via graph.yaml at deploy time
- `ingress.enabled: true` (upstream: `false`)

No template modifications. Single image (`ollama/ollama`).

## Tunna Integration

Ollama uses Tunna for secure HTTP/2 tunnel access to the Ollama API (port 11434).

### How it works
- `graph.yaml` creates the tunnel infrastructure: service account, IAM binding, RSA key pair, and application tunnel
- The `tunna-agent` Helm sub-chart is added as a dependency in `Chart.yaml` (version 0.1.1, from `oci://cr.eu-north1.nebius.cloud/marketplace/chart`)
- `tunna-agent` is disabled by default in `values.yaml` (`enabled: false`) — it's enabled via `graph.yaml` which injects the tunnel config at deploy time
- Service target: `<release-name>:11434` — the ollama service name matches the Helm release name

### When updating the chart
After replacing the upstream chart files, you must re-add:
1. The `tunna-agent` dependency in `Chart.yaml`
2. The `tunna-agent` default config block at the end of `values.yaml`
3. Run `helm dependency update chart/` to pull the tunna-agent chart
