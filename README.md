# Free Hosting With Local Architecure

## Índice
- [Objetivo](#objetivo)
- [Arquitectura](#arquitectura)
- [Pre-requisitos](#pre-requisitos)
- [Instalación](docs/instalacion.md)
- [Desarrollo](#desarrollo)

## Objetivo
El proyecto tiene como objetivo facilitar la creación de servidores para hosting de aplicaciones web. Utiliza contenedores **Docker** para crear los servicios que componen el entorno.

## Arquitectura
![Diagrama de arquitecura](docs/assets/architecture-diagram.png)

### General
- #### [Instalar VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- #### [Instalar Vagrant](https://developer.hashicorp.com/vagrant/install)

### Accesorios
- #### Instalar curl (solo Linux)
  ```bash
  sudo apt update && sudo apt install -y curl
  ```

### DevOps Server
Para su funcionamiento, el servidor DevOps requiere un token de **ngrok** y un dominio. Ambos se pueden obtener de forma gratuita luego de registrarse.

- #### [Ngrok](https://ngrok.com/)

## Desarrollo
El proyecto se basa en obtener los scripts de forma remota desde el repositorio, para realizar pruebas sobre cambios que no se encuentran en la rama "main" se debe usar un parametro extra con el nombre de la rama que se desee utilizar, el siguiente ejemplo aplica a la rama **"feature/nueva"**, para cualquier otra rama se debe modificar el valor de la variable **branch** por el nombre de la rama deseada.

### Linux
```bash
branch="feature/nueva"; destino="/ruta/donde/guardar"; curl -o $destino/install.sh https://raw.githubusercontent.com/MartinSIbarra/free-hosting-with-local-architecture/$branch/install.sh && chmod +x $destino/install.sh && $destino/install.sh --branch-name=$branch
```

### Windows (powershell)
```powershell
$branch="feature/nueva"; $destino="C:\Ruta\Donde\Guardar"; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MartinSIbarra/free-hosting-with-local-architecture/$branch/install.ps1" -OutFile "$destino\install.ps1"; & "$destino\install.ps1 --branch-name=$branch"
```

# Ngrok Agent + Nginx Proxy
# Wireguard (VPN) Server on Alpine

vagrant plugin install vagrant-vbguest

vagrant up && vagrant reload

[Instalacion](docs/instalacion.md)

# Free Hosting with Local Architecture

