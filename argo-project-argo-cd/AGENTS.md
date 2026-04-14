# Argo CD Marketplace Product

For internal operations (publishing, mirroring, debugging), see `products/AGENTS.md` in the monorepo.

## Upstream Source
- Chart: [argoproj/argo-helm](https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd)
- Helm repo: `https://argoproj.github.io/argo-helm`
- Current version: **9.5.0** (appVersion v3.3.6)

## How to Update the Helm Chart

### 1. Pull the new upstream chart
```bash
helm repo update argo
helm search repo argo/argo-cd --versions
helm pull argo/argo-cd --version <NEW_VERSION> --untar --untardir /tmp/argo-cd-upstream
```

### 2. Replace the chart directory
```bash
rm -rf chart && cp -r /tmp/argo-cd-upstream/argo-cd chart
```

### 3. Preserve custom templates

After replacing, re-add these marketplace-specific files:

#### `templates/argocd-configs/argocd-admin-password-secret.yaml`
Creates `argocd-initial-admin-secret` from the user-provided plaintext password. If `adminPassword` is empty, Argo CD auto-generates a random password on first boot.

#### Modifications to `templates/argocd-configs/argocd-secret.yaml`
Two changes to support `adminPassword` bcrypt hashing:
1. Add `.Values.adminPassword` to the outer `if` condition (line with `githubSecret`)
2. Add `adminPassword` bcrypt block before the `argocdServerAdminPassword` block:
```yaml
  {{- if .Values.adminPassword }}
  admin.password: {{ bcrypt .Values.adminPassword | b64enc }}
  admin.passwordMtime: {{ dateInZone "2006-01-02T15:04:05Z" (now) "UTC" | b64enc }}
  {{- else if .Values.configs.secret.argocdServerAdminPassword }}
  ...existing code...
  {{- end }}
```

### 4. Re-apply marketplace customizations to `values.yaml`

#### Admin password (top of file)
```yaml
adminPassword: ""
```

#### Image overrides (redirect to Nebius registry)
```yaml
global:
  image:
    repository: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/argo-cd/argocd
    tag: "<APP_VERSION>"

dex:
  image:
    repository: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/argo-cd/dex

redis:
  image:
    repository: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/argo-cd/redis
  exporter:
    image:
      repository: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/argo-cd/redis-exporter

redis-ha:
  image:
    repository: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/argo-cd/redis
  haproxy:
    image:
      repository: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/argo-cd/haproxy
  exporter:
    image: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/argo-cd/redis-exporter
```

**All ECR images must be overridden** — ECR aggressively rate-limits pulls and will cause publish failures.

#### Server insecure mode (Tunna handles TLS)
```yaml
configs:
  params:
    server.insecure: "true"
```

#### Tunna-agent defaults (end of file)
```yaml
tunna-agent:
  enabled: false
  config:
    logging:
      level: error
      format: json
```

### 5. Mirror new container images
```bash
REGISTRY="cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/argo-cd"

# Argo CD
docker pull --platform linux/amd64 quay.io/argoproj/argocd:<APP_VERSION>
docker tag quay.io/argoproj/argocd:<APP_VERSION> $REGISTRY/argocd:<APP_VERSION>
docker push $REGISTRY/argocd:<APP_VERSION>

# Also mirror: dex, redis, redis-exporter, haproxy if versions changed
```

### 6. Update manifest.yaml
Update `imagesMapping` with new tags for all images.

### 7. Add tunna-agent dependency to Chart.yaml
```yaml
- name: tunna-agent
  version: "0.1.1"
  repository: "oci://cr.eu-north1.nebius.cloud/marketplace/chart"
  condition: tunna-agent.enabled
```

### 8. Run helm dependency update
```bash
cd chart && helm dependency update .
```

### 9. Lint and publish
See common instructions in [products/AGENTS.md](../../AGENTS.md).

## Marketplace Customizations

Upstream chart with values overrides + two template modifications:

| Customization | Description |
|--------------|-------------|
| Image overrides | All images redirected to Nebius registry (avoids ECR rate limits) |
| `server.insecure: "true"` | HTTP mode — Tunna handles TLS termination |
| `tunna-agent` dependency | Added for tunnel access |
| `adminPassword` value | Plaintext admin password, set via installation form |
| `argocd-admin-password-secret.yaml` | Custom template — creates initial admin secret with plaintext password |
| `argocd-secret.yaml` modification | Bcrypt hashes `adminPassword` into `argocd-secret` so server uses it directly |

## Tunna Integration

- Service name: `argocd` (no hyphens — critical for Tunna hostname parsing)
- Service target: `<release-name>-argocd-server:80` (insecure/HTTP mode)
- `tunna-agent` disabled by default, enabled via `graph.yaml`

## Admin Password

Users set their admin password in the installation form. The password flows through:
1. `graph.yaml` passes `adminPassword` to Helm values
2. `argocd-admin-password-secret.yaml` creates `argocd-initial-admin-secret` with plaintext (for CLI retrieval)
3. `argocd-secret.yaml` stores bcrypt hash in `admin.password` (for server authentication)

If left empty, Argo CD auto-generates a random password (retrievable via `kubectl get secret argocd-initial-admin-secret`).

## Known Issues

### ECR rate limits
The upstream chart uses `ecr-public.aws.com` for Redis and HAProxy images. All ECR images are mirrored to Nebius registry. When updating, always override ECR image paths.

### Redis HA selector immutability
When upgrading from older versions, the `argocd-redis-ha-haproxy` deployment may fail due to immutable selector labels. Fix: delete the deployment and let it recreate.

## Upgrade Notes (v7.7.5 → v9.5.0)

This was a major upgrade crossing Argo CD v3.0.0. Key changes:
- **configs.params** — most params removed in chart 9.0.0, only `create`/`annotations` + custom keys remain
- **Image registry** — moved from `quay.io` to `ghcr.io` upstream (we override to Nebius registry)
- **Redis** — upgraded to redis-ha 4.34.11, Redis 8.2.x
- **Argo CD v3** — annotation-based resource tracking, RBAC changes, CRDs in templates
- **ECR images** — all mirrored to Nebius registry to avoid rate limit failures
