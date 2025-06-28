#!/bin/bash
set -e

[ -z "$1" ] && root_path="$HOME" || root_path="$1"

# Se establece la contraceña de root para poder usar SSH
error_messages=()
vpn_ipv4_net=$(jq -r '.vpn.ipv4_net' "$PARAMS_FILE") && [ -n "$vpn_ipv4_net" ] || error_messages+=("vpn.ipv4_net is not set in $PARAMS_FILE")
ssh_passwd=$(jq -r '.vpn.ssh_passwd' "$PARAMS_FILE") && [ -n "$ssh_passwd" ] || error_messages+=("vpn.ssh_passwd is not set in $PARAMS_FILE")
if [ ${#error_messages[@]} -ne 0 ]; then
    for message in "${error_messages[@]}"; do
        log "$root_path" "Error: $message"
    done
    exit 1
fi

echo "root:$ssh_passwd" | chpasswd

CONFIG_FILE="/etc/ssh/sshd_config"
BACKUP_FILE="/etc/ssh/sshd_config.bak"

# Backup del archivo original
cp "$CONFIG_FILE" "$BACKUP_FILE"

# Eliminar bloques previos si ya existen (limpio antiguos Match root)
sed -i "/^Match Address $vpn_ipv4_net User root/,/^Match all/d" "$CONFIG_FILE"
sed -i "/^Match all/,/^Match /d" "$CONFIG_FILE"

# Agregar al final la configuración nueva
cat << EOF >> "$CONFIG_FILE"

# Permitir acceso root con clave solo desde la VPN
Match Address $vpn_ipv4_net User root
    PermitRootLogin yes
    PasswordAuthentication yes

# Para el resto, denegar acceso root por seguridad
Match all
    PermitRootLogin no
    PasswordAuthentication no
EOF

# Validar configuración
echo "Validando configuración..."
ssh_test=$(/usr/sbin/sshd -t)
if [ -n "$ssh_test" ]; then
    log "$root_path" "OpenSSH server configuration failed."
    cp "$BACKUP_FILE" "$CONFIG_FILE"
    exit 1
else
    # Se inicia el servicio SSH
    /usr/sbin/sshd
    log "$root_path" "OpenSSH server started successfully."
fi
