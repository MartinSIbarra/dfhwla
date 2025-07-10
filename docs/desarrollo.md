[volver](../README.md)

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

[volver](../README.md)