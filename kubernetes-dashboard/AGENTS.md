# Kubernetes Dashboard Marketplace Product

For internal operations (publishing, mirroring, debugging), see `products/AGENTS.md` in the monorepo.

**Note:** This product is deprecated. Headlamp (`github/headlamp/`) is the recommended replacement.

## Upstream Source
- Chart: [kubernetes/dashboard](https://github.com/kubernetes/dashboard) (deprecated)
- Helm repo: `https://kubernetes.github.io/dashboard/` (returns 404 — repo moved/deprecated)
- Current dependency version: **7.13.0** (likely the last version available)

## Architecture

This is a **wrapper chart** (`kubernetes-dashboard-readonly`) around the upstream `kubernetes-dashboard` chart. The wrapper adds:

| Component | Description |
|-----------|-------------|
| `templates/deployment.yaml` | OpenResty/Nginx reverse proxy that injects ServiceAccount bearer tokens |
| `templates/configmap.yaml` | Nginx config with Lua token injection |
| `templates/service.yaml` | ClusterIP service for the nginx proxy (port 80) |
| `templates/serviceaccount.yaml` | Read-only ServiceAccount (`<release>-ro-sa`) |
| `templates/clusterrole.yaml` | Custom ClusterRole for nodes/PVs/storage classes |
| `templates/clusterrolebinding.yaml` | Binds SA to `view` + custom role |

### Authentication flow
1. User hits `<release>-nginx:80`
2. OpenResty Lua reads projected SA token from `/var/run/secrets/kubernetes.io/serviceaccount/token`
3. Injects `Authorization: Bearer <token>` header
4. Proxies to `<release>-kong-proxy:443` (upstream dashboard gateway)
5. Token auto-rotates every 3600s

## Tunna Integration

- Service target: `<release-name>-nginx:80`
- Single tunnel service: `kubernetes-dashboard`
- `tunna-agent` dependency in `Chart.yaml` (0.1.1, OCI)
- Disabled by default, enabled via `graph.yaml`

## How to Update

Since the upstream Helm repo is deprecated, updates are unlikely. If needed:
1. Download the chart manually from GitHub releases
2. Update the dependency version in `chart/Chart.yaml`
3. Re-add `tunna-agent` dependency
4. Run `helm dependency update chart/`
5. Lint and publish
