FROM alpine:latest

# Agrega scripts al contenedor
COPY ./bin/proxy-conf-updt.sh \
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
    && apk add --no-cache nginx nano jq bash \
    && rm -rf /var/cache/apk/* \
    # Crear path necesario para nginx
    && mkdir -p /run/nginx \
    # Agrega permisos de ejecución a los scripts
    && chmod +x /usr/local/bin/proxy-conf-updt.sh \
    && chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/validate-params.sh \
    && chmod +x /usr/local/bin/log.sh \
    && chmod +x /usr/local/bin/env.sh \
    # Agrega alias para facilitar el uso
    && echo "alias a='ls -la --color --group-directories-first'" >> /root/.bashrc

# Setea el entrypoint
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
