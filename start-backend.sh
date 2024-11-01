#!/bin/sh
REPOSITORY_URL=https://nexus.mct.com.co/repository/bem-release-repo/com/mctgroup/backend

# Función para imprimir mensajes con formato
log_info() {
    echo "ℹ️  $1"
}

log_success() {
    echo "✅ $1"
}

log_error() {
    echo "❌ $1"
}

# Función para verificar variables requeridas
check_required_var() {
    if [ -z "$2" ]; then
        log_error "Variable $1 está vacía"
        exit 1
    fi
    log_success "$1: $2"
}

# Función para descargar JAR
download_jar() {
    local url="$1"
    local output="$2"

    log_info "Descargando $output desde $url"
    if wget -O "$output" "$url"; then
        log_success "Descarga completada: $output"
        return 0
    else
        log_error "Error descargando $output"
        return 1
    fi
}

# Función para iniciar servicio Java
start_java_service() {
    local jar="$1"
    local port="$2"
    local profile="$3"

    if [ ! -f "$jar" ]; then
        log_error "No se encuentra el archivo $jar"
        return 1
    fi

    log_info "Iniciando servicio $jar en puerto $port con perfil $profile"
    java -Dserver.port="$port" -jar "$jar" --spring.profiles.active="$profile" &

    # Guardar PID del proceso
    echo $! > "${jar}.pid"

    # Esperar para verificar que el servicio inició correctamente
    sleep 5
    if kill -0 $! 2>/dev/null; then
        log_success "Servicio $jar iniciado exitosamente (PID: $!)"
        return 0
    else
        log_error "Error al iniciar $jar"
        return 1
    fi
}

# Cargar variables de entorno
if [ ! -f "/app/.env" ]; then
    log_error "Archivo .env no encontrado"
    exit 1
fi

set -a
source /app/.env
set +a

# Verificar variables requeridas
echo "\n📋 Verificando variables de entorno:"
echo "----------------------------------------"
check_required_var "STAGE" "$STAGE"
check_required_var "PORT" "$PORT"
check_required_var "ENV" "$ENV"
check_required_var "PORT_PB" "$PORT_PB"
check_required_var "REPOSITORY_URL" "$REPOSITORY_URL"
check_required_var "VERSION_CONTROLLER_ERP" "$VERSION_CONTROLLER_ERP"
check_required_var "PORT_ERP" "$PORT_ERP"
check_required_var "VERSION_CONTROLLER_MAESTRO" "$VERSION_CONTROLLER_MAESTRO"
check_required_var "PORT_MAESTRO" "$PORT_MAESTRO"
check_required_var "SPRING_PROFILE" "$SPRING_PROFILE"
echo "----------------------------------------"

# Crear directorio para PIDs si no existe
mkdir -p /app/pids

# Iniciar Controller ERP
if download_jar "${REPOSITORY_URL}/controller_erp/${VERSION_CONTROLLER_ERP}" "controller_erp.jar"; then
    if ! start_java_service "controller_erp.jar" "${PORT_ERP}" "$SPRING_PROFILE"; then
        log_error "Fallo al iniciar controller_erp.jar"
        exit 1
    fi
else
    log_error "Fallo al descargar controller_erp.jar"
    exit 1
fi

# Esperar antes de iniciar el siguiente servicio
sleep 10

# Iniciar Controller Maestro
if download_jar "${REPOSITORY_URL}/controller_maestro/${VERSION_CONTROLLER_MAESTRO}" "controller_maestro.jar"; then
    if ! start_java_service "controller_maestro.jar" "${PORT_MAESTRO}" "$SPRING_PROFILE"; then
        log_error "Fallo al iniciar controller_maestro.jar"
        exit 1
    fi
else
    log_error "Fallo al descargar controller_maestro.jar"
    exit 1
fi

# Mantener el script en ejecución y monitorear los servicios
log_info "Todos los servicios iniciados. Monitoreando..."
while true
do
    for jar in controller_erp.jar controller_maestro.jar
    do
        if [ -f "${jar}.pid" ]; then
            pid=$(cat "${jar}.pid")
            if ! kill -0 "$pid" 2>/dev/null; then
                log_error "Servicio $jar (PID: $pid) no está en ejecución!"
            fi
        fi
    done
    sleep 30
done