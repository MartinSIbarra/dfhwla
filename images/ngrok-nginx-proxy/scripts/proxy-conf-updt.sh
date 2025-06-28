#!/bin/bash
set -o pipefail

[ -z $1 ] && root_path="$HOME" || root_path="$1"

config_path="$root_path/config"
config_file="$config_path/ngrok-nginx.conf"

nginx_config_path="/etc/nginx/http.d"
nginx_config_file="$nginx_config_path/ngrok-proxy.conf"

templates_path="$root_path/templates"
main_template_file="$templates_path/main.conf"

# Lee el contenido de location.conf en una variable
location_template=$(<"$templates_path/location.conf")

apps=$(jq -c '.proxy.apps[]' "$PARAMS_FILE")

locations=""
# Recorre cada app
for app in $apps; do
    url_path=$(echo "$app" | jq -r '.url_path')
    name=$(echo "$app" | jq -r '.name')
    port=$(echo "$app" | jq -r '.port')
    # Revisa si la app está activa, si esta activa genera la configuración para el proxy
    if curl -s --head --fail "http://$name:3000" >/dev/null; then
        # Si la app está activa, genera la configuración de location
        locations+=$'\n'  # Añade un salto de línea entre ubicaciones
        location=$(echo "$location_template")
        location=$(echo "$location" | sed "s|<url_path>|$url_path|g")
        location=$(echo "$location" | sed "s|<app_name>|$name|g")
        location=$(echo "$location" | sed "s|<app_port>|$port|g")
        locations+="$location"
        log "$root_path" "Added location for $name at $url_path on port $port" "$0"
    fi
done

mkdir -p "$config_path"
# Reemplaza <locations> en el template y guarda el resultado en un nuevo archivo
sed '/<locations>/{
    r /dev/stdin
    d
}' "$main_template_file" <<<"$locations" > "$config_file"

# Reemplaza <listen_port> en config_file
listen_port=$(jq -r '.proxy.listen_port' "$PARAMS_FILE")
sed -i "s|<listen_port>|$listen_port|g" "$config_file"
log "$root_path" "Updated listen port to $listen_port in $config_file" "$0" 

[ "$root_path" == "$HOME" ] \
    && [ ! -s "$nginx_config_file" ] \
        && touch "$nginx_config_file"

[ "$root_path" == "$HOME" ] \
    && ! diff -q "$nginx_config_file" "$config_file" >/dev/null \
        && cp "$config_file" "$nginx_config_file" \
        && nginx -s reload \
        && log "$root_path" "Updated nginx configuration with new proxy settings." "$0"
