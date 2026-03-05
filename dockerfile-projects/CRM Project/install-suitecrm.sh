#!/bin/bash
set -e

echo "🚀 Iniciando instalación automática de SuiteCRM 8.9.2..."

# Cargar variables de .env si no están ya exportadas
if [ -z "$MYSQL_DATABASE" ]; then
    if [ -f ".env" ]; then
        export $(grep -v '^#' .env | xargs)
    elif [ -f "/home/secthum/github/dockerfile-projects/CRM Project/.env" ]; then
        export $(grep -v '^#' "/home/secthum/github/dockerfile-projects/CRM Project/.env" | xargs)
    else
        echo "❌ Error: archivo .env no encontrado"
        exit 1
    fi
fi

# Verificar si SuiteCRM ya está instalado
echo "🔍 Verificando si SuiteCRM ya está instalado..."
if docker exec suitecrm_app test -f /var/www/html/public/legacy/config.php 2>/dev/null; then
    echo "✅ SuiteCRM ya está instalado. Saltando instalación."
    exit 0
fi

# Descargar SuiteCRM
echo "⬇️  Descargando SuiteCRM 8.9.2..."
SUITECRM_VERSION="8.9.2"
SUITECRM_URL="https://github.com/salesagility/SuiteCRM-Core/releases/download/v${SUITECRM_VERSION}/SuiteCRM-${SUITECRM_VERSION}.zip"

cd /tmp
if [ ! -f "SuiteCRM-${SUITECRM_VERSION}.zip" ]; then
    wget -q --show-progress "${SUITECRM_URL}" -O "SuiteCRM-${SUITECRM_VERSION}.zip" || \
    curl -L -o "SuiteCRM-${SUITECRM_VERSION}.zip" "${SUITECRM_URL}"
fi

echo "✅ Descarga completada"

# Extraer en el contenedor
echo "📦 Extrayendo archivos en el contenedor..."
docker cp "SuiteCRM-${SUITECRM_VERSION}.zip" suitecrm_app:/tmp/
# Copiar configuración PHP antes de extraer
echo "⚙️  Configurando PHP para instalación..."
docker cp php.ini suitecrm_app:/usr/local/etc/php/php.ini
docker exec suitecrm_app bash -c "
    cd /var/www/html
    unzip -q -o /tmp/SuiteCRM-${SUITECRM_VERSION}.zip
    rm -f /tmp/SuiteCRM-${SUITECRM_VERSION}.zip
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;
"

echo "✅ Archivos extraídos correctamente"

# Esperar a que MySQL esté completamente listo
echo "⏳ Esperando que MySQL esté completamente operacional..."
for i in {1..60}; do
    if docker exec suitecrm_db mysqladmin ping -uroot -p${MYSQL_ROOT_PASSWORD} 2>/dev/null; then
        echo "✅ MySQL está listo"
        break
    fi
    if [ $i -eq 60 ]; then
        echo "❌ Error: MySQL no respondió después de 60 intentos"
        exit 1
    fi
    sleep 1
done

# Crear base de datos y usuarios si no existen
echo "👥 Creando base de datos y usuario..."
# Leer la contraseña del secret file si es necesario
if [ -f "secrets/mysql_root_password.txt" ]; then
    MYSQL_ROOT_PASSWORD=$(cat secrets/mysql_root_password.txt)
fi
if [ -f "secrets/mysql_password.txt" ]; then
    MYSQL_PASSWORD=$(cat secrets/mysql_password.txt)
fi

docker exec -i suitecrm_db mysql -u root -p${MYSQL_ROOT_PASSWORD} <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "✅ Base de datos y usuario listos"

# Ejecutar instalación automática de SuiteCRM
echo "🔧 Ejecutando instalación automática de SuiteCRM..."

# Determinar la ruta correcta de .env - buscar en el directorio actual o la ruta del script
if [ ! -f ".env" ]; then
    # Probar diferentes ubicaciones
    for path in "/home/secthum/github/dockerfile-projects/CRM Project/.env" \
                "/docker-project/.env" \
                "../.env" \
                "./../../CRM Project/.env"; do
        if [ -f "$path" ]; then
            ENV_FILE="$path"
            break
        fi
    done
    if [ -z "$ENV_FILE" ]; then
        echo "❌ Error: No se encontró archivo .env"
        echo "   Buscó en: $(pwd y /docker-project, ..)"
        exit 1
    fi
else
    ENV_FILE=".env"
fi

echo "📋 Usando archivo .env desde: $ENV_FILE"

# Copiar .env al contenedor
echo "📋 Copiando configuración al contenedor..."
docker cp "$ENV_FILE" suitecrm_app:/var/www/html/.env

# Ejecutar instalación con variables de entorno explícitas
docker exec \
    -e SUITE_DB_HOST="$SUITE_DB_HOST" \
    -e SUITE_DB_PORT="$SUITE_DB_PORT" \
    -e SUITE_DB_NAME="$SUITE_DB_NAME" \
    -e SUITE_DB_USER="$SUITE_DB_USER" \
    -e SUITE_DB_PASSWORD="$SUITE_DB_PASSWORD" \
    -e SUITE_ADMIN_USER="$SUITE_ADMIN_USER" \
    -e SUITE_ADMIN_PASSWORD="$SUITE_ADMIN_PASSWORD" \
    -e SUITE_URL="$SUITE_URL" \
    -e SUITE_SITE_NAME="$SUITE_SITE_NAME" \
    suitecrm_app bash -c "
    cd /var/www/html
    echo '📦 Instalando dependencias de PHP...'
    php -d allow_url_fopen=On -d allow_url_include=Off /usr/local/bin/composer install --prefer-dist --no-interaction --optimize-autoloader 2>&1 | tail -10
    echo '🔧 Ejecutando instalación automática de SuiteCRM...'
    php bin/console suitecrm:app:install \
        --db_driver=pdo_mysql \
        --db_host=\${SUITE_DB_HOST} \
        --db_port=\${SUITE_DB_PORT} \
        --db_name=\${SUITE_DB_NAME} \
        --db_user=\${SUITE_DB_USER} \
        --db_password=\${SUITE_DB_PASSWORD} \
        --site_username=\${SUITE_ADMIN_USER} \
        --site_password=\${SUITE_ADMIN_PASSWORD} \
        --site_host=localhost \
        --site_url=\${SUITE_URL} \
        --system_name=\${SUITE_SITE_NAME} \
        --demo_data=0 \
        --license_accepted=1 \
        --no-interaction
"

if [ $? -eq 0 ]; then
    echo "✅ Instalación automática completada"
else
    echo "❌ Error en la instalación automática"
    exit 1
fi

# Limpiar archivos de instalación
echo "🧹 Limpiando archivos temporales..."
docker exec suitecrm_app bash -c "
    rm -f /var/www/html/public/install.php
    chmod -R 755 /var/www/html
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;
    chown -R www-data:www-data /var/www/html
"

echo ""
echo "════════════════════════════════════════"
echo "✨ INSTALACIÓN COMPLETA Y AUTOMÁTICA"
echo "════════════════════════════════════════"
echo "📍 Accede a: ${SUITE_URL}"
echo "👤 Usuario Admin: ${SUITE_ADMIN_USER}"
echo "🔑 Contraseña: ${SUITE_ADMIN_PASSWORD}"
echo "════════════════════════════════════════"
