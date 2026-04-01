# preprocess public-file
{{- define "o11y-agent.main-pipeline-config" -}}
extensions:
  - nebiusiamauth
  - health_check
  - k8s_observer
  - file_storage/filelog
  - pprof
  - goruntimemetrics
  - agentdiskcleanupextension
{{- include "o11y-agent.config.metrics.extensions-list" . | nindent 2 }}

{{- if .Values.config.logs.enabled }}
pipelines:
    logs:
      receivers:
        - receiver_creator
      processors:
        - memory_limiter
        - logcounter
        - k8sattributes/logs
        - transform/set_attributes
        - nebiusbatch
      exporters:
        - nebius/logging
{{ end }}

{{- if .Values.config.metrics.enabled }}
{{- include "o11y-agent.config.metrics.pipelines" . | nindent 4 }}
{{- end }}

{{- if .Values.config.traces.enabled }}
    traces:
      receivers:
        - otlp
      processors:
        - memory_limiter
        - k8sattributes/traces
        - transform/set_attributes
        - nebiusbatch
      exporters:
        - nebius/traces
{{- end }}

{{- end -}}
