# ClickHouse Marketplace Product

For internal operations (publishing, mirroring, debugging), see `products/AGENTS.md` in the monorepo.

## Upstream Source
- Chart: [bitnami/clickhouse](https://github.com/bitnami/charts/tree/main/bitnami/clickhouse)
- Helm repo: `https://charts.bitnami.com/bitnami`
- Current version: **9.4.4** (appVersion 25.7.5)

## Bitnami Image Migration (Important)

Bitnami removed all container images from `docker.io/bitnami/` (see [bitnami/charts#35164](https://github.com/bitnami/charts/issues/35164)). Images are now at:
- **Legacy (free, no updates):** `docker.io/bitnamilegacy/<image>`
- **Secure (paid):** `docker.io/bitnamisecure/<image>`

When updating, change `repository: bitnami/<image>` to `repository: bitnamilegacy/<image>` in `values.yaml` for all images.

## How to Update the Helm Chart

### 1. Pull the new upstream chart
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update bitnami
helm search repo bitnami/clickhouse --versions
helm pull bitnami/clickhouse --version <NEW_VERSION> --untar --untardir /tmp/clickhouse-upstream
```

### 2. Replace the chart directory entirely
```bash
rm -rf chart && cp -r /tmp/clickhouse-upstream/clickhouse chart
```

### 3. Re-apply marketplace customizations to `values.yaml`

#### Allow insecure images
```yaml
global:
  security:
    allowInsecureImages: true   # upstream default is false
```

#### Change image repositories from bitnami to bitnamilegacy
Replace all `repository: bitnami/` with `repository: bitnamilegacy/` in values.yaml. Current images:
- `image.repository: bitnamilegacy/clickhouse`
- `keeper.image.repository: bitnamilegacy/clickhouse-keeper`
- `defaultInitContainers.volumePermissions.image.repository: bitnamilegacy/os-shell`

### 4. Run helm dependency update
```bash
cd chart && helm dependency update .
```

### 5. Lint and publish
See common instructions in [products/AGENTS.md](../../AGENTS.md).

## Customizations vs Upstream
- `global.security.allowInsecureImages: true` (upstream: `false`)
- All image repositories changed from `bitnami/` to `bitnamilegacy/` (Bitnami removed images from public registry)

No template modifications. No custom files. The chart is a clean copy of the Bitnami upstream with image repository overrides.
