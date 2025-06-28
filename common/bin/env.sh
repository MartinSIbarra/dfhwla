#!/bin/bash
if [ "$TEST" != "true" ]; then
    # Setea las variables de entorno para el entornos de produccion
    export ROOT_PATH="$HOME"
    export BIN_PATH="/usr/local/bin"
    export COMMONS_BIN_PATH="$BIN_PATH"
    export CONFIG_PATH="$ROOT_PATH/config"
    export TEMPLATES_PATH="$ROOT_PATH/templates"
    export LOG_PATH="$ROOT_PATH/logs"
    export PARAMS_FILE="$ROOT_PATH/params/params.json"
else
    # Setea las variables de entorno para el entorno de pruebas
    export ROOT_PATH="."
    export BIN_PATH="$ROOT_PATH/bin"
    export COMMONS_BIN_PATH="$ROOT_PATH/common/bin"
    export CONFIG_PATH="$ROOT_PATH/config"
    export TEMPLATES_PATH="$ROOT_PATH/templates"
    export LOG_PATH="$ROOT_PATH/logs"
    export PARAMS_FILE="$ROOT_PATH/params/params.json"
fi

# Hace source para cargar la funcion log
source "$COMMONS_BIN_PATH/log.sh"

mkdir -p "$CONFIG_PATH"
mkdir -p "$TEMPLATES_PATH"
mkdir -p "$LOG_PATH"
