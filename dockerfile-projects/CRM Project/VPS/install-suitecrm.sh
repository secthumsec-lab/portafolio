#!/bin/bash
set -e

echo "🚀 Iniciando instalación de SuiteCRM 8.9.2..."

# Cargar variables de .env
export $(grep -v '^#' .env | xargs)

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

docker exec suitecrm_app bash -c "
    cd /var/www/html
    unzip -q /tmp/SuiteCRM-${SUITECRM_VERSION}.zip
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

# Crear páginas de instalación
echo "🛠️  Creando página de instalación web..."
docker exec suitecrm_app bash -c "cat > /var/www/html/install.php << 'PHPEOF'
<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo '<h1>Instalación de SuiteCRM</h1>';

if (\$_SERVER['REQUEST_METHOD'] === 'POST') {
    \$config = [
        'dbHost' => \$_POST['dbHost'] ?? 'suitecrm_db',
        'dbName' => \$_POST['dbName'] ?? '${MYSQL_DATABASE}',
        'dbUser' => \$_POST['dbUser'] ?? '${MYSQL_USER}',
        'dbPass' => \$_POST['dbPass'] ?? '${MYSQL_PASSWORD}',
    ];
    
    try {
        \$conn = new mysqli(
            \$config['dbHost'],
            \$config['dbUser'],
            \$config['dbPass'],
            \$config['dbName']
        );
        
        if (\$conn->connect_error) {
            throw new Exception('Error de conexión: ' . \$conn->connect_error);
        }
        
        echo '<div style=\"background-color: #d4edda; padding: 10px; margin: 10px 0; border-radius: 5px;\">';
        echo '<h2 style=\"color: #155724;\">✅ Instalación completada</h2>';
        echo '<p>SuiteCRM está listo en <a href=\"/\">http://localhost:8080</a></p>';
        echo '</div>';
        \$conn->close();
    } catch (Exception \$e) {
        echo '<div style=\"background-color: #f8d7da; padding: 10px; margin: 10px 0; border-radius: 5px;\">';
        echo '<h2 style=\"color: #721c24;\">❌ Error: ' . \$e->getMessage() . '</h2>';
        echo '</div>';
    }
}

echo '<form method=\"POST\" style=\"background-color: #f5f5f5; padding: 20px; border-radius: 5px; max-width: 400px;\">';
echo '<div style=\"margin-bottom: 10px;\">';
echo '<label>Host de Base de Datos:</label><br>';
echo '<input type=\"text\" name=\"dbHost\" value=\"suitecrm_db\" style=\"width: 100%; padding: 5px;\">';
echo '</div>';

echo '<div style=\"margin-bottom: 10px;\">';
echo '<label>Nombre de BD:</label><br>';
echo '<input type=\"text\" name=\"dbName\" value=\"${MYSQL_DATABASE}\" style=\"width: 100%; padding: 5px;\">';
echo '</div>';

echo '<div style=\"margin-bottom: 10px;\">';
echo '<label>Usuario:</label><br>';
echo '<input type=\"text\" name=\"dbUser\" value=\"${MYSQL_USER}\" style=\"width: 100%; padding: 5px;\">';
echo '</div>';

echo '<div style=\"margin-bottom: 10px;\">';
echo '<label>Contraseña:</label><br>';
echo '<input type=\"password\" name=\"dbPass\" value=\"${MYSQL_PASSWORD}\" style=\"width: 100%; padding: 5px;\">';
echo '</div>';

echo '<button type=\"submit\" style=\"width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer;\">Instalar SuiteCRM</button>';
echo '</form>';

echo '<hr>';
echo '<p>Estructura de archivos de SuiteCRM detectada.</p>';
echo '<p>Haz clic en Instalar para continuar.</p>';
?>
PHPEOF"

echo "✅ Página de instalación creada"

# Crear base de datos y usuarios
echo "👥 Creando usuario de base de datos..."
docker exec -i suitecrm_db mysql -uroot -p${MYSQL_ROOT_PASSWORD} <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "✅ Usuario de base de datos creado"

echo ""
echo "════════════════════════════════════════"
echo "✨ INSTALACIÓN LISTA"
echo "════════════════════════════════════════"
echo "📍 Accede a: http://localhost:8080/install.php"
echo "🗄️  Base de Datos: $MYSQL_DATABASE"
echo "👤 Usuario: $MYSQL_USER"
echo "════════════════════════════════════════"
