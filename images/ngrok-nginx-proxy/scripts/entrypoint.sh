#!/bin/bash
set -o pipefail

[ -z "$1" ] && root_path="$HOME" || root_path="$1"

export PARAMS_FILE="$root_path/params/params.json"

validate_params "$root_path"

# Ejecuta nginx en segundo plano
log "$root_path" "Starting nginx server in background..."
nginx -g "daemon off;" &

# Ejecuta el tunnel ngrok en segundo plano
log "$root_path" "Starting ngrok tunnel..."
/usr/local/bin/ngrok-start.sh "$root_path" &

auto_update_time=$(jq -r '.proxy.auto_update_time' "$PARAMS_FILE")
[ -z "$auto_update_time" ] && auto_update_time=60  # Default to 60 seconds if not set

sleep $auto_update_time
# Lanzar un loop para actualizar la config cada X segundos en background
(
  while true; do
    /usr/local/bin/proxy-conf-updt.sh "$root_path"
    sleep $auto_update_time
  done
) &
log "$root_path" "Started background process to update proxy configuration every $auto_update_time seconds."

wait
