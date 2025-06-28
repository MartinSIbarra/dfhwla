#!/bin/bash
set -e

# Hace source de las variables de entorno
[ "$TEST" != "true" ] && source "/usr/local/bin/env.sh" || source "./common/bin/env.sh"

# Se valida el archivo de parametros
$COMMONS_BIN_PATH/validate_params

log "Starting OpenSSH server..."
$BIN_PATH/ssh-init.sh  &

log "Starting WireGuard VPN server..."
$BIN_PATH/vpn-server-init.sh  &

wait
