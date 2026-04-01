{{/*
Expand the name of the chart.
*/}}
{{- define "generative-virtual-screening-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 40 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "generative-virtual-screening-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 40 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 40 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 40 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "generative-virtual-screening-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 40 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "generative-virtual-screening-chart.labels" -}}
helm.sh/chart: {{ include "generative-virtual-screening-chart.chart" . }}
{{ include "generative-virtual-screening-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "generative-virtual-screening-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generative-virtual-screening-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create secret to access docker registry
*/}}
{{- define "imagePullSecret" -}}
{{- $registry := .Values.imagePullSecret.registry -}}
{{- $secretName := .Values.imagePullSecret.secretName -}}
{{- $secretKey := .Values.imagePullSecret.secretKey -}}
{{- $secretNamespace := .Release.Namespace -}}

{{- $password := .Values.imagePullSecret.password | b64dec -}}
{{- $auth := printf "%s:%s" .Values.imagePullSecret.username $password | b64enc -}}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"auth\":\"%s\"}}}" $registry .Values.imagePullSecret.username .Values.imagePullSecret.password (printf "%s:%s" .Values.imagePullSecret.username .Values.imagePullSecret.password | b64enc) | b64enc }}
{{- end -}}

