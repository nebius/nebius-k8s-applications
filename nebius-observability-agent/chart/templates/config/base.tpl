{{- define "o11y-agent.baseconfig" -}}

extensions:
{{- include "o11y-agent.config.metrics.extensions" . | nindent 2 }}
  nebiusiamauth:
    auth_scheme: {{ .Values.config.iam.auth_scheme | default "iam-token-file" }}
    iam_token_file: {{ .Values.config.iam.token_file }}
    iam_endpoint: {{ .Values.config.iam.endpoint }}
    {{- if eq .Values.config.iam.auth_scheme "iam-credentials-file"}}
    credentials_file_path: /etc/iam-key/{{ .Values.config.iam.credentials_file_secret_key}}
    {{ end }}

  k8s_observer:
    auth_type: serviceAccount
    node: ${env:K8S_NODE_NAME}
    observe_pods: true
    observe_nodes: false
    observe_services: false
#    list_only_running_pods: false
#    target_for_pod: podName

  pprof:

  goruntimemetrics:

  zpages:

  health_check:
    endpoint: ':13133'
    path: /health

  file_storage/filelog:
    directory: {{ .Values.config.persistentDir | default "/var/lib/nebius-o11y-agent" }}
    timeout: 1s
    compaction:
      on_start: true
      on_rebound: true
      directory: {{ .Values.config.persistentDir | default "/var/lib/nebius-o11y-agent" }}

receivers:
{{- include "o11y-agent.config.receivercreator" . | nindent 2 }}
{{- include "o11y-agent.config.metrics.receivers" . | nindent 2 }}

exporters:
{{- include "o11y-agent.config.metrics.exporters" . | nindent 2 }}
  nebius/logging:
    endpoint: dns:///write.logging.{{ include "o11y-agent.config.region" . }}.nebius.cloud:443

    auth:
    {{- if .Values.config.iam.enabled }}
      authenticator: nebiusiamauth
    {{- end }}
{{ include "o11y-agent.config.grpc-common-options" . }}

processors:
  logcounter:

  nebiusbatch:
{{- include "o11y-agent.config.metrics.processors" . | nindent 2 }}

  transform/set_attributes:
    error_mode: ignore
    metric_statements:
      - context: resource
        statements:
          - set(attributes["k8s.cluster.id"], "${env:CLUSTER_ID}")
          - set(attributes["k8s.node_group.id"], "${env:NODE_GROUP_ID}")

    log_statements:
      - context: resource
        statements:
          - set(attributes["k8s.cluster.id"], "${env:CLUSTER_ID}")
          - set(attributes["k8s.node_group.id"], "${env:NODE_GROUP_ID}")

  memory_limiter:
    check_interval: 5s
    limit_percentage: 90
    spike_limit_percentage: 5

  k8sattributes:
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
      labels:
        - tag_name: app.kubernetes.io/name
          key: app.kubernetes.io/name
          from: pod
      metadata:
        - k8s.namespace.name
        - k8s.deployment.name
        - k8s.statefulset.name
        - k8s.daemonset.name
        - k8s.cronjob.name
        - k8s.job.name
        - k8s.node.name
        - k8s.pod.name
        - k8s.pod.start_time
        - container.image.tag

service:
    telemetry:
        metrics:
          level: "Detailed"
          readers:
            - pull:
                exporter:
                  prometheus:
                    host: '0.0.0.0'
                    port: {{ .Values.config.ports.metrics }}
                    without_units: true
                    without_type_suffix: true

        # remove redundant metric labels
        resource:
            service.instance.id: ~
            service.name: ~
            release.version:  {{ .Chart.Version | quote }}
{{- end -}}
