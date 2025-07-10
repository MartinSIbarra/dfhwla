# Free Hosting With Local Architecture

El proyecto tiene como objetivo facilitar la creación de servidores para hosting de aplicaciones web utilizando herramientas gratuitas. Utiliza contenedores **Docker** para los servicios que componen el entorno.

#### Índice

- [Arquitectura](#arquitectura)
- [Instalación](docs/instalacion.md)
- [Desarrollo](docs/desarrollo.md)

### Arquitectura

![Diagrama de arquitectura](docs/assets/architecture-diagram.png)

#### Componentes:

- **VPN Server** (*[Wireguard](https://www.wireguard.com/)*)
  Tiene como objetivo crear una red privada para que tanto el servidor host de la arquitectura ("Server" en la imagen) como los peers utilizados para desarrollar sobre la aplicación web se puedan conectar entre sí.

######

- **DDNS Updater** (*[DuckDNS](https://www.duckdns.org/)*)
  Tiene como objetivo otorgar un dominio "estático" al servidor host de la arquitectura para que pueda ser accedido sin importar si su IP es estática o dinámica. Principalmente utilizado para handshake entre los peers y el **_"VPN Server"_**. Utiliza

######

- **Tunnel Server** (*[Ngrok](https://ngrok.com/)*)
  Tiene como objetivo dar un dominio "estatico" para exponer la aplicacion web en internet.

######

- **Proxy** (*[Ngnix](https://nginx.org/)*)
  Tiene como objetivo poder disponibilzar mas de un entorno de la aplicacion web (producción y uat en la imagen).
