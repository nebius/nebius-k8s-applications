# preprocess public-file
{{- define "o11y-agent.config.metrics.receivers" -}}
# Prometheus receiver that collects metrics from multiple Kubernetes targets:
# - kubernetes-service-endpoints: Services with prometheus.io/scrape annotation (normal and slow)
# - kubernetes-pods: Pods with prometheus.io/scrape annotation (normal and slow)
# - kubernetes-apiservers: Kubernetes API server metrics (if collectK8sClusterMetrics enabled)
# - kubernetes-nodes: Node metrics via kubelet /metrics endpoint (if collectK8sClusterMetrics enabled)
# - kubernetes-nodes-cadvisor: Container metrics via kubelet /metrics/cadvisor endpoint (if collectK8sClusterMetrics enabled)
# - hubble: Cilium Hubble network observability metrics (if collectK8sClusterMetrics enabled)
# - additionalTargets: User-defined custom scrape targets (if configured)
prometheus/k8smetrics:
  api_server:
    enabled: true
    server_config:
      endpoint: "0.0.0.0:8080"
  config:
    scrape_configs:
    - honor_labels: true
      job_name: kubernetes-service-endpoints
      kubernetes_sd_configs:
      - role: endpoints
      relabel_configs:
{{- if .Values.config.metrics.excludedNamespaces }}
      - source_labels: [__meta_kubernetes_namespace]
        action: drop
        regex: {{ join "|" .Values.config.metrics.excludedNamespaces }}
{{- end }}
{{- if not .Values.config.metrics.collectK8sClusterMetrics }}
      - source_labels: [__meta_kubernetes_namespace]
        action: drop
        regex: kube-system
{{- end }}
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scrape
      - action: drop
        regex: true
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scrape_slow
      - action: replace
        regex: (https?)
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scheme
        target_label: __scheme__
      - action: replace
        regex: (.+)
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_path
        target_label: __metrics_path__
      - action: replace
        regex: (.+?)(?::\d+)?;(\d+)
        replacement: $$$1:$$$2
        source_labels:
        - __address__
        - __meta_kubernetes_service_annotation_prometheus_io_port
        target_label: __address__
      - action: labelmap
        regex: __meta_kubernetes_service_annotation_prometheus_io_param_(.+)
        replacement: __param_$$$1
      - action: labelmap
        regex: __meta_kubernetes_service_label_(.+)
      - action: replace
        source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - action: replace
        source_labels:
        - __meta_kubernetes_service_name
        target_label: service
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_node_name
        target_label: node
      - source_labels: [__meta_kubernetes_pod_node_name]
        action: keep
        regex: ${env:K8S_NODE_NAME}
    - honor_labels: true
      job_name: kubernetes-service-endpoints-slow
      kubernetes_sd_configs:
      - role: endpoints
      relabel_configs:
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scrape_slow
      - action: replace
        regex: (https?)
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scheme
        target_label: __scheme__
      - action: replace
        regex: (.+)
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_path
        target_label: __metrics_path__
      - action: replace
        regex: (.+?)(?::\d+)?;(\d+)
        replacement: $$$1:$$$2
        source_labels:
        - __address__
        - __meta_kubernetes_service_annotation_prometheus_io_port
        target_label: __address__
      - action: labelmap
        regex: __meta_kubernetes_service_annotation_prometheus_io_param_(.+)
        replacement: __param_$$$1
      - action: labelmap
        regex: __meta_kubernetes_service_label_(.+)
      - action: replace
        source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - action: replace
        source_labels:
        - __meta_kubernetes_service_name
        target_label: service
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_node_name
        target_label: node
      - source_labels: [__meta_kubernetes_pod_node_name]
        action: keep
        regex: ${env:K8S_NODE_NAME}
      scrape_interval: 5m
      scrape_timeout: 30s
    - honor_labels: true
      job_name: kubernetes-pods
      kubernetes_sd_configs:
      - role: pod
      relabel_configs:
      - source_labels: [__meta_kubernetes_pod_node_name]
        action: keep
        regex: ${env:K8S_NODE_NAME}
{{- if .Values.config.metrics.excludedNamespaces }}
      - source_labels: [__meta_kubernetes_namespace]
        action: drop
        regex: {{ join "|" .Values.config.metrics.excludedNamespaces }}
{{- end }}
{{- if not .Values.config.metrics.collectK8sClusterMetrics }}
      - source_labels: [__meta_kubernetes_namespace]
        action: drop
        regex: kube-system
{{- end }}
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scrape
      - action: replace
        regex: (https?)
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scheme
        target_label: __scheme__
      - action: replace
        regex: (.+)
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_path
        target_label: __metrics_path__
      - action: replace
        regex: (\d+);(([A-Fa-f0-9]{1,4}::?){1,7}[A-Fa-f0-9]{1,4})
        replacement: '[$$$2]:$$$1'
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_port
        - __meta_kubernetes_pod_ip
        target_label: __address__
      - action: replace
        regex: (\d+);((([0-9]+?)(\.|$)){4})
        replacement: $$$2:$$$1
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_port
        - __meta_kubernetes_pod_ip
        target_label: __address__
      - action: labelmap
        regex: __meta_kubernetes_pod_annotation_prometheus_io_param_(.+)
        replacement: __param_$$$1
      - action: labelmap
        regex: __meta_kubernetes_pod_label_(.+)
      - action: replace
        source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_name
        target_label: pod
      - action: drop
        regex: Pending|Succeeded|Failed|Completed
        source_labels:
        - __meta_kubernetes_pod_phase
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_node_name
        target_label: node
      scrape_interval: 15s
      scrape_timeout: 10s
    - honor_labels: true
      job_name: kubernetes-pods-slow
      kubernetes_sd_configs:
      - role: pod
      relabel_configs:
      - source_labels: [__meta_kubernetes_pod_node_name]
        action: keep
        regex: ${env:K8S_NODE_NAME}
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scrape_slow
      - action: replace
        regex: (https?)
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scheme
        target_label: __scheme__
      - action: replace
        regex: (.+)
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_path
        target_label: __metrics_path__
      - action: replace
        regex: (\d+);(([A-Fa-f0-9]{1,4}::?){1,7}[A-Fa-f0-9]{1,4})
        replacement: '[$$$2]:$$$1'
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_port
        - __meta_kubernetes_pod_ip
        target_label: __address__
      - action: replace
        regex: (\d+);((([0-9]+?)(\.|$)){4})
        replacement: $$$2:$$$1
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_port
        - __meta_kubernetes_pod_ip
        target_label: __address__
      - action: labelmap
        regex: __meta_kubernetes_pod_annotation_prometheus_io_param_(.+)
        replacement: __param_$$$1
      - action: labelmap
        regex: __meta_kubernetes_pod_label_(.+)
      - action: replace
        source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_name
        target_label: pod
      - action: drop
        regex: Pending|Succeeded|Failed|Completed
        source_labels:
        - __meta_kubernetes_pod_phase
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_node_name
        target_label: node
      scrape_interval: 5m
      scrape_timeout: 30s
{{- if .Values.config.metrics.collectK8sClusterMetrics }}
    - bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      job_name: kubernetes-apiservers
      kubernetes_sd_configs:
      - role: endpoints
      relabel_configs:
      - action: keep
        regex: default;kubernetes;https
        source_labels:
        - __meta_kubernetes_namespace
        - __meta_kubernetes_service_name
        - __meta_kubernetes_endpoint_port_name
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        server_name: kubernetes.default.svc
    - bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      job_name: kubernetes-nodes
      kubernetes_sd_configs:
      - role: node
      relabel_configs:
      - action: labelmap
        regex: __meta_kubernetes_node_label_(.+)
      - replacement: kubernetes.default.svc:443
        target_label: __address__
      - regex: (.+)
        replacement: /api/v1/nodes/$$$1/proxy/metrics
        source_labels:
        - __meta_kubernetes_node_name
        target_label: __metrics_path__
      - source_labels: [__meta_kubernetes_node_name]
        action: keep
        regex: ${env:K8S_NODE_NAME}
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    - bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      job_name: kubernetes-nodes-cadvisor
      kubernetes_sd_configs:
      - role: node
      relabel_configs:
      - action: labelmap
        regex: __meta_kubernetes_node_label_(.+)
      - replacement: kubernetes.default.svc:443
        target_label: __address__
      - regex: (.+)
        replacement: /api/v1/nodes/$$$1/proxy/metrics/cadvisor
        source_labels:
        - __meta_kubernetes_node_name
        target_label: __metrics_path__
      - source_labels: [__meta_kubernetes_node_name]
        action: keep
        regex: ${env:K8S_NODE_NAME}
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    - job_name: 'hubble'
      kubernetes_sd_configs:
      - role: endpoints
        namespaces:
          names:
          - kube-system
      relabel_configs:
      - source_labels: [__meta_kubernetes_service_label_k8s_app]
        regex: hubble
        action: keep
      - source_labels: [__meta_kubernetes_endpoint_port_name]
        regex: hubble-metrics
        action: keep
      - source_labels: [__meta_kubernetes_pod_node_name]
        action: keep
        regex: ${env:K8S_NODE_NAME}
      - source_labels: [__meta_kubernetes_pod_node_name]
        regex: (.+)
        replacement: $$$1
        target_label: node
      - source_labels: [__meta_kubernetes_service_name]
        target_label: service
      - source_labels: [__meta_kubernetes_namespace]
        target_label: namespace
      metrics_path: /metrics
      scheme: http
      honor_labels: true
      scrape_interval: 15s
{{end}}
{{- if .Values.config.metrics.additionalTargets }}
{{- range .Values.config.metrics.additionalTargets }}
    - {{ . | toYaml | nindent 6 }}
{{- end }}
{{- end }}
{{end}}


