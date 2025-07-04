# Dockerfile para el contenedor de actualización de DDNS
FROM alpine:latest

# Agrega scripts al contenedor
COPY ./bin/entrypoint.sh \ 
    ./bin/env.sh \
    ./bin/log.sh \
    ./bin/validate-params.sh \
    ./bin/ddns-updt.sh \
    /usr/local/bin/

# Instalar paquetes necesarios
RUN apk update \
    # Instala dependencias y herramientas
    && apk add --no-cache iproute2 curl nano jq bash \
    && rm -rf /var/cache/apk/* \
    # Establecer bash como shell predeterminado
    && sed -i 's|/bin/sh|/bin/bash|' /etc/passwd \
    # Agrega permisos de ejecución a los scripts
    && chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/env.sh \
    && chmod +x /usr/local/bin/log.sh \
    && chmod +x /usr/local/bin/validate-params.sh \
    && chmod +x /usr/local/bin/ddns-updt.sh \
    # agregar aliases
    && echo "alias a='ls -la --color --group-directories-first'" >> /root/.bashrc

# Setea el entrypoint
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
