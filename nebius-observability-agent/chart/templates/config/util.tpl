{{- define "o11y-agent.config.grpc-common-options" }}
    balancer_name: round_robin
    compression: snappy
    keepalive:
        time: 20s
        timeout: 10s
        permit_without_stream: true
    retry_on_failure:
        initial_interval: 1s
        max_interval: {{ if hasKey .Values.config "backoff" -}}
       {{- .Values.config.backoff.max_interval | default "2m" -}}
       {{- else -}}
       {{- " 2m" -}}
       {{- end }}
    shared_backoff: true
    timeout: 5s
    headers:
        "project-id": "{{ include "o11y-agent.config.parent-id" . }}"
{{- end}}

{{- define "o11y-agent.config.logs-namespace-filter" -}}
{{- if .Values.config.logs.excludedNamespaces -}}
{{- range .Values.config.logs.excludedNamespaces }} and namespace != "{{ . }}"{{- end -}}
{{- end -}}
{{- end -}}


{{- define "o11y-agent.config.k8s-logs-operators" }}
            - id: parser-containerd
              type: docker_log_parser
            - type: time_parser
              parse_from: attributes.timestamp
              layout: '%Y-%m-%dT%H:%M:%S.%LZ'
            - type: remove
              field: attributes.timestamp
              if: '"timestamp" in attributes'
            - type: add
              field: attributes["recombine-field"]
              value: EXPR(attributes["log.file.path"] + attributes["stream"])
            - id: containerd-recombine
              type: recombine
              combine_field: attributes.log
              combine_with: ""
              is_last_entry: attributes.logtag == 'F'
              max_log_size: 0
              max_unmatched_batch_size: 0
              force_flush_period: 10m
              output: extract_metadata_from_filepath
              source_identifier: attributes["recombine-field"]
            - id: extract_metadata_from_filepath
              type: docker_filepath_parser
              parse_from: attributes["log.file.path"]
              cache_size: 1000
            - type: remove
              field: attributes["recombine-field"]
            - type: remove
              field: attributes.stream
            - type: move
              from: attributes.container_name
              to: resource["k8s.container.name"]
            - type: move
              from: attributes.namespace
              to: resource["k8s.namespace.name"]
            - type: move
              from: attributes.pod_name
              to: resource["k8s.pod.name"]
            - type: move
              from: attributes.restart_count
              to: resource["k8s.container.restart_count"]
            - type: remove
              field: attributes.uid
            - type: remove
              field: attributes["logtag"]
              if: '"logtag" in attributes'
            - type: move
              from: attributes.log
              to: body
{{- end -}}


{{- define "o11y-agent.config.region" -}}
{{- if and .Values.config.metadata .Values.config.metadata.region -}}
{{- .Values.config.metadata.region -}}
{{- else -}}
${env:REGION_NAME}
{{- end -}}
{{- end -}}

{{- define "o11y-agent.config.parent-id" -}}
{{- if and .Values.config.metadata .Values.config.metadata.parent_id -}}
{{- .Values.config.metadata.parent_id -}}
{{- else -}}
${env:PARENT_ID}
{{- end -}}
{{- end -}}

