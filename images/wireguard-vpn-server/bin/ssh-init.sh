#!/bin/bash
set -o 'pipefail'

# Hace source de las variables de entorno
[ "$TEST" != "true" ] && source "/usr/local/bin/env.sh" || source "./common/bin/env.sh"

# Se establece la contraceña de root para poder usar SSH
error_messages=()
vpn_ipv4_net=$(jq -r '.vpn.ipv4_net' "$PARAMS_FILE") && [ -n "$vpn_ipv4_net" ] || error_messages+=("vpn.ipv4_net is not set in $PARAMS_FILE")
ssh_passwd=$(jq -r '.vpn.ssh_passwd' "$PARAMS_FILE") && [ -n "$ssh_passwd" ] || error_messages+=("vpn.ssh_passwd is not set in $PARAMS_FILE")
if [ ${#error_messages[@]} -ne 0 ]; then
    for message in "${error_messages[@]}"; do
        log "Error: $message"
    done
    exit 1
fi

echo "root:$ssh_passwd" | chpasswd

sshd_config_file="/etc/ssh/sshd_config"
sshd_config_file_backup="/etc/ssh/sshd_config.bak"

# Backup del archivo original
cp "$sshd_config_file" "$sshd_config_file_backup"

# Eliminar bloques previos si ya existen (limpio antiguos Match root)
sed -i "/^Match Address $vpn_ipv4_net User root/,/^Match all/d" "$sshd_config_file"
sed -i "/^Match all/,/^Match /d" "$sshd_config_file"

# Agregar al final la configuración nueva
cat << EOF >> "$sshd_config_file"

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
    log "OpenSSH server configuration failed."
    cp "$sshd_config_file_backup" "$sshd_config_file"
    exit 1
else
    # Se inicia el servicio SSH
    /usr/sbin/sshd
    log "OpenSSH server started successfully."
fi
