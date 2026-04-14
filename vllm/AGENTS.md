# vLLM Marketplace Product

For internal operations (publishing, mirroring, debugging), see `products/AGENTS.md` in the monorepo.

## Upstream Source
- Project: [vllm-project/vllm](https://github.com/vllm-project/vllm)
- Current image: `vllm/vllm-openai:v0.8.5-ray` (custom build with `ray[default]`)
- KubeRay operator: `v1.2.2` (bundled subchart from [ray-project/kuberay](https://github.com/ray-project/kuberay))

Note: The vLLM Helm chart is **custom-built** (not pulled from an upstream Helm repo). It uses a RayService to deploy vLLM workers via KubeRay.

## How to Update the vLLM Image

### 1. Build a custom image with ray[default]

Since vLLM v0.8.x, the `vllm-openai` image ships with minimal Ray (no dashboard dependencies). KubeRay requires the Ray dashboard on port 8265 to deploy Serve applications. You **must** build a custom image that includes `ray[default]`.

See [vllm-project/vllm#16779](https://github.com/vllm-project/vllm/issues/16779) for context.

```bash
REGISTRY="cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/vllm"
NEW_VERSION="<NEW_VERSION>"

# Build custom image
mkdir -p /tmp/vllm-build
cat <<EOF > /tmp/vllm-build/Dockerfile
FROM vllm/vllm-openai:${NEW_VERSION}
RUN pip install --no-cache-dir 'ray[default]'
EOF

docker build --platform linux/amd64 -t $REGISTRY/vllm-openai:${NEW_VERSION}-ray /tmp/vllm-build
docker push $REGISTRY/vllm-openai:${NEW_VERSION}-ray
```

### 2. Bump the image tag
In `chart/values.yaml`, update:
```yaml
image:
  repository: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/vllm/vllm-openai
  tag: <NEW_VERSION>-ray
```

### 3. Update `manifest.yaml`
Update `imagesMapping` with the new tag:
```yaml
imagesMapping:
  vllm/vllm-openai:<NEW_VERSION>-ray:
    dst: cr.eu-north1.nebius.cloud/e00vzg8t0148cc4zex/nebius/vllm/vllm-openai:<NEW_VERSION>-ray
```

### 4. Check vLLM CLI argument changes
vLLM CLI args change between versions. The `chart/files/serve.py` `parse_vllm_args()` function converts YAML config keys to CLI args:
- Keys with `null` value → passed as flags (`--key`)
- Keys with non-null value → passed as `--key value`

**Check that boolean flags in `values.yaml` use null, not `true`:**
```yaml
# CORRECT — passed as --enable-chunked-prefill (flag)
enable-chunked-prefill:

# WRONG — passed as --enable-chunked-prefill True (rejected by vLLM v0.8.5+)
enable-chunked-prefill: true
```

### 5. Check Ray/KubeRay compatibility
Verify the KubeRay operator version (`v1.2.2`) is still compatible with the new vLLM version. If not, update the kuberay-operator subchart in `chart/charts/kuberay-operator/`.

### 6. Lint and publish
```bash
helm lint chart/
```
See common instructions in [products/AGENTS.md](../../AGENTS.md).

## Marketplace Customizations

This chart is entirely custom — there is no upstream Helm chart to diff against. Key components:

| Component | Description |
|-----------|-------------|
| `chart/values.yaml` | GPU platform resource mapping (H100, H200, B200, L40S), image references, vLLM config |
| `chart/templates/rayService.yaml` | RayService with head + worker groups, serve.py deployment |
| `chart/templates/deployment.yaml` | Wait-pod that monitors vLLM startup via health probes (curl to serve-svc) |
| `chart/templates/configMap.yaml` | serve.py.zip + vllm_config.yaml |
| `chart/templates/secret.yaml` | HF_TOKEN and other env vars |
| `chart/charts/gradio-ui/` | Custom Gradio UI subchart (not upstream) |
| `chart/charts/kuberay-operator/` | KubeRay operator subchart (v1.2.2) |
| `chart/files/serve.py` | Ray Serve application with OpenAI-compatible /v1/chat/completions endpoint |

## GPU Platform Support

| Platform | CPU per GPU | Memory per GPU | Node selector |
|----------|------------|----------------|---------------|
| H100 NVLink | 14500m | 190Gi | `gpu-h100-sxm` |
| H200 NVLink | 14500m | 190Gi | `gpu-h200-sxm` |
| B200 NVLink | 14500m | 214Gi | `gpu-b200-sxm` |
| L40S Intel | 4000m | 8Gi | `gpu-l40s-a` |
| L40S AMD | 8000m | 48Gi | `gpu-l40s-d` |

## Cluster Requirements

- **GPU node group** with one of the supported platforms
- **CPU node group** recommended for the Ray head pod (prefers non-GPU nodes via soft affinity)
- **NVIDIA GPU Operator** must be installed before vLLM
- Boot disk should have enough space for model downloads (100Gi+ for large models)

## Tunna Integration

vLLM uses Tunna for secure HTTP/2 tunnel access to both the OpenAI-compatible API and the Gradio UI.

### How it works
- `graph.yaml` creates the tunnel infrastructure: service account, IAM binding, RSA key pair, and application tunnel with two services
- The `tunna-agent` Helm sub-chart is added as a dependency in `Chart.yaml` (version 0.1.1, from `oci://cr.eu-north1.nebius.cloud/marketplace/chart`)
- `tunna-agent` is disabled by default in `values.yaml` (`enabled: false`) — it's enabled via `graph.yaml` which injects the tunnel config at deploy time
- Service targets:
  - **vLLM API**: `<release-name>-serve-svc:8000` — the RayService serve endpoint
  - **Gradio UI**: `<release-name>-gradio-ui:7860` — the Gradio web interface

### When updating the chart
After any chart changes, you must preserve:
1. The `tunna-agent` dependency in `Chart.yaml`
2. The `tunna-agent` default config block at the end of `values.yaml`
3. Run `helm dependency update chart/` to pull the tunna-agent chart

## Known Issues

### vLLM v0.8.x missing Ray dashboard dependencies
The `vllm-openai` image since v0.8.x doesn't include `ray[default]` (missing `aiohttp_cors`). The Ray dashboard HTTP server won't start, and KubeRay can't deploy Serve applications. **Always use the custom `-ray` tagged image** that adds `ray[default]`. See step 1 in "How to Update".

### Boolean CLI flags
vLLM v0.8.5+ uses argparse boolean flags (`--enable-chunked-prefill` / `--no-enable-chunked-prefill`). Setting `enable-chunked-prefill: true` in the YAML config causes `serve.py` to pass `--enable-chunked-prefill True` which is rejected. Use `null` value for boolean flags.
