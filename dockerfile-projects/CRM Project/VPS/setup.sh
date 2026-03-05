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
for var in MYSQL_ROOT_PASSWORD MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD ADMIN_USER ADMIN_PASSWORD; do
    if [ -z "${!var}" ]; then
        echo "❌ Error: variable $var no está configurada en .env"
        exit 1
    fi
done

echo "✅ Variables cargadas y validadas desde .env"

# Limpiar contenedores y volúmenes antiguos
echo "🧹 Limpiando contenedores e imágenes antiguas..."
docker-compose down -v 2>/dev/null || true

# Reconstruir imagen
echo "🔨 Construyendo imagen Docker..."
docker-compose build --no-cache

# Levantar contenedores
echo "⬆️  Levantando contenedores..."
docker-compose up -d

# Esperar que MySQL esté listo usando health checks
echo "⏳ Esperando que MySQL esté listo..."
maximum_attempts=30
attempt=0
while [ $attempt -lt $maximum_attempts ]; do
    if docker exec suitecrm_db mysqladmin ping -uroot -p${MYSQL_ROOT_PASSWORD} &>/dev/null; then
        echo "✅ MySQL está listo."
        break
    fi
    attempt=$((attempt + 1))
    if [ $attempt -eq $maximum_attempts ]; then
        echo "❌ Error: MySQL no respondió después de 30 intentos."
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

# Crear usuarios demo en la base de datos
echo "👥 Creando base de datos inicial y usuarios demo..."
docker exec -i suitecrm_db mysql -uroot -p${MYSQL_ROOT_PASSWORD} <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${ADMIN_USER}'@'%' IDENTIFIED BY '${ADMIN_PASSWORD}';
if [ -n "${SUPPORT_USER}" ]; then
  CREATE USER IF NOT EXISTS '${SUPPORT_USER}'@'%' IDENTIFIED BY '${SUPPORT_PASSWORD}';
  GRANT SELECT, INSERT, UPDATE ON ${MYSQL_DATABASE}.* TO '${SUPPORT_USER}'@'%';
fi
if [ -n "${CLIENT_USER}" ]; then
  CREATE USER IF NOT EXISTS '${CLIENT_USER}'@'%' IDENTIFIED BY '${CLIENT_PASSWORD}';
  GRANT SELECT ON ${MYSQL_DATABASE}.* TO '${CLIENT_USER}'@'%';
fi
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${ADMIN_USER}'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "✅ Configuración completada exitosamente"
echo ""
echo "═══════════════════════════════════════"
echo "🎉 SuiteCRM ha sido desplegado"
echo "═══════════════════════════════════════"
echo "📍 URL: http://localhost:8080"
echo "👤 Usuario: ${ADMIN_USER}"
echo "════════════════════════════════════════"