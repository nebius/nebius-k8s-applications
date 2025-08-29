# preprocess public-file
{{- define "o11y-agent.main-pipeline-config" -}}
extensions:
  - nebiusiamauth
  - health_check
  - k8s_observer
  - file_storage/filelog
  - pprof
  - zpages
  - goruntimemetrics
{{- include "o11y-agent.config.metrics.extensions-list" . | nindent 2 }}

{{- if .Values.config.logs.enabled }}
pipelines:
    logs:
      receivers:
        - receiver_creator
      processors:
        - memory_limiter
        - logcounter
        - k8sattributes
        - transform/set_attributes
        - nebiusbatch
      exporters:
        - nebius/logging
{{ end }}

{{- if .Values.config.metrics.enabled }}
{{- include "o11y-agent.config.metrics.pipelines" . | nindent 4 }}
{{- end }}

{{- end -}}
