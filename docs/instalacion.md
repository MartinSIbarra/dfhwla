[volver](../README.md)

## Pre-requisitos
La solución funciona con **Vagrant** y **VirtualBox**, por lo que es necesario tenerlos instalados en el sistema. También será necesario **curl** (opcional) para la descarga de los archivos de instalación. Además, para la utilización de la máquina **DevOps** será necesaria una cuenta en **Ngrok**.

## Instalación
El repositorio cuenta con un instalador para **Linux** y **Windows**, para facilitar el proceso de instalación con una interfaz de usuario. Solo para la máquina **DevOps** es necesario realizar un paso intermedio para configurar **ngrok**.
Copiar y pegar el siguiente comando en la terminal. 
Antes de ejecutarlo, debe modificar `"/ruta/donde/guardar"` ó `"C:\Ruta\Donde\Guardar"` por la ruta deseada para descargar el archivo. Este comando descargará el archivo instalador y lo ejecutará para comenzar con la instalación de los servidores.

### Linux
```bash
destino="/ruta/donde/guardar"; curl -o $destino/install.sh https://raw.githubusercontent.com/MartinSIbarra/free-hosting-with-local-architecture/main/install.sh && chmod +x $destino/install.sh && $destino/install.sh
```

### Windows (powershell)
```powershell
$destino="C:\Ruta\Donde\Guardar"; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MartinSIbarra/free-hosting-with-local-architecture/main/install.ps1" -OutFile "$destino\install.ps1"; & "$destino\install.ps1"
```
Asegúrate de que PowerShell tenga permisos para ejecutar scripts:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

[volver](../README.md)