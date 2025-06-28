#!/bin/bash
set -e

[ -z "$1" ] && root_path="$HOME" || root_path="$1"

vpn_config_path="$root_path/config"
vpnkeys_list_file="$vpn_config_path/vpnkeys.list"
vpn_interface="$vpn_config_path/server.conf"
templates_path="$root_path/templates"

wg-quick down "$vpn_interface" > /dev/null 2>&1 || true

# Se obtienen los parametros del archivo de configuracion
log "$root_path" "Loading parameters from $PARAMS_FILE..."
error_messages=()
vpn_server_url=$(jq -r '.vpn.server_url' "$PARAMS_FILE") && [ -n "$vpn_server_url" ] || error_messages+=("vpn.server_url is not set in $PARAMS_FILE")
vpn_port=$(jq -r '.vpn.port' "$PARAMS_FILE") && [ -n "$vpn_port" ] || error_messages+=("vpn.port is not set in $PARAMS_FILE")
vpn_ipv4_net=$(jq -r '.vpn.ipv4_net' "$PARAMS_FILE") && [ -n "$vpn_ipv4_net" ] || error_messages+=("vpn.ipv4_net is not set in $PARAMS_FILE")
IFS='.' read -r ipp1 ipp2 ipp3 dump <<< "$vpn_ipv4_net"
vpn_ipv4_mask="$ipp1.$ipp2.$ipp3"
vpn_ipv6_net=$(jq -r '.vpn.ipv6_net' "$PARAMS_FILE") && [ -n "$vpn_ipv6_net" ] || error_messages+=("vpn.ipv6_net is not set in $PARAMS_FILE")
vpn_peers_quantity=$(jq -r '.vpn.peers_quantity' "$PARAMS_FILE") && [ -n "$vpn_peers_quantity" ] || error_messages+=("vpn.peers_quantity is not set in $PARAMS_FILE")
if [ ${#error_messages[@]} -ne 0 ]; then
    for message in "${error_messages[@]}"; do
        log "$root_path" "Error: $message"
    done
    exit 1
fi

keys=()
generate_vpnkey_list() {
    local from=$1
    local peers=$2
    local file=$3
    local ivp4_mask=$4
    for i in $(seq $from $peers); do
        private_key=$(wg genkey) 
        public_key=$(echo "$private_key" | wg pubkey)
        key="$private_key,$public_key,$ivp4_mask.$i"
        echo "$key" | tee -a "$file" > /dev/null 2>&1
        keys+=("$key")
    done
}

# Verifica si el archivo de claves para la vpn existe y tiene contenido, si no existe lo crea y lo carga sino agrega las claves nuevas
if [ ! -s "$vpnkeys_list_file" ]; then
    rm -f "$vpnkeys_list_file"
    mkdir -p "$vpn_config_path"
    touch "$vpnkeys_list_file"

    generate_vpnkey_list "1" "$vpn_peers_quantity" "$vpnkeys_list_file" "$vpn_ipv4_mask"
else
    while IFS= read -r key; do
        keys+=("$key")
    done < "$vpnkeys_list_file"

    cant_vpnkeys="${#keys[@]}"
    start=$((cant_vpnkeys + 1))

    if [ "$start" -gt "$vpn_peers_quantity" ]; then
        log "$root_path" "Required peers quantity ($vpn_peers_quantity) already reached with $cant_vpnkeys keys."
    else
        generate_vpnkey_list "$start" "$vpn_peers_quantity" "$vpnkeys_list_file" "$vpn_ipv4_mask"
    fi
fi

rm -f "$vpn_config_path"/*.conf

# Toma la primera clave de la lista para el servidor y la elimina de la lista
key="${keys[0]}"
IFS=',' read -r server_private_key server_public_key server_vpn_ip <<< "$key"
keys=("${keys[@]:1}")

# Crea el archivo de configuracion del servidor con la primer parte del servidor
while IFS= read -r line; do
    line="${line//<server_vpn_ip>/$server_vpn_ip}"
    line="${line//<vpn_port>/$vpn_port}"
    line="${line//<server_private_key>/$server_private_key}"
    echo "$line" | tee -a "$vpn_interface" > /dev/null 2>&1
done < "$templates_path/server-server-part.conf"

i=1
for key in "${keys[@]}"; do
    touch "$vpn_config_path/peer$i.conf"
    IFS=',' read -r peer_private_key peer_public_key peer_vpn_ip <<< "$key"

    # Crea el archivo de configuracion del peer 
    while IFS= read -r line; do
        line="${line//<peer_vpn_ip>/$peer_vpn_ip}"
        line="${line//<peer_private_key>/$peer_private_key}"
        line="${line//<server_public_key>/$server_public_key}"
        line="${line//<vpn_port>/$vpn_port}"
        line="${line//<server_url>/$vpn_server_url}"
        ipv4_with_cidr="$vpn_ipv4_net/24"
        line="${line//<allowed_ips_ipv4>/$ipv4_with_cidr}"
        ipv6_with_cidr="$vpn_ipv6_net/64"
        line="${line//<allowed_ips_ipv6>/$ipv6_with_cidr}"
        echo "$line" | tee -a "$vpn_config_path/peer$i.conf" > /dev/null 2>&1
    done < "$templates_path/peer.conf"

    # Agrega la parte del peer al archivo de configuracion del servidor
    echo "" | tee -a "$vpn_interface" > /dev/null 2>&1
    while IFS= read -r line; do
        line="${line//<peer_vpn_ip>/$peer_vpn_ip}"
        line="${line//<peer_public_key>/$peer_public_key}"
        echo "$line" | tee -a "$vpn_interface" > /dev/null 2>&1
    done < "$templates_path/server-peer-part.conf"

    ((i++))
done

wg-quick up "$vpn_interface"

log "$root_path" "WireGuard VPN server started successfully."
