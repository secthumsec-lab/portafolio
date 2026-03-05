#!/bin/bash
set -e

# Setup automático SuiteCRM + MySQL + usuarios demo
echo "🚀 Iniciando setup de SuiteCRM..."

# Cargar variables de .env
if [ ! -f .env ]; then
    echo "❌ Error: archivo .env no encontrado."
    echo "Por favor crea un archivo .env con las variables necesarias."
    exit 1
fi

export $(grep -v '^#' .env | xargs)

# Validar variables necesarias
for var in MYSQL_ROOT_PASSWORD MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD SUITE_ADMIN_USER SUITE_ADMIN_PASSWORD; do
    if [ -z "${!var}" ]; then
        echo "❌ Error: variable $var no está configurada en .env"
        exit 1
    fi
done

echo "✅ Variables cargadas y validadas desde .env"

# Limpiar contenedores y volúmenes antiguos
echo "🧹 Limpiando contenedores e imágenes antiguas..."
docker-compose down -v 2>/dev/null || true

# Reconstruir imagen (por defecto usa cache para evitar recompilaciones
# pesadas que pueden fallar por bugs del compilador; si necesitas forzar una
# reconstrucción completa define FORCE_BUILD=1 en el entorno antes de ejecutar
# el script). Esto evita el error interno de GCC al recompilar extensiones.
echo "🔨 Construyendo imagen Docker..."
if [ -n "$FORCE_BUILD" ]; then
    docker-compose build --no-cache
else
    docker-compose build
fi

# Levantar contenedores
echo "⬆️  Levantando contenedores..."
docker-compose up -d

# Esperar que MySQL esté listo usando health checks
echo "⏳ Esperando que MySQL esté listo..."
attempt=0
while [ $attempt -lt 120 ]; do  # 2 minutos máximo
    health=$(docker inspect --format='{{.State.Health.Status}}' suitecrm_db 2>/dev/null || echo "unknown")
    if [ "$health" = "healthy" ]; then
        echo "✅ MySQL está listo."
        break
    fi
    attempt=$((attempt + 1))
    if [ $((attempt % 10)) -eq 0 ]; then
        echo "⏳ Esperando MySQL: $attempt segundos transcurridos..."
    fi
    if [ $attempt -eq 120 ]; then
        echo "❌ Error: MySQL no se puso healthy después de 120 segundos."
        exit 1
    fi
    sleep 1
done

# Esperar que la aplicación esté lista
echo "⏳ Esperando que SuiteCRM esté listo..."
maximum_attempts=60
attempt=0
while [ $attempt -lt $maximum_attempts ]; do
    if docker exec suitecrm_app curl -f http://localhost/ &>/dev/null; then
        echo "✅ SuiteCRM está listo."
        break
    fi
    attempt=$((attempt + 1))
    if [ $attempt -eq $maximum_attempts ]; then
        echo "⚠️  SuiteCRM no respondió, pero continuando con setup..."
        break
    fi
    sleep 2
done

# Crear base de datos y usuario MySQL si no existen
echo "👥 Creando base de datos y usuario MySQL..."
SQL="CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\n"
SQL+="CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';\n"
SQL+="GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';\n"
SQL+="FLUSH PRIVILEGES;\n"

# ejecutar en el contenedor
printf "%s" "$SQL" | docker exec -i suitecrm_db mysql -uroot -p${MYSQL_ROOT_PASSWORD}

echo "✅ Configuración de base de datos completada"

# Verificar si SuiteCRM está instalado, si no, instalar automáticamente
echo "🔍 Verificando instalación de SuiteCRM..."
if ! docker exec suitecrm_app test -f /var/www/html/public/legacy/config.php 2>/dev/null; then
    echo "⚠️  SuiteCRM no está instalado. Ejecutando instalación automática..."
    bash install-suitecrm.sh
else
    echo "✅ SuiteCRM ya está instalado"
fi

echo ""
echo "═══════════════════════════════════════"
echo "🎉 SuiteCRM está listo y funcionando"
echo "═══════════════════════════════════════"
echo "📍 URL: ${SUITE_URL}"
echo "👤 Usuario Admin: ${SUITE_ADMIN_USER}"
echo "🔑 Contraseña: [oculta por seguridad]"
echo "════════════════════════════════════════"