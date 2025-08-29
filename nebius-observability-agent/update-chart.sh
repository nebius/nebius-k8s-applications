#!/bin/bash

# Download script for Nebius Observability Agent Helm chart
# This script downloads the chart from the OCI registry to the local chart folder

set -e

CHART_DIR="chart"
REGISTRY_URL="oci://cr.nebius.cloud/observability/public/nebius-observability-agent-helm"

# Remove old chart if it exists to ensure clean update
if [ -d "$CHART_DIR" ]; then
    echo "Removing existing chart directory for clean update..."
    rm -rf "$CHART_DIR"
fi

# Create chart directory
mkdir -p "$CHART_DIR"

# Get the latest version
echo "Fetching latest version..."
#LATEST_VERSION=$(curl -s https://nebius-observability-agent.storage.eu-north1.nebius.cloud/nebius-observability-agent-helm/latest-release)
LATEST_VERSION=1.28.0-d80c24ec


if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Could not fetch latest version"
    exit 1
fi

echo "Latest version: $LATEST_VERSION"

# Download the chart
echo "Downloading chart to $CHART_DIR..."
helm pull "$REGISTRY_URL" --version "$LATEST_VERSION" --untar --untardir "$CHART_DIR"

# Find the extracted chart directory and move its contents up one level
EXTRACTED_DIR=$(find "$CHART_DIR" -maxdepth 1 -type d -name "*observability*" | head -1)

if [ -n "$EXTRACTED_DIR" ]; then
    echo "Moving chart contents from $EXTRACTED_DIR to $CHART_DIR..."
    mv "$EXTRACTED_DIR"/* "$CHART_DIR/"
    rmdir "$EXTRACTED_DIR"
fi

echo "Chart downloaded successfully to $CHART_DIR"
echo "Version: $LATEST_VERSION"
