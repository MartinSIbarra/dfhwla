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

#####

2. **Instalación de pluggin para vbgest additions.**

   Luego de desacargar y realizar el primer `vagrant up` se instalara el pluggin para instalar los **_vbgest additions_**, luego de esto es necesario volver a ejecutar `vagrant up` nuevamente para inciar la maquina virtual.

#####

3. **Instalación de vbgest additions.**

   Una vez instalado el pluggin al ejecutar `vagrant up` se instalarán los **_vbgest additions_** (a veces son necesarios para el correcto funcionamiento de todas las configuraciones de Vagrant) y tambien se instalaran las dependencias necesarias para poder desplegar el entorno.
   Es recomendable luego la instalación de las dependencias y los **_vbguest-additions_** reiniciar la maquina virtual, se puede hacer usando `vagrant reload`.

#####

4. **Uso luego de la instación.**

   Una vez realizados los pasos anteriores quedará operativa e iniciada la maquina vagrant "nodo". Para poder ingresar se debe ejecutar el comando `vagrant ssh`, una vez dentro se puede utilizar como cualquier instalacion de linux, en este caso Ubuntu.

#####

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

   **hostname**, pensado para diferenciar un nodo de desarrollo de un nodo de producción, puede tomar cualquier nombre pero no puede repetirse en el caso de querer utilizar mas de un **_nodo_**.
   **ssh_pwd**, es necesario para poder acceder al **_nodo_** desde fuera de la maquina fisica donde se ejecuta, por ej desde la **_vpn_**.
   **lan_ipv4_addr**, se utiliza para situar al **_nodo_** en la misma red que la maquina fisica donde ejecuta.
   **ram_memory** y **cpus**, se utilizan para administrar los recursos que puede usar el **_nodo_**.

###

_A continuación se listan los comandos mas utilizados en Vagrant._

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

---

# [⬆︎](../README.md) [⬅︎](./pre-requisitos.md) [➡︎](./desarrollo.md)
