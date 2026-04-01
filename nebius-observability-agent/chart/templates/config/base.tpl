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
    {{- if and .Values.config.feature_flags (hasKey .Values.config.feature_flags "fix_for_short_living_jobs") .Values.config.feature_flags.fix_for_short_living_jobs.enabled }}
    list_only_running_pods: false
    target_for_pod: podName
    target_for_pod_time_filter: ${env:FIX_SHORT_JOBS_TIME_FILTER}
    {{- end }}

  pprof:

  goruntimemetrics:

  agentdiskcleanupextension:
    metrics_period: 1m
    directory: {{ include "o11y-agent.config.persistent-dir" . }}

  zpages:

  health_check:
    endpoint: ':13133'
    path: /health

  file_storage/filelog:
    directory: {{ include "o11y-agent.config.persistent-dir" . }}
    timeout: 1s
    compaction:
      on_start: true
      on_rebound: true
      directory: {{ include "o11y-agent.config.persistent-dir" . }}

receivers:
{{- include "o11y-agent.config.receivercreator" . | nindent 2 }}
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
        max_recv_msg_size_mib: 8
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
  nebius/traces:
    endpoint: dns:///write.tracing.{{ include "o11y-agent.config.region" . }}.nebius.cloud:443

    auth:
    {{- if .Values.config.iam.enabled  }}
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
{{- include "o11y-agent.config.container-image-statements" . | nindent 10 }}
          - set(attributes["k8s.cluster.id"], "${env:CLUSTER_ID}")
          - set(attributes["k8s.node_group.id"], "${env:NODE_GROUP_ID}")
    trace_statements:
      - context: resource
        statements:
{{- include "o11y-agent.config.container-image-statements" . | nindent 10 }}
          - set(attributes["k8s.cluster.id"], "${env:CLUSTER_ID}")
          - set(attributes["k8s.node_group.id"], "${env:NODE_GROUP_ID}")
  memory_limiter:
    check_interval: 5s
    limit_percentage: 90
    spike_limit_percentage: 5

{{- include "o11y-agent.config.k8sattributes" (dict "root" . "type" "logs") | nindent 2 }}
{{- include "o11y-agent.config.k8sattributes" (dict "root" . "type" "traces") | nindent 2 }}

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
                    with_resource_constant_labels:
                      included:
                        - "release.version"
          views:
            - selector:
                instrument_name: otelcol_receiver_accepted_log_records
              stream:
                attribute_keys:
                  excluded:
                    - receiver
            - selector:
                instrument_name: otelcol_receiver_refused_log_records
              stream:
                attribute_keys:
                  excluded:
                    - receiver
            - selector:
                instrument_name: otelcol_receiver_failed_log_records
              stream:
                attribute_keys:
                  excluded:
                    - receiver

        # remove redundant metric labels
        resource:
            service.instance.id: ~
            service.name: ~
            release.version:  {{ .Chart.Version | quote }}
{{- end -}}

{{- define "o11y-agent.config.k8sattributes" -}}
k8sattributes/{{ .type }}:
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
{{- if eq .type "traces" }}
        - k8s.pod.ip
{{- end }}
        - k8s.pod.start_time
        - container.image.tag
        - container.image.repo_digests
{{- end -}}

