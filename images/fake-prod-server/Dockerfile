FROM alpine:latest

RUN apk add --no-cache lighttpd

# Contenido web
RUN mkdir -p /var/www/localhost/htdocs \
    && echo "¡Servidor FAKE PROD!" > /var/www/localhost/htdocs/index.html

# Configuración personalizada de Lighttpd en el puerto 3000
RUN echo "server.document-root = \"/var/www/localhost/htdocs\"" > /etc/lighttpd/lighttpd.conf && \
    echo "server.port = 3000" >> /etc/lighttpd/lighttpd.conf && \
    echo 'index-file.names = ( "index.html" )' >> /etc/lighttpd/lighttpd.conf

EXPOSE 3000

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]