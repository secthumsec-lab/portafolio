# 🪟 Windows Security & Administration

![Windows](https://img.shields.io/badge/Windows-Security-0078D4?style=for-the-badge&logo=windows&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Active Directory](https://img.shields.io/badge/Active_Directory-00BCF2?style=for-the-badge&logo=microsoft&logoColor=white)

## 📋 Descripción

Colección de herramientas, scripts y configuraciones para administración y seguridad de sistemas Windows. Este directorio contiene recursos para gestión de Active Directory, hardening de Windows, scripts PowerShell y herramientas de seguridad para entornos Windows.

## 🎯 Objetivos

- 🔒 **Hardening de Windows** contra amenazas comunes
- 👥 **Administración de AD** y políticas de grupo
- 📊 **Monitoreo de seguridad** en entornos Windows
- 🚨 **Detección de intrusiones** y respuesta a incidentes
- 📋 **Cumplimiento** con estándares de seguridad Microsoft

## 📁 Contenido del Directorio

### 🔧 Scripts PowerShell

#### Administración de Sistemas
- `system-info.ps1` - Información detallada del sistema
- `user-management.ps1` - Gestión de usuarios y grupos
- `service-control.ps1` - Control de servicios Windows
- `registry-tools.ps1` - Utilidades de registro

#### Seguridad y Hardening
- `windows-hardening.ps1` - Script completo de fortalecimiento
- `firewall-config.ps1` - Configuración avanzada de firewall
- `audit-policy.ps1` - Políticas de auditoría
- `bitlocker-setup.ps1` - Configuración de cifrado

#### Active Directory
- `ad-user-management.ps1` - Gestión de usuarios AD
- `group-policy.ps1` - Políticas de grupo
- `ad-health-check.ps1` - Verificación de salud AD
- `domain-migration.ps1` - Migración de dominios

### 📊 Herramientas de Monitoreo

#### Windows Event Logs
- `event-log-analysis.ps1` - Análisis de logs de eventos
- `security-events.ps1` - Monitoreo de eventos de seguridad
- `log-shipping.ps1` - Envío centralizado de logs

#### Performance Monitoring
- `performance-counters.ps1` - Contadores de rendimiento
- `resource-monitoring.ps1` - Monitoreo de recursos
- `alert-system.ps1` - Sistema de alertas

### 🔐 Seguridad Avanzada

#### Endpoint Protection
- `defender-config.ps1` - Configuración de Windows Defender
- `app-locker.ps1` - Políticas de AppLocker
- `device-guard.ps1` - Configuración de Device Guard

#### Network Security
- `ipsec-config.ps1` - Configuración de IPsec
- `vpn-setup.ps1` - Configuración de VPN
- `network-isolation.ps1` - Aislamiento de red

## 🚀 Guía de Implementación

### 1. Preparación del Entorno

#### Requisitos del Sistema
```powershell
# Verificar versión de PowerShell
$PSVersionTable.PSVersion

# Verificar permisos de administrador
([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
```

#### Configuración Inicial
```powershell
# Habilitar ejecución de scripts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Instalar módulos necesarios
Install-Module -Name ActiveDirectory
Install-Module -Name GroupPolicy
```

### 2. Hardening Básico

#### Configuración de Seguridad
```powershell
# Ejecutar hardening básico
.\windows-hardening.ps1 -Level Standard

# Configurar firewall avanzado
.\firewall-config.ps1 -Profile Domain,Private,Public
```

#### Gestión de Usuarios
```powershell
# Crear usuarios con políticas seguras
.\user-management.ps1 -Action Create -Username "usuario" -SecurePassword

# Configurar políticas de contraseñas
.\password-policy.ps1 -Complexity High -History 24
```

### 3. Active Directory

#### Configuración de Dominio
```powershell
# Verificar salud del dominio
.\ad-health-check.ps1 -Detailed

# Configurar políticas de grupo
.\group-policy.ps1 -Policy "Security Baseline" -Scope Domain
```

#### Monitoreo AD
```powershell
# Monitoreo continuo
.\ad-monitoring.ps1 -Continuous -AlertEmail "admin@domain.com"
```

## 🔒 Mejores Prácticas Windows

### ✅ Configuraciones de Seguridad
- **Actualizaciones**: Windows Update automático
- **Antivirus**: Windows Defender configurado
- **Firewall**: Reglas restrictivas por defecto
- **Cuentas**: Principio de menor privilegio

### ✅ Administración Segura
- **PowerShell**: Logging de comandos
- **Auditoría**: Eventos de seguridad habilitados
- **Backup**: Estrategias de respaldo regulares
- **Monitoreo**: Alertas de seguridad configuradas

### ✅ Cumplimiento
- **CIS Benchmarks**: Guías Microsoft
- **STIG**: Configuraciones DoD
- **ISO 27001**: Controles de seguridad

## 📊 Scripts de Verificación

### Verificación de Hardening
```powershell
# Verificación completa de seguridad
.\verify-hardening.ps1 -Report -Export "security-report.html"

# Verificar configuración específica
.\check-defender.ps1
.\check-firewall.ps1
```

### Reportes de Cumplimiento
```powershell
# Generar reporte CIS
.\cis-compliance.ps1 -Level 1 -Format PDF

# Verificar políticas STIG
.\stig-check.ps1 -Category "Windows 10" -Export
```

## 🛠️ Herramientas Recomendadas

### 🔍 Análisis y Auditoría
- **Microsoft ATA**: Advanced Threat Analytics
- **Sysmon**: Monitorización de sistema
- **Event Viewer**: Análisis de logs nativo
- **PowerShell ISE**: Desarrollo de scripts

### 🛡️ Protección
- **Windows Defender ATP**: Endpoint protection
- **AppLocker**: Control de aplicaciones
- **BitLocker**: Cifrado de disco
- **Credential Guard**: Protección de credenciales

### 📊 Monitoreo
- **SCOM**: System Center Operations Manager
- **Azure Monitor**: Monitoreo cloud
- **ELK Stack**: Análisis de logs
- **Grafana**: Dashboards personalizados

## 📚 Recursos Adicionales

### Documentación Microsoft
- [Windows Security](https://docs.microsoft.com/en-us/windows/security/)
- [Active Directory](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/)
- [PowerShell Docs](https://docs.microsoft.com/en-us/powershell/)
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)

### Comunidad
- [Microsoft Tech Community](https://techcommunity.microsoft.com/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [Reddit r/PowerShell](https://reddit.com/r/PowerShell)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/powershell)

## 🤝 Contribuir

### Proceso de Contribución
1. **Fork** el repositorio
2. Crear rama: `git checkout -b feature/ad-hardening-script`
3. **Testear** en Windows Sandbox/VM
4. **Documentar** cambios
5. **Pull Request** detallado

### Estándares
- 📏 **PSScriptAnalyzer** para validación
- 📚 **Comentarios** en español
- 🧪 **Testing** en múltiples versiones Windows
- 📖 **README** actualizado

## ⚠️ Advertencias Importantes

### 🚨 Riesgos
- **Cambios en producción** requieren testing
- **Scripts no firmados** pueden ser bloqueados
- **Políticas de grupo** afectan a múltiples usuarios
- **Backup obligatorio** antes de cambios

### 🔄 Reversión
```powershell
# Restaurar desde backup
Restore-Computer -RestorePoint "Pre-hardening"

# Revertir cambios manualmente
.\undo-hardening.ps1 -Level Standard
```

## 📞 Soporte y Contacto

### Canales de Ayuda
- 📧 **Issues**: Reportes de problemas
- 💬 **Discussions**: Preguntas técnicas
- 📖 **Wiki**: Guías detalladas

### Información de Debug
```powershell
# Información del sistema
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsHardwareAbstractionLayer

# Estado de servicios
Get-Service | Where-Object {$_.Status -eq "Running"}
```

## 📄 Licencia

Este proyecto está bajo la **Licencia MIT** - ver [LICENSE](../LICENSE) para más detalles.

---

🪟 **Fortalece tus sistemas Windows con automatización PowerShell**