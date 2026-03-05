# 🔧 Scripts de Automatización

![Bash](https://img.shields.io/badge/Bash-Scripts-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ready-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Security](https://img.shields.io/badge/Security-Tools-FF0000?style=for-the-badge&logo=security&logoColor=white)

## 📋 Descripción

Colección de scripts Bash para automatización de tareas administrativas, análisis de seguridad y monitoreo de sistemas Linux. Estos scripts están diseñados para facilitar la gestión de sistemas y mejorar la seguridad informática.

## 📁 Scripts Disponibles

### 🔍 Análisis y Monitoreo

#### `anomaly-detection.sh`
[![Bash](https://img.shields.io/badge/Bash-Script-green)](anomaly-detection.sh)

**Detección de anomalías en sistemas**
- 📊 Análisis de logs del sistema
- 🚨 Detección de patrones sospechosos
- 📈 Reportes de actividad inusual

```bash
bash anomaly-detection.sh
```

#### `baseline-comparer.sh`
[![Bash](https://img.shields.io/badge/Bash-Script-green)](baseline-comparer.sh)

**Comparación de líneas base del sistema**
- 🔍 Comparación de archivos críticos
- 📋 Verificación de integridad
- ⚠️ Alertas de cambios no autorizados

#### `blue-team-eye.sh`
[![Bash](https://img.shields.io/badge/Bash-Script-blue)](blue-team-eye.sh)

**Herramienta de monitoreo Blue Team**
- 👁️ Monitoreo continuo de seguridad
- 📝 Logging de eventos críticos
- 🚨 Alertas en tiempo real

### 🔐 Seguridad y Hardening

#### `defencive-auth.sh`
[![Bash](https://img.shields.io/badge/Bash-Script-red)](defencive-auth.sh)

**Configuración de autenticación defensiva**
- 🔒 Configuración de PAM
- 🚫 Bloqueo de cuentas por fuerza bruta
- ⏰ Políticas de contraseñas

#### `privesc-linux-audit.sh`
[![Bash](https://img.shields.io/badge/Bash-Script-orange)](privesc-linux-audit.sh)

**Auditoría de escalada de privilegios**
- 🔍 Búsqueda de vulnerabilidades de privesc
- 📋 Verificación de permisos SUID/SGID
- ⚠️ Reporte de configuraciones riesgosas

### 🏗️ Configuración del Sistema

#### `baseline-linux-create.sh`
[![Bash](https://img.shields.io/badge/Bash-Script-purple)](baseline-linux-create.sh)

**Creación de línea base del sistema**
- 📸 Captura del estado actual del sistema
- 💾 Backup de configuraciones críticas
- 📊 Generación de hashes de integridad

## 🚀 Uso General

### Requisitos
- 🐧 **Linux** (Ubuntu, Debian, CentOS, etc.)
- 🔑 **Permisos de root** para scripts de sistema
- 📂 **Bash** >= 4.0

### Instalación
```bash
# Clonar el directorio de scripts
git clone <repo-url>
cd scripts/

# Dar permisos de ejecución
chmod +x *.sh
```

### Ejecución Segura
```bash
# Siempre revisar el script antes de ejecutarlo
cat script-name.sh

# Ejecutar con permisos apropiados
sudo bash script-name.sh

# O para scripts no-root
bash script-name.sh
```

## 🔒 Consideraciones de Seguridad

### ✅ Mejores Prácticas
- 🔍 **Revisar código** antes de ejecutar
- 👤 **Ejecutar con mínimos privilegios**
- 📝 **Logging habilitado** en producción
- 💾 **Backup** antes de cambios críticos

### ⚠️ Advertencias
- Algunos scripts requieren **permisos de root**
- **Probar en entornos no-productivos** primero
- Scripts pueden **modificar configuraciones del sistema**

## 📊 Funcionalidades Comunes

### Logging Estructurado
Todos los scripts incluyen:
- 📅 Timestamps en logs
- 📋 Niveles de severidad (INFO, WARN, ERROR)
- 📁 Archivos de log rotativos

### Manejo de Errores
- ✅ Validación de dependencias
- 🚨 Captura de errores
- 📤 Códigos de salida informativos

### Configuración Flexible
- 🔧 Variables de entorno
- 📄 Archivos de configuración
- ⚙️ Parámetros por línea de comandos

## 🛠️ Ejemplos de Uso

### Monitoreo Continuo
```bash
# Ejecutar detección de anomalías cada hora
crontab -e
# Agregar: 0 * * * * /path/to/scripts/anomaly-detection.sh
```

### Auditoría de Seguridad
```bash
# Verificación semanal de privilegios
sudo bash privesc-linux-audit.sh --full-scan --report
```

### Backup Automático
```bash
# Crear baseline diaria
0 2 * * * /path/to/scripts/baseline-linux-create.sh --output /backups/
```

## 🤝 Contribuir

### Estándares de Código
- 📏 **ShellCheck** compliant
- 📚 **Comentarios** en español
- 🎯 **Funciones modulares**
- 🧪 **Testing** en múltiples distribuciones

### Proceso de Contribución
1. Fork el repositorio
2. Crear rama descriptiva: `git checkout -b feature/nuevo-script-seguridad`
3. Commit cambios: `git commit -m 'feat: agregar script de hardening SSH'`
4. Push: `git push origin feature/nuevo-script-seguridad`
5. Pull Request con descripción detallada

## 📖 Documentación

Cada script incluye:
- 📋 **Header** con descripción y autor
- 🔧 **Uso** y parámetros
- 📚 **Ejemplos** de ejecución
- 🐛 **Troubleshooting** básico

## 📞 Soporte

### Canales de Comunicación
- 📧 **Issues**: Para reportes de bugs
- 💬 **Discussions**: Para preguntas generales
- 📖 **Wiki**: Documentación detallada

### Reporte de Problemas
```bash
# Incluir información del sistema
uname -a
bash --version

# Output del script con debug
bash -x script-name.sh
```

## 📄 Licencia

Este proyecto está bajo la **Licencia MIT** - ver [LICENSE](../LICENSE) para más detalles.

---

⭐ **¡Automatiza tu seguridad Linux con scripts profesionales!**