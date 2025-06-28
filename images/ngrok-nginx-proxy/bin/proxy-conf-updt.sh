#!/bin/bash
set -o pipefail

[ -z "$1" ] && root_path="$HOME" || root_path="$1"

config_path="$root_path/config"
nginx_config_file="/etc/nginx/http.d/ngrok-proxy.conf"

templates_path="$root_path/templates"
main_template_file="$templates_path/main.conf"
location_template=$(<"$templates_path/location.conf")

apps=$(jq -c '.proxy.apps[]' "$PARAMS_FILE")
error_messages=()
listen_port=$(jq -r '.proxy.listen_port' "$PARAMS_FILE") && [ -n "$listen_port" ] || error_messages+=("proxy.listen_port is not set in $PARAMS_FILE")
if [ ${#error_messages[@]} -ne 0 ]; then
    for message in "${error_messages[@]}"; do
        log "Error: $message"
    done
    exit 1
fi

locations=""
messages=()
for app in $apps; do
    url_path=$(echo "$app" | jq -r '.url_path')
    name=$(echo "$app" | jq -r '.name')
    port=$(echo "$app" | jq -r '.port')

    if curl -s --head --fail "http://$name:3000" >/dev/null; then
        locations+=$'\n'
        location=$(echo "$location_template" | sed \
            -e "s|<url_path>|$url_path|g" \
            -e "s|<app_name>|$name|g" \
            -e "s|<app_port>|$port|g")
        locations+="$location"
        messages+=("Added location for $name at $url_path on port $port")
    fi
done

# Genera la config final en memoria
final_config=$(sed '/<locations>/{
    r /dev/stdin
    d
}' "$main_template_file" <<< "$locations")

# Sustituye <listen_port>
final_config=$(echo "$final_config" | sed "s|<listen_port>|$listen_port|g")

# Compara con el archivo real, solo escribe si cambió
if [ == "$HOME" ]; then
    if [ ! -s "$nginx_config_file" ] || ! diff -q <(echo "$final_config") "$nginx_config_file" >/dev/null; then
        echo "$final_config" > "$nginx_config_file"
        nginx -s reload
        for message in "${messages[@]}"; do
            log "$message"
        done
        log "Updated nginx configuration with new proxy settings."
    fi
fi