{{- define "o11y-agent.config.metrics.exporters"}}
otlphttp/k8smetrics:
  metrics_endpoint: "https://write.monitoring.{{ include "o11y-agent.config.region" . }}.nebius.cloud/projects/{{ include "o11y-agent.config.parent-id" . }}/opentelemetry/v1/metrics"
  disable_keep_alives: true
  retry_on_failure:
      enabled: true
      max_elapsed_time: 0
  sending_queue:
      enabled: true
      storage: db_storage/psq
  auth:
      authenticator: nebiusiamauth
{{end}}

{{- define "o11y-agent.config.metrics.processors"}}
metricslabeldeduplicator:

k8sattributes/metrics:
    filter:
        node_from_env_var: K8S_NODE_NAME
    wait_for_metadata: true
    wait_for_metadata_timeout: 30s
    pod_association:
      - sources:
          - from: resource_attribute
            name: k8s.pod.ip
      - sources:
          - from: resource_attribute
            name: k8s.pod.uid
      - sources:
          - from: connection
    extract:
      metadata:
      - k8s.pod.ip
      - k8s.pod.start_time
      - k8s.deployment.name
      - k8s.daemonset.name
      - k8s.statefulset.name
      - k8s.cronjob.name
      - k8s.job.name
      - k8s.container.name
