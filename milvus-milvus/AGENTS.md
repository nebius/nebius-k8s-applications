# Milvus Marketplace Product

For internal operations (publishing, mirroring, debugging), see `products/AGENTS.md` in the monorepo.

## Upstream Source
- Chart: [zilliztech/milvus-helm](https://github.com/zilliztech/milvus-helm) (`charts/milvus/` directory)
- Current version: **5.0.16** (appVersion 2.6.13)

## How to Update the Helm Chart

### 1. Pull the new upstream chart
```bash
git clone https://github.com/zilliztech/milvus-helm.git /tmp/milvus-helm
cd /tmp/milvus-helm
git checkout milvus-<NEW_VERSION>
```

### 2. Replace the chart directory entirely
```bash
rm -rf chart && cp -r /tmp/milvus-helm/charts/milvus chart
```

### 3. Re-apply marketplace customizations to `values.yaml`

#### Image repositories
Replace all image `repository:` values from Docker Hub to the Nebius registry. The pattern is:
- `milvusdb/<image>` → `cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/milvus/<image>`
- `zilliz/<image>` → `cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/milvus/<image>`
- `apachepulsar/<image>` → `cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/milvus/<image>`
- `bitnami/<image>` or `bitnamilegacy/<image>` → `cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/milvus/<image>`
- `minio/<image>` → `cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/milvus/<image>`

This applies to all image fields: top-level (`image.all`, `image.tools`, `heaptrack`, `attu`), dependency images (`etcd`, `minio`, `pulsar`, `kafka`), and `internal_images.*` entries.

#### Nebius-specific defaults
```yaml
cluster:
  enabled: false        # upstream default is true in 5.x
pulsar:
  enabled: false
gpu_number: 0
gpu-operator:
  enabled: false
```

### 4. Add gpu-operator dependency
Add to `Chart.yaml` (or `requirements.yaml`, whichever upstream uses for dependencies):
```yaml
- condition: gpu-operator.enabled
  name: gpu-operator
  repository: oci://cr.eu-north1.nebius.cloud/marketplace/nebius/nvidia-gpu-operator/chart
  version: v25.3.2
```

### 5. Update `manifest.yaml`
Update the `images:` section to match the new `values.yaml` structure. Remove entries for deleted image keys, add entries for new images. Each entry maps a `tag` and `nameWithRegistry` path in `values.yaml`.

### 6. Lint and publish
```bash
helm lint chart/
```
See common instructions in [products/AGENTS.md](../../AGENTS.md).

## Customizations vs Upstream
- All image repositories changed from Docker Hub to `cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/milvus/`
- `gpu-operator` dependency added (Nebius-specific, not in upstream)
- `cluster.enabled: false` (upstream defaults to true)
- `pulsar.enabled: false` (standalone uses rocksmq by default)
- `gpu_number: 0` and `gpu-operator.enabled: false`

No template modifications. Bundled sub-charts (etcd, minio, pulsar, kafka) in `chart/charts/` come directly from upstream — do not modify individually.
