#!/bin/bash
set -o pipefail

[ -z $1 ] && root_path="$HOME" || root_path="$1"

log_path="$root_path/logs"
log_file="$log_path/ngrok.log"

mkdir -p "$log_path"

error_messages=()
ngrok_auth_token=$(jq -r '.tunnel.ngrok_auth_token' "$PARAMS_FILE") && [ -n "$ngrok_auth_token" ] || error_messages+=("tunnel.ngrok_auth_token is not set in $PARAMS_FILE")
ngrok_tunnel_url=$(jq -r '.tunnel.ngrok_tunnel_url' "$PARAMS_FILE") && [ -n "$ngrok_tunnel_url" ] || error_messages+=("tunnel.ngrok_tunnel_url is not set in $PARAMS_FILE")
ngrok_tunnel_port=$(jq -r '.tunnel.ngrok_tunnel_port' "$PARAMS_FILE") && [ -n "$ngrok_tunnel_port" ] || error_messages+=("tunnel.ngrok_tunnel_port is not set in $PARAMS_FILE")
if [ ${#error_messages[@]} -ne 0 ]; then
    for message in "${error_messages[@]}"; do
        log "$root_path" "Error: $message"
    done
    exit 1
fi

log "$root_path" "Using ngrok with the following parameters:"
log "$root_path" "ngrok_auth_token: $ngrok_auth_token"
log "$root_path" "ngrok_tunnel_url: $ngrok_tunnel_url"
log "$root_path" "ngrok_tunnel_port: $ngrok_tunnel_port"
log "$root_path" "ngrok_log_file: $log_file"
[ "$root_path" == "$HOME" ] && ngrok http $ngrok_tunnel_port --url=$ngrok_tunnel_url --authtoken=$ngrok_auth_token --log=$log_file
log "$root_path" "Ngrok tunnel started."

chown "1000":"1000" "$log_file"