transform/add_node:
    error_mode: ignore
    metric_statements:
      - context: resource
        statements:
        - set(attributes["k8s.node.name"], "${env:K8S_NODE_NAME}" )
transform/exclude_service_name:
    error_mode: ignore
    metric_statements:
      - context: resource
        statements:
        - delete_key(attributes, "service.name")
        - delete_key(attributes, "service.instance.id")
        - delete_key(attributes, "net.host.port")
        - delete_key(attributes, "url.scheme")
        - delete_key(attributes, "http.scheme")
        - delete_key(attributes, "server.port")
        - delete_key(attributes, "net.host.name")
        - delete_key(attributes, "server.address")
batch/metrics:
    timeout: 15s
{{end}}

{{- define "o11y-agent.config.metrics.pipelines"}}
metrics:
    receivers:
      - prometheus/k8smetrics
    processors:
       - k8sattributes/metrics
       - transform/set_attributes
       - transform/exclude_service_name
       - metricslabeldeduplicator
       - batch/metrics
    exporters:
        - otlphttp/k8smetrics
{{end}}

{{- define "o11y-agent.config.metrics.extensions-list"}}
- db_storage/psq
{{end}}

{{- define "o11y-agent.config.metrics.extensions"}}
db_storage/psq:
  driver: "sqlite3"
  datasource: "{{ .Values.config.persistentDir | default "/var/lib/nebius-o11y-agent" }}/psq.db?_busy_timeout=10000&_journal=WAL&_sync=NORMAL"
{{end}}
