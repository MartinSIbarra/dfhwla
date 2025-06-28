#!/bin/bash
set -o pipefail

# Hace source de las variables de entorno
[ "$TEST" != "true" ] && source "/usr/local/bin/env.sh" || source "./common/bin/env.sh"

# Se valida el archivo de parametros
$COMMONS_BIN_PATH/validate_params.sh

# Ejecuta nginx en segundo plano
log "Starting nginx server in background..."
nginx -g "daemon off;" &

# Ejecuta el tunnel ngrok en segundo plano
log "Starting ngrok tunnel..."
$BIN_PATH/ngrok-start.sh

# Lanzar un loop para actualizar la config cada X segundos en background
auto_update_time=$(jq -r '.proxy.auto_update_time' "$PARAMS_FILE")
[ -z "$auto_update_time" ] && auto_update_time=60  # Default to 60 seconds if not set
sleep $auto_update_time
(
  while true; do
    $BIN_PATH/proxy-conf-updt.sh
    sleep $auto_update_time
  done
) &
log "Started background process to update proxy configuration every $auto_update_time seconds."

wait
