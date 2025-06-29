#!/bin/bash
set -o 'pipefail'

# Hace source de las variables de entorno
[ "$TEST" != "true" ] && source "/usr/local/bin/env.sh" || source "./common/bin/env.sh"

# Se valida el archivo de parametros
$COMMONS_BIN_PATH/validate-params.sh

(
  while true; do
    $BIN_PATH/ddns-updt.sh
    duckdns_update_time=$(jq -r '.ddns.duckdns_update_time' "$PARAMS_FILE")
    [ -z "$duckdns_update_time" ] && duckdns_update_time=3600  # Default if not set
    sleep $duckdns_update_time
  done
) &
log "Started background process to update DDNS(DuckDNS) every $duckdns_update_time seconds."

wait
