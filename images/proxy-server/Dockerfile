FROM alpine:latest

# Agrega scripts al contenedor
COPY ./bin/entrypoint.sh \
    ./bin/env.sh \
    ./bin/log.sh \
    ./bin/validate-params.sh \
    ./bin/proxy-conf-updt.sh \
    /usr/local/bin/

# Agrega templates al contenedor
COPY ./templates /root/templates

# Instalar paquetes necesarios
RUN apk update \
    # Instala dependencias y herramientas
    && apk add --no-cache nginx curl nano jq bash \
    && rm -rf /var/cache/apk/* \
    # Establecer bash como shell predeterminado
    && sed -i 's|/bin/sh|/bin/bash|' /etc/passwd \
    # Crear path necesario para nginx
    && mkdir -p /run/nginx \
    # Agrega permisos de ejecución a los scripts
    && chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/env.sh \
    && chmod +x /usr/local/bin/log.sh \
    && chmod +x /usr/local/bin/validate-params.sh \
    && chmod +x /usr/local/bin/proxy-conf-updt.sh \
    # Agrega alias para facilitar el uso
    && echo "alias a='ls -la --color --group-directories-first'" >> /root/.bashrc

# Setea el entrypoint
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
