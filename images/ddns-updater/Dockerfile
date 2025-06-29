FROM alpine:latest

# Agrega scripts al contenedor
COPY ./bin/entrypoint.sh \ 
    ./bin/vpn-server-init.sh \
    ./bin/ssh-init.sh \
    ./bin/ddns-updt.sh \
    ./bin/validate-params.sh \
    ./bin/log.sh \
    ./bin/env.sh \
    /usr/local/bin/

# Agrega templates al contenedor
COPY ./templates /root/templates

# Instalar paquetes necesarios
RUN apk update \
    # Instala dependencias y herramientas
    && apk add --no-cache iproute2 curl nano jq bash \
    && rm -rf /var/cache/apk/* \
    # Crear path necesario para el servidor SSH
    && mkdir -p /var/run/sshd \
    # Generar las claves del host
    && ssh-keygen -A \
    # Agrega permisos de ejecución a los scripts
    && chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/ddns-updt.sh \
    && chmod +x /usr/local/bin/validate-params.sh \
    && chmod +x /usr/local/bin/log.sh \
    && chmod +x /usr/local/bin/env.sh \
    # agregar aliases
    && echo "alias a='ls -la --color --group-directories-first'" >> /root/.bashrc

# Setea el entrypoint
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
