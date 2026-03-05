# 🐳 Proyectos Docker

![Docker](https://img.shields.io/badge/Docker-Projects-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Containerization](https://img.shields.io/badge/Containerization-Ready-00ADD8?style=for-the-badge&logo=docker&logoColor=white)

## 📋 Descripción

Esta carpeta contiene una colección de proyectos containerizados utilizando **Docker** y **Docker Compose**. Cada proyecto está diseñado para ser fácilmente desplegable, escalable y seguro.

## 📁 Estructura de Proyectos

### 💼 CRM Project
[![SuiteCRM](https://img.shields.io/badge/SuiteCRM-8.9.2-FF6B35?style=flat-square)](CRM%20Project)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square)](CRM%20Project)
[![PHP](https://img.shields.io/badge/PHP-8.1-777BB4?style=flat-square)](CRM%20Project)

**Sistema CRM completo con SuiteCRM**
- ✅ Instalación automatizada
- 🔒 Configuración de seguridad avanzada
- 🐳 Despliegue con Docker Compose
- 📊 Base de datos MySQL optimizada

```bash
cd CRM\ Project
bash setup.sh
```

### 🤖 AI Projects
[![Python](https://img.shields.io/badge/Python-3.9-3776AB?style=flat-square)](ai)
[![Machine Learning](https://img.shields.io/badge/ML-Ready-FF6F00?style=flat-square)](ai)

**Proyectos de Inteligencia Artificial**
- Modelos de machine learning
- APIs de IA
- Procesamiento de datos

### 🔧 Back-End APIs
[![Node.js](https://img.shields.io/badge/Node.js-18-339933?style=flat-square)](back-end)
[![Express](https://img.shields.io/badge/Express-4.18-000000?style=flat-square)](back-end)

**APIs y servicios backend**
- Microservicios REST
- APIs GraphQL
- Servicios de autenticación

### 🎨 Front-End Applications
[![React](https://img.shields.io/badge/React-18-61DAFB?style=flat-square)](front-end)
[![Vue.js](https://img.shields.io/badge/Vue.js-3-4FC08D?style=flat-square)](front-end)

**Aplicaciones web modernas**
- SPAs con React/Vue
- Interfaces responsivas
- UX/UI optimizada

## 🚀 Inicio Rápido

### Requisitos
- 🐳 **Docker** y **Docker Compose**
- 💾 Al menos 4GB RAM disponible
- 💽 Espacio en disco: 2GB+

### Despliegue General

```bash
# Navegar al proyecto deseado
cd [nombre-del-proyecto]

# Ejecutar setup (si existe)
bash setup.sh

# O usar Docker Compose directamente
docker-compose up -d
```

## 🔒 Consideraciones de Seguridad

Todos los proyectos incluyen:
- 🔐 **Secrets management** con Docker secrets
- 🛡️ **Hardening** de contenedores
- 🚫 **Funciones PHP peligrosas** deshabilitadas
- 👤 **Usuario no-root** en contenedores

## 📊 Monitoreo

Cada proyecto incluye health checks automáticos:
- ✅ Verificación de servicios
- 📈 Monitoreo de recursos
- 🔄 Auto-restart en fallos

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Soporte

Si encuentras problemas:
1. Revisa los logs: `docker-compose logs`
2. Verifica la configuración en `.env`
3. Consulta la documentación específica del proyecto

---

⭐ **¡Organiza tus proyectos con contenedores!**