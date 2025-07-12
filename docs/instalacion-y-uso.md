# :globe_with_meridians: Free Hosting With Local Architecture

### :rocket: Instalación y uso

- [Nodo (opcional)](#nodo)
- [Entorno](#entorno)

---

### Nodo

Para la instalación del nodo, una vez instalados los [pre-requisitos](pre-requisitos.md), simplemente se debe descargar el archivo Vagranfile `/nodo/Vagrantfile` en el destino deseado y ejecutar el comando `vagrant up`.

1. **Descarga**
   Utilizando curl (ejecuta el primer `vagrant up`):

   ```
   curl -sSLO https://raw.githubusercontent.com/MartinSIbarra/dfhwla/refs/heads/main/nodo/Vagrantfile && vagrant up
   ```

###

2. **Instalación de pluggin para vbgest additions.**

   Luego de desacargar y realizar el primer `vagrant up` se instalara el pluggin para instalar los **_vbgest additions_**, luego de esto es necesario volver a ejecutar `vagrant up` nuevamente para inciar la maquina virtual.

###

3. **Instalación de vbgest additions.**

   Una vez instalado el pluggin al ejecutar `vagrant up` se instalarán los **_vbgest additions_** (a veces son necesarios para el correcto funcionamiento de todas las configuraciones de Vagrant) y tambien se instalaran las dependencias necesarias para poder desplegar el entorno.
   Es recomendable luego la instalación de las dependencias y los **_vbguest-additions_** reiniciar la maquina virtual, se puede hacer usando `vagrant reload`.

###

4. **Uso luego de la instación.**

   Una vez realizados los pasos anteriores quedará operativa e iniciada la maquina vagrant "nodo". Para poder ingresar se debe ejecutar el comando `vagrant ssh`, una vez dentro se puede utilizar como cualquier instalacion de linux, en este caso Ubuntu.

###

5. **Configuración.**

   El archivo **_Vagranfile_** contiene una pequeña sección de parametros, que sirven para customizar el **_nodo_**.

   #####

   ```ruby
    user_params = {
        hostname: "", # Nombre del host, si no se completa toma por defecto "nodo"
        ssh_pwd: "", # Contraseña de ssh, si no se completa toma por defecto "vagrant"
        lan_ipv4_addr: "", # Dirección IPv4 de la red local, si no se completa toma por defecto "192.168.0.171"
        ram_memory: "", # Memoria RAM asignada a la VM, si no se completa toma por defecto "2048"
        cpus: "" # Cantidad de CPUs asignadas a la VM, por defecto 2
    }
   ```

   - **hostname**, pensado para diferenciar un nodo de desarrollo de un nodo de producción, puede tomar cualquier nombre pero no puede repetirse en el caso de querer utilizar mas de un **_nodo_**.

   - **ssh_pwd**, es necesario para poder acceder al **_nodo_** desde fuera de la maquina fisica donde se ejecuta, por ej desde la **_vpn_**.

   - **lan_ipv4_addr**, se utiliza para situar al **_nodo_** en la misma red que la maquina fisica donde ejecuta.

   - **ram_memory** y **cpus**, se utilizan para administrar los recursos que puede usar el **_nodo_**.

###

- _A continuación se listan los comandos mas utilizados en Vagrant._

  | Comando              | Descripción                                                            |
  | -------------------- | ---------------------------------------------------------------------- |
  | `vagrant up`         | _Inicia y provisiona la máquina virtual definida en el `Vagrantfile`._ |
  | `vagrant reload`     | _Reinicia la máquina virtual y aplica cambios del `Vagrantfile`._      |
  | `vagrant ssh`        | _Se conecta por SSH a la máquina virtual._                             |
  | `vagrant halt`       | _Apaga la máquina virtual._                                            |
  | `vagrant halt -f`    | _Fuerza el apagado la máquina virtual._                                |
  | `vagrant destroy -f` | _Elimina completamente la máquina virtual._                            |
  | `vagrant status`     | _Muestra el estado actual de la máquina virtual._                      |
  | `vagrant --help`     | _Muestra la ayuda del comando `vagrant`._                              |

---

### Entorno

Para instalar y configurar el entorno es necesario realizar los siguientes pasos:

- **Descargar archivo de configuración del entorno.**

  Descargar el archivo `docker-compose.yml` en el path deseado.
  Usando **_curl_** seria:

  ```
  curl -sSLO https://raw.githubusercontent.com/MartinSIbarra/dfhwla/refs/heads/main/docker-compose.yml
  ```

###

- **Descargar y modificar el archivo parametros.**
  En el path donde se descargo el archivo `docker-compose.yml` se debe crear una carpeta llamada `params` y dentro se debe descargar el archivo `/examples/params.json` en el path deseado.

  ###

  El siguiente comando crea la carpeta `params` y descarga `params.json` dentro.

  ```
  mkdir -p params && curl -sSLo ./params/params.json https://raw.githubusercontent.com/MartinSIbarra/dfhwla/refs/heads/main/examples/params.json
  ```

  ###

  Luego de descargar el archivo de parameros se deben configurar los parametros que se quieran personalizar.

  #####

  **params.json**:

  ```JSON
  {
      "ddns": {
          "duckdns_update_time": 5, //Indica en segundos cada cuanto se refresca la ip en DuckDNS
          "duckdns_domain": "mi-dominio-duckdns",
          "duckdns_token": "mi-token-duckdns"
      },
      "vpn": {
          "server_url": "mi-dominio-duckdns.duckdns.org",
          "port": "51820",
          "ipv4_net": "10.101.7.0",
          "ipv6_net": "fd00:101:7::",
          "peers_quantity": 20, // Indica la cantidad de peers que se conectaran a la vpn, se pueden generar de mas.
          "ssh_passwd": "mi-contraseña-ssh"
      },
      "tunnel": {
          "ngrok_auth_token": "mi-token-ngrok",
          "ngrok_tunnel_url": "mi-dominio-ngrok.ngrok-free.app",
          "ngrok_tunnel_port": 5000 // Puerto sobre el cual se realizará el tunnel, debe coincidir con el del proxy si se quiere utiliazar este ultimo.
      },
      "proxy": {
          "auto_update_time": 5,
          "listen_port": 5000, // Puerto en el cual escucha el proxy para rutear
          "apps": [
              {
                  "url_path": "prod",
                  "name": "prod-server",
                  "port": 3000 // Puerto en el cual escucha la aplicacion web de producción.
              },
              {
                  "url_path": "uat",
                  "name": "uat-server",
                  "port": 3000 // Puerto en el cual escucha la aplicacion web de producción.
              }
          ]
      },
      "log": {
          "max_file_size": 10000,
          "max_quantity_files": 6
      }
  }
  ```
###

- **Ejecutar el entorno.**
  Una vez configurados los parametros del entorno se puede ejecutar el mismo con el comando `docker compose up -d`.

---

# [⬆︎](../README.md) [⬅︎](./pre-requisitos.md) [➡︎](./desarrollo.md)
