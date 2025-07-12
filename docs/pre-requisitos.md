# :globe_with_meridians: Free Hosting With Local Architecture
### :gear: Pre-requisitos
- [Software](#software)
- [Configuraciones](#configuraciones)
- [Nodo (opcional)](#nodo-opcional)

---
### Software
El software requerido es necesario para el host del entorno, si se utiliza la solucion de ["nodo"](#nodo-opcional) ya se encuentran instaladas por defecto las dependencias.
###
**[Docker](https://www.docker.com/)**
La solución utiliza docker para la mayoría de sus componentes con lo cual es requerido en el host del entorno.
[Guía de instalación](https://docs.docker.com/engine/install/)

###
**[Wireguard](https://www.wireguard.com/)**
Idealmente el host de la solución se puede conectar a la VPN para poder ser accedido remotamente por los peers y asi facilitar el mantenimiento y configuración del entorno.
[Guía de instalación](https://www.wireguard.com/install/)

**[Curl (recomendado)](https://curl.se/)**
Se utiliza curl para faciliar la descarga de los archivos de instalacion y componentes del repositorio desde la terminal (aunque también se pueden realizar descargas manuales o clonar el repositorio).

***Debian / Ubuntu***
```
apt install -y curl
```
***Alpine***
```
apk add --no-cache curl
```
---
### Configuraciones
###
**[Ngrok](https://ngrok.com/)**
Se debe obtener un token y un dominio para la configuración del entorno, ambos se pueden obtener de forma gratuita luego de generar una cuenta en Ngrok.

###
**[DuckDNS](https://www.duckdns.org/)**
Se debe obtener un subdominio de duckdns, el mismo se utilizará para tener una dirección estática para el uso de la VPN.

###
**[Port Forwarding](https://www.redeszone.net/tutoriales/configuracion-puertos/abrir-puerto-tcp-udp-router/)**
Se debe realizar el "forwardeo" de puertos en el router para redirigir el trafico del puerto donde escucha el servidor de ***wireguard***, por defecto el servidor ya se encuentra configurado para escuchar el puerto 51820, de la misma manera que el "nodo" ***vagrant*** si se usa. El forwardeo de puertos se debe realizar desde el router a la maquina host física donde se ejecuta la solución.

---
### Nodo (opcional)
El proyecto incluye un ***Vagrantfile*** configurado para servir de "nodo" donde desplegar la solución, esta maquina virtual se puede utilizar tanto en sistemas operativos Linux como Windows, y aunque no es necesario es recomendable para aislar el entorno de la maquina host física. Así mismo ya viene configurada con las dependencias necesarias.

Para poder utilizar el "nodo" es requerido el siguiente software:

[VirtualBox](https://www.virtualbox.org/) 
Se utiliza para poder ejecutar ***Vagrant***.
[Guia de instalación](https://www.virtualbox.org/wiki/Downloads)

[Vagrant](https://developer.hashicorp.com/vagrant/)
Es una maquina virtual sin entorno grafico que ejecuta sobre virtual box, tiene la ventaja de se liviana y altamente configurable.
[Guia de instalación](https://developer.hashicorp.com/vagrant/install)

---
# [⬆︎](../README.md)  [⬅︎ ](../README.md)  [➡︎](instalacion.md)
