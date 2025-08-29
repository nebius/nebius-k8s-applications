{{/*
Expand the name of the chart.
*/}}
{{- define "o11y-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "o11y-agent.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "o11y-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "o11y-agent.labels" -}}
helm.sh/chart: {{ include "o11y-agent.chart" . }}
{{ include "o11y-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "o11y-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "o11y-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
component: o11y-agent
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "o11y-agent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "o11y-agent.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "o11y-agent.appname" -}}
{{- if .Values.config.backupAgent -}}
o11y-agent-backup
{{- else -}}
o11y-agent
{{- end -}}
{{- end }}

{{- define "o11y-agent.configmapName" -}}
o11y-agent-config
{{- end }}

