#!/bin/bash
set -o pipefail

[ -z $1 ] && root_path="$HOME" || root_path="$1"

log_path="$root_path/logs"
log_file="$log_path/ngrok.log"

mkdir -p "$log_path"

ngrok_auth_token=$(jq -r '.tunnel.ngrok_auth_token' "$PARAMS_FILE")
ngrok_tunnel_url=$(jq -r '.tunnel.ngrok_tunnel_url' "$PARAMS_FILE")
ngrok_tunnel_port=$(jq -r '.tunnel.ngrok_tunnel_port' "$PARAMS_FILE")

log "$root_path" "Using ngrok with the following parameters:" "$0"
log "$root_path" "ngrok_auth_token: $ngrok_auth_token" "$0"
log "$root_path" "ngrok_tunnel_url: $ngrok_tunnel_url" "$0"
log "$root_path" "ngrok_tunnel_port: $ngrok_tunnel_port" "$0"
log "$root_path" "ngrok_log_file: $log_file" "$0"
[ "$root_path" == "$HOME" ] && ngrok http $ngrok_tunnel_port --url=$ngrok_tunnel_url --authtoken=$ngrok_auth_token --log=$log_file
log "$root_path" "Ngrok tunnel started." "$0"

chown "1000":"1000" "$log_file"
