#!/bin/bash
set -e

COMFY_DIR="/root/comfy"

COMFY_URL="${COMFY_URL:-https://github.com/comfyanonymous/ComfyUI.git}"
COMFY_TAG="${COMFY_TAG:-}"            

MANAGER_URL="${MANAGER_URL:-https://github.com/Comfy-Org/ComfyUI-Manager.git}"
MANAGER_TAG="${MANAGER_TAG:-}"        

[ "$COMFY_TAG" = "latest" ] && COMFY_TAG=""
[ "$MANAGER_TAG" = "latest" ] && MANAGER_TAG=""

COMFY_ARGS="${COMFY_ARGS:-"--listen 0.0.0.0"}"

INSTALL_URL="$COMFY_URL"
[ -n "$COMFY_TAG" ] && INSTALL_URL="$INSTALL_URL@$COMFY_TAG"

MANAGER_INSTALL_URL="$MANAGER_URL"
[ -n "$MANAGER_TAG" ] && MANAGER_INSTALL_URL="$MANAGER_INSTALL_URL@$MANAGER_TAG"

if [ ! -d "$COMFY_DIR/ComfyUI" ]; then
  echo "[$(date)] ComfyUI directory is empty, running installation..."
  mkdir -p "$COMFY_DIR"
  cd "$COMFY_DIR"

  yes y | comfy install \
    --url "$INSTALL_URL" \
    --manager-url "$MANAGER_INSTALL_URL" \
    --nvidia

  touch "$COMFY_DIR/setup-done"

  echo "[$(date)] Installation complete."
else
  echo "[$(date)] ComfyUI directory already exists, skipping installation."
fi

# Запуск ComfyUI с параметрами
echo "[$(date)] Launching ComfyUI with args: $COMFY_ARGS"
cd "$COMFY_DIR"
exec comfy launch -- $COMFY_ARGS
