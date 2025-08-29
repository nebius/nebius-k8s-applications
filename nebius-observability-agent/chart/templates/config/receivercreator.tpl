{{- define "o11y-agent.config.receivercreator" -}}
  receiver_creator:
    watch_observers: [k8s_observer]
    receivers:
      filelog:
        rule: '{{.Values.config.podLogsDiscoveryRule }}{{ include "o11y-agent.config.logs-namespace-filter" . }}{{ include "o11y-agent.config.logs-namespace-filter" . }}'
        config:
          include: [ '/var/log/pods/`namespace`_`name`_`"kubernetes.io/config.mirror" in annotations ? "*" : uid`/*/*']
          exclude:
           - '/var/log/pods/`namespace`_`name`_*/*/*.gz'
           - '/var/log/pods/`namespace`_`name`_*/*/*.tmp'
          start_at: beginning
          force_flush_period: 1m
          include_file_name: false
          include_file_path: true
          storage: file_storage/filelog
          retry_on_failure:
            enabled: true
          operators:
{{ include "o11y-agent.config.k8s-logs-operators" . }}
            - id: finish
              type: noop
{{- end }}
