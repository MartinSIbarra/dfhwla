#!/bin/bash
set -o pipefail

[ -z "$1" ] && root_path="$HOME" || root_path="$1"

export PARAMS_FILE="$root_path/params/params.json"

validate_params "$root_path"

# Ejecuta nginx en segundo plano
log "$root_path" "Starting nginx server in background..." "$0"
nginx -g "daemon off;" &

# Ejecuta el tunnel ngrok en segundo plano
log "$root_path" "Starting ngrok tunnel..." "$0"
/usr/local/bin/ngrok-start.sh "$root_path" &
sleep 5
# Lanzar un loop para actualizar la config cada X segundos en background
(
  while true; do
    log "$root_path" "Looking for new updates to proxy configuration..." "$0"
    /usr/local/bin/proxy-conf-updt.sh "$root_path"
    sleep 5
  done
) &

wait
