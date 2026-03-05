# 📝 Write-ups y Análisis de Seguridad

![CTF](https://img.shields.io/badge/CTF-Writeups-FF6B35?style=for-the-badge&logo=hackthebox&logoColor=white)
![Security](https://img.shields.io/badge/Cybersecurity-Analysis-000000?style=for-the-badge&logo=security&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Hacking-FCC624?style=for-the-badge&logo=linux&logoColor=black)

## 📋 Descripción

Colección de write-ups detallados de máquinas vulnerables, análisis de vulnerabilidades y soluciones a desafíos de ciberseguridad. Este repositorio documenta el proceso de aprendizaje y resolución de problemas en plataformas de CTF y laboratorios de hacking ético.

## 🎯 Objetivos

- 📚 **Documentar aprendizaje** en ciberseguridad
- 🔍 **Compartir metodologías** de pentesting
- 🛠️ **Crear guías** para principiantes
- 📈 **Mejorar habilidades** de análisis
- 🤝 **Contribuir** a la comunidad de seguridad

## 📁 Estructura de Write-ups

### 🏁 Máquinas Resueltas

#### DockerLabs
Colección de máquinas vulnerables de [DockerLabs](https://dockerlabs.es/)

##### `dockerlabs-aidor/`
[![Difficulty](https://img.shields.io/badge/Difficulty-Easy-green)](dockerlabs-aidor/)
[![Platform](https://img.shields.io/badge/Platform-DockerLabs-blue)](dockerlabs-aidor/)

**Aidor - Máquina Easy de DockerLabs**
- 🎯 **Dificultad**: Fácil
- ⏱️ **Tiempo de resolución**: ~30 minutos
- 🏆 **Vector de ataque**: Web Application
- 📊 **Técnicas**: SQL Injection, Privilege Escalation

**Contenido del write-up:**
- 🔍 Enumeración inicial
- 🌐 Análisis web
- 💉 Explotación de vulnerabilidades
- 🏃 Privilege escalation
- 📝 Lecciones aprendidas

##### `dockerlabs-injection/`
[![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)](dockerlabs-injection/)
[![Platform](https://img.shields.io/badge/Platform-DockerLabs-blue)](dockerlabs-injection/)

**Injection - Máquina Medium de DockerLabs**
- 🎯 **Dificultad**: Media
- ⏱️ **Tiempo de resolución**: ~1 hora
- 🏆 **Vector principal**: SQL Injection avanzado
- 📊 **Técnicas**: Blind SQLi, Command Injection

#### Psycho Series
##### `Psycho/`
[![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)](Psycho/)
[![Platform](https://img.shields.io/badge/Platform-VulnHub-orange)](Psycho/)

**Psycho - Máquina Hard**
- 🎯 **Dificultad**: Difícil
- ⏱️ **Tiempo de resolución**: ~3-4 horas
- 🏆 **Vector principal**: Web Application Complex
- 📊 **Técnicas**: Deserialización, RCE, Privilege Escalation

## 📖 Formato de Write-ups

### Estructura Estándar

Cada write-up sigue una estructura consistente:

#### 1. 📋 Información General
- **Nombre de la máquina**
- **Plataforma** (DockerLabs, VulnHub, HTB, etc.)
- **Dificultad** (Easy, Medium, Hard, Insane)
- **Sistema operativo** de la máquina
- **Autor** del write-up

#### 2. 🔍 Enumeración
- **Escaneo de puertos** con Nmap
- **Análisis de servicios** detectados
- **Enumeración web** con herramientas como Gobuster
- **Búsqueda de vulnerabilidades** conocidas

#### 3. 🎯 Explotación
- **Vectores de ataque** identificados
- **Payloads utilizados**
- **Proceso de explotación** paso a paso
- **Capturas de pantalla** relevantes

#### 4. 🏃 Post-Explotación
- **Escalada de privilegios**
- **Movimiento lateral** (si aplica)
- **Captura de flags**
- **Persistencia** (para máquinas complejas)

#### 5. 📝 Conclusiones
- **Lecciones aprendidas**
- **Herramientas utilizadas**
- **Tiempo total** invertido
- **Dificultades encontradas**

## 🛠️ Herramientas Utilizadas

### 🔍 Enumeración y Reconocimiento
- **Nmap**: Escaneo de puertos y servicios
- **Gobuster/Dirbuster**: Enumeración de directorios web
- **Nikto**: Escaneo de vulnerabilidades web
- **Wpscan**: Análisis de WordPress

### 💉 Explotación
- **Metasploit Framework**: Explotación automatizada
- **SQLMap**: Inyección SQL automatizada
- **Burp Suite**: Análisis y manipulación web
- **Hydra/Hashcat**: Ataques de fuerza bruta

### 🏃 Post-Explotación
- **LinPEAS/WinPEAS**: Enumeración de privilegios
- **Mimikatz**: Extracción de credenciales Windows
- **BloodHound**: Análisis de Active Directory

## 📊 Estadísticas

### 📈 Progreso General
- ✅ **Máquinas resueltas**: 3
- 🎯 **Plataformas**: DockerLabs, VulnHub
- 📊 **Dificultades**: Easy (1), Medium (1), Hard (1)
- ⏱️ **Tiempo promedio**: ~2 horas por máquina

### 🏆 Logros
- 🥇 **Primera blood** en DockerLabs
- 📚 **Aprendizaje continuo** de nuevas técnicas
- 🤝 **Contribución** a la comunidad

## 🚀 Cómo Empezar

### Para Principiantes
1. **Configurar entorno** de hacking ético
2. **Aprender herramientas** básicas (Nmap, Burp, etc.)
3. **Empezar con máquinas fáciles**
4. **Documentar** cada paso del proceso
5. **Unirse** a comunidades de ciberseguridad

### Recursos Recomendados
- [HackTheBox](https://www.hackthebox.com/) - Plataforma de CTF
- [TryHackMe](https://tryhackme.com/) - Rooms guiados
- [VulnHub](https://vulnhub.com/) - Máquinas offline
- [DockerLabs](https://dockerlabs.es/) - Español

## 🤝 Contribuir

### Agregar Nuevo Write-up
1. **Crear directorio** con nombre de la máquina
2. **Estructurar** según formato estándar
3. **Incluir imágenes** en carpeta `images/`
4. **Actualizar** este README
5. **Pull Request** con descripción

### Estándares de Calidad
- 📝 **Lenguaje claro** y conciso
- 🖼️ **Imágenes relevantes** (no spoilers excesivos)
- 🔗 **Referencias** a recursos utilizados
- ✅ **Corrección técnica** verificada

## 📚 Metodología de Pentesting

### 🔍 Fases del Pentesting
1. **Reconocimiento** - Recopilar información
2. **Escaneo** - Identificar vulnerabilidades
3. **Acceso** - Explotar vulnerabilidades
4. **Mantenimiento** - Mantener acceso
5. **Análisis** - Reportar hallazgos

### 🎯 Mindset de Hacker
- 🔍 **Curiosidad** constante
- 📚 **Aprendizaje** continuo
- 🛠️ **Creatividad** en la resolución
- 📝 **Documentación** detallada
- 🤝 **Ética** y responsabilidad

## ⚠️ Consideraciones Éticas

### ✅ Hacking Ético
- 🔒 **Solo sistemas propios** o con permiso
- 📜 **Cumplir leyes** locales e internacionales
- 🤝 **Reportar vulnerabilidades** responsablemente
- 📚 **Educar** sobre ciberseguridad

### 🚫 No Hacer
- ❌ **Atacar sistemas** sin autorización
- ❌ **Compartir exploits** maliciosamente
- ❌ **Vender vulnerabilidades** en dark web
- ❌ **Usar conocimientos** para dañar

## 📞 Comunidad

### Canales de Comunicación
- 💬 **Discord**: Comunidades de ciberseguridad
- 📧 **Foros**: Reddit r/netsec, r/HowToHack
- 🐙 **GitHub**: Issues y Pull Requests
- 📱 **Twitter**: Seguimiento de investigadores

### Eventos y Conferencias
- **Black Hat**: Conferencia anual
- **DEF CON**: Comunidad hacker
- **RootedCON**: Español
- **BSides**: Eventos locales

## 📄 Licencia

Este proyecto está bajo la **Licencia MIT** - ver [LICENSE](../LICENSE) para más detalles.

---

🎯 **"El conocimiento es poder, úsalo con responsabilidad"**