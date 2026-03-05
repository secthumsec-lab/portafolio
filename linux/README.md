# 🐧 Linux Security & Hardening

![Linux](https://img.shields.io/badge/Linux-Security-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Hardening](https://img.shields.io/badge/System-Hardening-FF6B35?style=for-the-badge&logo=security&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripts-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)

## 📋 Descripción

Colección de herramientas, scripts y configuraciones para hardening y seguridad de sistemas Linux. Este directorio contiene recursos para fortalecer servidores Linux contra amenazas comunes y mejorar la postura de seguridad general.

## 🎯 Objetivos

- 🔒 **Hardening del sistema** contra ataques comunes
- 🛡️ **Configuración segura** de servicios
- 📊 **Monitoreo continuo** de seguridad
- 🚨 **Detección de intrusiones**
- 📋 **Cumplimiento** con estándares de seguridad

## 📁 Contenido del Directorio

### 🔧 Scripts de Hardening

#### Configuraciones del Kernel
- `sysctl.conf` - Parámetros de red y seguridad del kernel
- `limits.conf` - Límites de recursos por usuario
- `security-limits.conf` - Configuraciones de PAM

#### Servicios Seguros
- `sshd_config` - Configuración hardening de SSH
- `apache2.conf` - Configuración segura de Apache
- `mysql_secure.sh` - Script de securización de MySQL

#### Firewall y Red
- `iptables.rules` - Reglas de firewall
- `ufw-config.sh` - Configuración de UFW
- `fail2ban.conf` - Configuración anti-brute force

### 📊 Herramientas de Monitoreo

#### Detección de Intrusiones
- `ossec-setup.sh` - Instalación y configuración de OSSEC
- `snort-config/` - Configuración de Snort IDS
- `aide-setup.sh` - Sistema de detección de cambios

#### Logging y Alertas
- `rsyslog.conf` - Configuración centralizada de logs
- `logrotate.d/` - Rotación de logs de seguridad
- `auditd.rules` - Reglas de auditoría del sistema

### 🔐 Autenticación y Acceso

#### PAM y Autenticación
- `pam.d/` - Configuraciones PAM personalizadas
- `sudoers.d/` - Configuraciones sudo seguras
- `ldap-auth.sh` - Configuración de autenticación LDAP

#### Control de Acceso
- `apparmor-profiles/` - Perfiles AppArmor
- `selinux-policies/` - Políticas SELinux
- `access-control.sh` - Script de control de acceso

## 🚀 Guía de Implementación

### 1. Evaluación Inicial
```bash
# Verificar distribución y versión
cat /etc/os-release

# Estado actual de seguridad
sudo lynis audit system

# Verificar servicios corriendo
sudo netstat -tlnp
```

### 2. Backup de Configuraciones
```bash
# Backup de configuraciones críticas
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
sudo cp /etc/sysctl.conf /etc/sysctl.conf.backup

# Crear punto de restauración
sudo timeshift --create --comments "Pre-hardening backup"
```

### 3. Aplicación de Hardening

#### Kernel y Sistema
```bash
# Aplicar configuraciones del kernel
sudo cp sysctl.conf /etc/sysctl.conf
sudo sysctl -p

# Configurar límites
sudo cp limits.conf /etc/security/limits.conf
```

#### SSH Hardening
```bash
# Configuración segura de SSH
sudo cp sshd_config /etc/ssh/sshd_config
sudo systemctl reload sshd

# Verificar configuración
sudo sshd -t
```

#### Firewall
```bash
# Configurar UFW
sudo bash ufw-config.sh

# Verificar reglas
sudo ufw status verbose
```

### 4. Monitoreo y Alertas
```bash
# Configurar logging centralizado
sudo cp rsyslog.conf /etc/rsyslog.conf
sudo systemctl restart rsyslog

# Instalar y configurar OSSEC
sudo bash ossec-setup.sh
```

## 🔒 Mejores Prácticas Implementadas

### ✅ Configuraciones de Seguridad
- **SSH**: Deshabilitar root login, usar key-only auth
- **Firewall**: Reglas minimalistas, drop por defecto
- **Servicios**: Deshabilitar servicios innecesarios
- **Permisos**: Principio de menor privilegio

### ✅ Monitoreo Continuo
- **Logs**: Centralización y rotación automática
- **Auditoría**: Seguimiento de cambios críticos
- **Alertas**: Notificaciones de eventos de seguridad

### ✅ Cumplimiento
- **CIS Benchmarks**: Guías de hardening estándar
- **STIG**: Configuraciones del DoD
- **ISO 27001**: Controles de seguridad

## 📊 Scripts de Verificación

### Verificación de Hardening
```bash
# Ejecutar verificación completa
sudo bash verify-hardening.sh

# Verificar configuración específica
sudo bash check-ssh-security.sh
sudo bash check-firewall-rules.sh
```

### Reportes de Seguridad
```bash
# Generar reporte de cumplimiento
sudo bash security-audit.sh --report

# Verificar integridad de archivos
sudo aide --check
```

## 🛠️ Herramientas Recomendadas

### 🔍 Análisis y Auditoría
- **Lynis**: Auditoría de seguridad del sistema
- **OpenVAS**: Escaneo de vulnerabilidades
- **Chkrootkit**: Detección de rootkits

### 🛡️ Protección
- **Fail2Ban**: Prevención de ataques de fuerza bruta
- **OSSEC**: HIDS de código abierto
- **Snort**: Sistema de detección de intrusiones

### 📊 Monitoreo
- **Nagios/Icinga**: Monitoreo de infraestructura
- **ELK Stack**: Análisis de logs
- **Grafana**: Dashboards de seguridad

## 📚 Recursos Adicionales

### Documentación
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [OWASP Linux Security](https://owasp.org/www-project-linux-security/)

### Comunidad
- [Linux Security Mailing List](https://www.linuxsecurity.com/)
- [Reddit r/linux4noobs](https://reddit.com/r/linux4noobs)
- [Stack Exchange Security](https://security.stackexchange.com/)

## 🤝 Contribuir

### Proceso de Contribución
1. **Fork** el repositorio
2. Crear rama: `git checkout -b feature/ssh-hardening-improvement`
3. **Testear** cambios en VM limpia
4. **Documentar** cambios en README
5. **Pull Request** con descripción detallada

### Estándares
- 📏 **ShellCheck** para validación de scripts
- 📚 **Comentarios** claros en español
- 🧪 **Testing** en múltiples distribuciones
- 📖 **Documentación** actualizada

## ⚠️ Advertencias Importantes

### 🚨 Riesgos
- **Configuraciones incorrectas** pueden dejar el sistema inaccesible
- **Cambios en producción** requieren testing exhaustivo
- **Backup obligatorio** antes de cualquier cambio

### 🔄 Reversión
```bash
# Restaurar desde backup
sudo timeshift --restore

# O revertir manualmente
sudo cp /etc/ssh/sshd_config.backup /etc/ssh/sshd_config
sudo systemctl restart sshd
```

## 📞 Soporte y Contacto

### Canales de Ayuda
- 📧 **Issues**: Reportes de bugs y problemas
- 💬 **Discussions**: Preguntas y consejos
- 📖 **Wiki**: Guías detalladas de implementación

### Información de Debug
```bash
# Información del sistema
uname -a
lsb_release -a

# Estado de servicios
sudo systemctl status sshd
sudo ufw status
```

## 📄 Licencia

Este proyecto está bajo la **Licencia MIT** - ver [LICENSE](../LICENSE) para más detalles.

---

🛡️ **Fortalece tu Linux con configuraciones de seguridad profesionales**