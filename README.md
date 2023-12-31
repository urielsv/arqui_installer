# Arqui Installer
Instalador del container de docker para Arquitectura de Computadoras.

En caso de ser necesario, agregarle permisos de ejecucion al script.
```bash
chmod u+x arqui_installer.sh
```
Para ejecutar el script, simplemente
```bash
./arqui_installer.sh
```
Aclaraciones: 
- El contenedor se creara en ``working directory`` (sera el home para el contenedor).
- Nombre del contenedor debe ser alfanumerico, entre 3 y 20 caracteres.

# Instalacion de Docker
## Instalacion en Windows
Validar el uso de WSL 2 en el sistema con el comando ``wsl -l -p`` desde PowerShell.
Luego, para instalar seguir la guia de instalacion en [Windows install](https://docs.docker.com/desktop/install/windows-install/)

## Instalacion en OSX (MacOS)

Primero, debemos obtener el tipo de procesador con ``uname -p``. En caso de ser una Mac con M1 o M2, ser "ARM".

#### Mac con ARM
Antes de instalar **Docker** debemos instalar **rosetta**.
```bash
softwareupdate --install-rosetta
```

#### Instalacion de Docker con Homebrew
Instalacion de Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Para mas informacion, visitar https://brew.sh/

Luego, para instalar Docker utilizando Homebrew, simplemente:
```bash
brew install --cask Docker
```

Para mas formas de instalacion (sin homebrew) visitar [Mac install](https://docs.docker.com/desktop/install/mac-install/)

## Instalacion en Linux
[Linux install](https://docs.docker.com/desktop/install/linux-install/)
