# � CRM Project - SuiteCRM 8.9.2

![SuiteCRM](https://img.shields.io/badge/SuiteCRM-8.9.2-FF6B35?style=for-the-badge&logo=suitecrm&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-8.1-777BB4?style=for-the-badge&logo=php&logoColor=white)

## 📋 Descripción

Sistema CRM completo basado en **SuiteCRM 8.9.2** con instalación automatizada, configuración de seguridad avanzada y despliegue optimizado para producción. Este proyecto elimina la necesidad de instalación manual a través de la interfaz web.

## ✨ Características Principales

### 🚀 Instalación Automática
- ✅ **CLI Installation**: Sin necesidad de instalación web manual
- 🔄 **Auto-restart**: Reinicio automático en caso de fallos
- 📦 **Dependencias**: Instalación automática de Composer

### 🔒 Seguridad Avanzada
- 🛡️ **Hardening PHP**: Funciones peligrosas deshabilitadas
- 🔐 **Secrets Management**: Contraseñas en archivos seguros
- 👤 **Usuario No-Root**: Apache ejecutándose como www-data
- 🚫 **Exposición Mínima**: expose_php = Off

### 🐳 Infraestructura
- 🗄️ **MySQL 8.0**: Base de datos optimizada
- 🌐 **Apache 2.4**: Servidor web con PHP 8.1
- 📊 **Health Checks**: Monitoreo automático de servicios
- 🔄 **Networks**: Aislamiento de red entre servicios

## 📁 Estructura del Proyecto

```
CRM Project/
├── docker-compose.yml    # Configuración de servicios
├── Dockerfile           # Imagen personalizada de PHP-Apache
├── setup.sh            # Script de instalación automática
├── install-suitecrm.sh # Instalador de SuiteCRM
├── php.ini            # Configuración PHP optimizada
├── .env               # Variables de entorno
├── secrets/           # Contraseñas seguras
│   ├── mysql_root_password.txt
│   └── mysql_password.txt
└── mysql/
    └── init.sql       # Inicialización de base de datos
```

## 🚀 Instalación y Uso

### Requisitos Previos
- 🐧 **Linux** (Ubuntu/Debian recomendado)
- 🐳 **Docker** >= 20.10
- 🐳 **Docker Compose** >= 2.0
- 💾 **4GB RAM** mínimo
- 💽 **2GB** espacio en disco

### Instalación Automática

```bash
# Clonar o navegar al directorio
cd CRM\ Project

# Ejecutar setup automático
bash setup.sh
```

El script automáticamente:
1. ✅ Valida variables de entorno
2. 🧹 Limpia contenedores antiguos
3. 🔨 Construye imagen Docker
4. ⬆️ Levanta servicios con Docker Compose
5. ⏳ Espera que MySQL esté listo
6. 📦 Instala SuiteCRM automáticamente
7. 🎉 Muestra credenciales de acceso

### Acceso al Sistema

Después de la instalación:
- 🌐 **URL**: http://localhost:8080
- 👤 **Usuario Admin**: admin
- 🔑 **Contraseña**: admin123

## 🔧 Configuración

### Variables de Entorno (.env)

```bash
# Base de datos
MYSQL_ROOT_PASSWORD=SuiteCRM_Root_2024!
MYSQL_DATABASE=crm
MYSQL_USER=crmuser
MYSQL_PASSWORD=SuiteCRM_User_2024!

# SuiteCRM
SUITE_URL=http://localhost:8080
SUITE_ADMIN_USER=admin
SUITE_ADMIN_PASSWORD=admin123
SUITE_DB_HOST=suitecrm_db
SUITE_DB_NAME=crm
SUITE_DB_USER=crmuser
SUITE_DB_PASSWORD=SuiteCRM_User_2024!
```

### Secrets

Las contraseñas se almacenan de forma segura en `secrets/`:
- `mysql_root_password.txt`: Contraseña root de MySQL
- `mysql_password.txt`: Contraseña del usuario MySQL

## 📊 Monitoreo y Mantenimiento

### Verificar Estado
```bash
# Estado de contenedores
docker-compose ps

# Logs en tiempo real
docker-compose logs -f

# Logs de un servicio específico
docker-compose logs suitecrm_app
```

### Health Checks
- ✅ **MySQL**: Verificación de conectividad cada 5s
- ✅ **SuiteCRM**: Verificación HTTP cada 5s
- 🔄 **Auto-restart**: Reinicio automático en fallos

### Backup de Datos
```bash
# Backup de base de datos
docker exec suitecrm_db mysqldump -u crmuser -p crm > backup.sql

# Backup de archivos
docker run --rm -v crmproject_crmproject_data:/data -v $(pwd):/backup alpine tar czf /backup/crm_backup.tar.gz -C /data .
```

## 🔒 Configuración de Seguridad

### PHP Security
- `disable_functions`: exec, passthru, shell_exec, system, etc.
- `expose_php = Off`
- `allow_url_fopen = On` (solo durante instalación)
- `allow_url_include = Off`

### Docker Security
- 👤 Usuario no-root en contenedores
- 🔒 Secrets para contraseñas
- 🛡️ Resource limits (512MB RAM, 0.5 CPU)
- 📝 Logging estructurado

### Red y Firewall
- 🌐 Puerto 8080 expuesto
- 🔒 Red interna para comunicación DB
- 🚫 Sin puertos innecesarios expuestos

## 🐛 Solución de Problemas

### Problemas Comunes

#### ❌ "Could not open input file: bin/console"
- **Solución**: Verificar que SuiteCRM esté extraído correctamente
- **Comando**: `docker exec suitecrm_app ls -la /var/www/html/bin/`

#### ❌ Error de conexión a MySQL
- **Solución**: Verificar health check de MySQL
- **Comando**: `docker-compose logs suitecrm_db`

#### ❌ 404 en la aplicación
- **Solución**: Verificar DocumentRoot
- **Comando**: `docker exec suitecrm_app apachectl -S`

### Logs de Debug
```bash
# Logs de instalación
docker exec suitecrm_app cat /var/www/html/public/logs/install.log 2>/dev/null || echo "No install log"

# Logs de SuiteCRM
docker exec suitecrm_app tail -f /var/www/html/public/legacy/suitecrm.log
```

## 📈 Optimización

### Recursos del Sistema
- 🖥️ **CPU**: 0.5 cores por servicio
- 💾 **RAM**: 512MB por servicio
- 💽 **Disco**: Volúmenes persistentes para datos

### Rendimiento
- ⚡ **OPcache**: Habilitado para PHP
- 📊 **MySQL**: Configuración optimizada
- 🌐 **Apache**: Módulos rewrite y headers activados

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama (`git checkout -b feature/mejora-seguridad`)
3. Commit cambios (`git commit -m 'Mejora: hardening adicional'`)
4. Push (`git push origin feature/mejora-seguridad`)
5. Abre Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 📞 Soporte

Para soporte técnico:
- 📧 **Issues**: [GitHub Issues](../../issues)
- 📖 **Documentación**: [SuiteCRM Docs](https://docs.suitecrm.com/)
- 🐛 **Debug**: Revisa logs con `docker-compose logs`

⭐ **¡Un CRM seguro y automatizado para tu negocio!**

### 3. Ejecutar setup automático

```bash
bash setup.sh
```

Esto automáticamente:
- ✅ Limpia contenedores antiguos
- ✅ Construye imágenes Docker
- ✅ Inicia los servicios con secrets seguros
- ✅ Configura la base de datos MySQL 8.0
- ✅ **Instala SuiteCRM automáticamente via CLI** (sin intervención manual)
- ✅ Verifica health checks y disponibilidad

### 4. Acceder a SuiteCRM

```
URL: http://localhost:8080
Usuario: admin (configurado en .env SUITE_ADMIN_USER)
Contraseña: admin123 (configurada en .env SUITE_ADMIN_PASSWORD)
```

**¡La instalación es completamente automática!** No necesitas acceder al web installer.

## 🏗️ Estructura del Proyecto

```
CRM Project/
├── Dockerfile              # Imagen PHP-Apache con SuiteCRM
├── docker-compose.yml      # Orquestación de servicios con secrets
├── php.ini                 # Configuración optimizada de PHP
├── .env                    # Variables de entorno (crear desde .env.example)
├── .env.example            # Plantilla de variables
├── .gitignore              # Exclusiones de Git (secrets)
├── setup.sh                # Script de instalación automática
├── install-suitecrm.sh     # Instalación CLI de SuiteCRM
├── secrets/                # Archivos de secrets Docker
│   ├── mysql_root_password.txt
│   └── mysql_password.txt
├── mysql/
│   └── init.sql           # Inicialización de BD con índices
└── nginx/
    └── default.conf       # Configuración nginx con SSL
```

## 🔒 Mejoras de Seguridad

- ✅ MySQL 8.0 (versión actual LTS)
- ✅ PHP con OPcache habilitado
- ✅ Headers de seguridad HTTP configurados
- ✅ SSL/TLS ready (Nginx)
- ✅ Health checks en contenedores
- ✅ Funciones PHP peligrosas deshabilitadas
- ✅ Base de datos con índices optimizados
- ✅ **Docker Secrets** para contraseñas (no expuestas en env)
- ✅ Usuario no-root para Apache
- ✅ Instalación automática CLI (sin web wizard)
- ✅ Logging rotativo con límites
- ✅ Límites de recursos por contenedor
- ✅ Variables de entorno para configuración segura

## 📈 Optimizaciones de Rendimiento

- OPcache: 128MB con 4000 archivos
- GZIP: Compresión automática de respuestas
- MySQL 8.0: Mejor rendimiento que 5.7
- Health checks: Reintentos automáticos inteligentes
- Índices de BD: Búsquedas optimizadas
- **Límites de recursos**: 512MB RAM, 0.5 CPU por servicio
- **Logging rotativo**: Máximo 10MB por archivo, 3 archivos
- **Docker Secrets**: Sin overhead de variables de entorno
- **Instalación CLI**: Setup automatizado sin intervención manual

## 🔧 Comandos Útiles

### Ver logs
```bash
docker-compose logs -f suitecrm_app
docker-compose logs -f suitecrm_db
```

### Detener servicios
```bash
docker-compose down
```

### Reiniciar servicios
```bash
docker-compose restart
```

### Acceder a MySQL
```bash
docker exec -it suitecrm_db mysql -u$MYSQL_USER -p$MYSQL_PASSWORD suitecrm_db
```

### Acceder al contenedor PHP
```bash
docker exec -it suitecrm_app bash
```

## 📊 Puertos Utilizados

| Servicio | Puerto |
|----------|--------|
| SuiteCRM HTTP | 8080 |
| MySQL | 3306 (interno) |

## ⚙️ Variables de Entorno

Ver `.env.example` para configuración completa.

**Variables críticas de MySQL:**
- `MYSQL_ROOT_PASSWORD` - Contraseña root de MySQL
- `MYSQL_DATABASE` - Nombre de base de datos
- `MYSQL_USER` - Usuario de aplicación
- `MYSQL_PASSWORD` - Contraseña de usuario

**Variables de SuiteCRM:**
- `SUITE_URL` - URL de acceso (http://localhost:8080)
- `SUITE_ADMIN_USER` - Usuario administrador
- `SUITE_ADMIN_PASSWORD` - Contraseña administrador
- `SUITE_DB_*` - Configuración conexión BD
- `SUITE_SITE_NAME` - Nombre del sitio

**Seguridad:**
- Contraseñas almacenadas en `secrets/` directory
- Docker Secrets para inyección segura en contenedores

## 📝 Notas

- Primera instalación puede tomar 2-3 minutos
- Los datos se persisten en volúmenes Docker
- **Instalación completamente automática** - no requiere intervención manual
- Backup recomendado antes de actualizaciones
- Secrets en `secrets/` directory - nunca commitear

## 🐛 Troubleshooting

**Puerto 8080 en uso:**
```bash
docker-compose down
# O cambiar puerto en docker-compose.yml
```

**MySQL no responde:**
```bash
docker-compose restart suitecrm_db
```

**Errores de permisos:**
```bash
docker exec suitecrm_app chown -R www-data:www-data /var/www/html
```

## 📞 Soporte

Para issues: revisar logs con `docker-compose logs`

## 📄 Licencia

SuiteCRM - AGPL v3
