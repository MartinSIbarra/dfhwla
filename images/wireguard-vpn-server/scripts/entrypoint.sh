#!/bin/bash
set -e

[ -z "$1" ] && root_path="$HOME" || root_path="$1"

export PARAMS_FILE="$root_path/params/params.json"

validate_params "$root_path"

log "$root_path" "Starting OpenSSH server..." "$0"
/usr/local/bin/ssh-init.sh "$root_path" &

log "$root_path" "Starting WireGuard VPN server..." "$0"
/usr/local/bin/vpn-server-init.sh "$root_path" &

wait
