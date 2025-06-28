#!/bin/bash
set -e

[ -z "$1" ] && root_path="$HOME" || root_path="$1"

# Se establece la contraceña de root para poder usar SSH
vpn_ipv4_net=$(jq -r '.vpn.ipv4_net' "$PARAMS_FILE")
ssh_passwd=$(jq -r '.vpn.ssh_passwd' "$PARAMS_FILE")
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
    log "$root_path" "OpenSSH server configuration failed." "$0"
    cp "$BACKUP_FILE" "$CONFIG_FILE"
    exit 1
else
    # Se inicia el servicio SSH
    /usr/sbin/sshd
    log "$root_path" "OpenSSH server started successfully." "$0"
fi
