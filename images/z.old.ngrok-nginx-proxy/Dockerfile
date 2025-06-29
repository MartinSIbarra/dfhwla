FROM alpine:latest

# Agrega scripts al contenedor
COPY ./bin/ngrok-start.sh \
    ./bin/proxy-conf-updt.sh \
    ./bin/entrypoint.sh \
    ./bin/validate-params.sh \
    ./bin/log.sh \
    ./bin/env.sh \
    /usr/local/bin/

# Agrega templates al contenedor
COPY ./templates /root/templates

# Instalar paquetes necesarios
RUN apk update \
    # Instala dependencias y herramientas
    && apk add --no-cache curl gnupg ca-certificates nginx nano jq bash \
    # Agrega ngrok al contenedor
    && curl -sSfL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz | tar -xz -C /usr/local/bin \
    && rm -rf /var/cache/apk/* \
    # Crear path necesario para nginx
    && mkdir -p /run/nginx \
    # Agrega permisos de ejecución a los scripts
    && chmod +x /usr/local/bin/ngrok-start.sh \
    && chmod +x /usr/local/bin/proxy-conf-updt.sh \
    && chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/validate-params.sh \
    && chmod +x /usr/local/bin/log.sh \
    && chmod +x /usr/local/bin/env.sh \
    # Agrega alias para facilitar el uso
    && echo "alias a='ls -la --color --group-directories-first'" >> /root/.bashrc

# Expone el puerto para nginx
EXPOSE 5000

# Setea el entrypoint
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
