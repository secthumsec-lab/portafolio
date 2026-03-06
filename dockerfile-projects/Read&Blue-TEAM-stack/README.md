# 🛡️ Docker Security Lab – Vulnerable Apps + Monitoring

Laboratorio de **ciberseguridad con Docker** diseñado para practicar:

* 🔎 **Ataques web (OWASP Top 10)**
* 📊 **Monitoreo con Prometheus + Grafana**
* 🐳 **Observabilidad de contenedores**
* 🚦 **Monitoreo de servicios**

Todo el laboratorio se orquesta con **Docker Compose** y puede configurarse fácilmente usando el archivo **`.env`** sin modificar los archivos internos.

---

# 🧠 Arquitectura del laboratorio

Servicios incluidos:

### 🧪 Aplicaciones vulnerables

* OWASP Juice Shop
* DVWA (Damn Vulnerable Web Application)

### 📊 Observabilidad

* Prometheus
* Grafana

### 🐳 Métricas de infraestructura

* Node Exporter
* cAdvisor

### 🚦 Monitoreo de servicios

* Uptime Kuma

---

# 🧱 Arquitectura del stack

```text
                +------------------+
                |      Grafana     |
                +--------+---------+
                         |
                         |
                   +-----v------+
                   | Prometheus |
                   +-----+------+
                         |
         +---------------+----------------+
         |                                |
   +-----v-------+                  +-----v------+
   | NodeExporter |                  |  cAdvisor  |
   +-------------+                  +-------------+

                 +------------------+
                 |   Uptime Kuma    |
                 | Service Monitor  |
                 +---------+--------+
                           |
        +------------------+------------------+
        |                                     |
  +-----v------+                       +------v------+
  |   DVWA     |                       | Juice Shop  |
  | vulnerable |                       | vulnerable  |
  +------------+                       +-------------+
```

---

# 📁 Estructura del proyecto

```bash
security-lab/

docker-compose.yml
.env

prometheus/
   prometheus.yml

grafana/
   provisioning/
      datasources/
         datasource.yml

README.md
```

---

# ⚙️ Requisitos

Antes de comenzar necesitas instalar:

### 🐳 Docker

https://docs.docker.com/get-docker/

### 🐙 Docker Compose

https://docs.docker.com/compose/

Verificar instalación:

```bash
docker --version
docker compose version
```

---

# 🚀 Levantar el laboratorio

Dentro del proyecto ejecutar:

```bash
docker compose up -d
```

Verificar contenedores activos:

```bash
docker ps
```

Detener el laboratorio:

```bash
docker compose down
```

Eliminar volúmenes (reset completo):

```bash
docker compose down -v
```

---

# 🌐 Acceso a los servicios

| Servicio      | URL                   |
| ------------- | --------------------- |
| DVWA          | http://localhost:8080 |
| Juice Shop    | http://localhost:3001 |
| Prometheus    | http://localhost:9090 |
| Grafana       | http://localhost:3000 |
| cAdvisor      | http://localhost:8081 |
| Node Exporter | http://localhost:9100 |
| Uptime Kuma   | http://localhost:3002 |

---

# 🔐 Credenciales iniciales

## 📊 Grafana

URL

```
http://localhost:3000
```

Login:

```
user: admin
password: admin123
```

En el primer login Grafana pedirá cambiar la contraseña.

---

## 🧪 DVWA

URL

```
http://localhost:8080
```

Credenciales:

```
user: admin
password: password
```

---

# ⚠️ Configuración inicial de DVWA

Después del login:

Ir a:

```
DVWA Security
```

Seleccionar nivel:

```
low
```

Esto permite probar vulnerabilidades fácilmente.

Luego ir a:

```
Setup / Reset DB
```

Presionar:

```
Create / Reset Database
```

---

# 🍹 OWASP Juice Shop

Abrir:

```
http://localhost:3001
```

No requiere configuración inicial.

Puedes:

* crear un usuario
* comenzar a atacar directamente
* seguir los retos internos

Proyecto oficial:

https://owasp.org/www-project-juice-shop/

---

# 📊 Configuración inicial de Grafana

Abrir:

```
http://localhost:3000
```

Login:

```
admin / admin123
```

Luego verificar datasource.

Ir a:

```
Connections → Data Sources
```

Debe aparecer **Prometheus** configurado automáticamente.

URL configurada:

```
http://prometheus:9090
```

---

# 📈 Dashboards recomendados

Importar dashboards desde:

https://grafana.com/grafana/dashboards/

### Docker Monitoring

```
193
```

### Node Exporter Full

```
1860
```

### cAdvisor Monitoring

```
14282
```

Importar desde:

```
Grafana → Dashboards → Import
```

---

# 🔍 Prometheus

Abrir:

```
http://localhost:9090
```

Ir a:

```
Status → Targets
```

Deberías ver:

```
prometheus
node-exporter
cadvisor
```

Todos deben aparecer como:

```
UP
```

---

# 🐳 cAdvisor

Panel de métricas de contenedores.

Abrir:

```
http://localhost:8081
```

Permite monitorear:

* CPU
* RAM
* filesystem
* network
* uso por contenedor

---

# 🚦 Configuración inicial de Uptime Kuma

Abrir:

```
http://localhost:3002
```

En el primer acceso:

1️⃣ Crear usuario administrador.

Luego agregar monitores.

---

### Monitor DVWA

Tipo:

```
HTTP
```

URL:

```
http://dvwa
```

---

### Monitor Juice Shop

Tipo:

```
HTTP
```

URL:

```
http://juice-shop:3000
```

---

### Monitor Prometheus

Tipo:

```
HTTP
```

URL:

```
http://prometheus:9090
```

---

# 🧪 Qué puedes probar en este laboratorio

Este laboratorio permite practicar **vulnerabilidades OWASP**.

Ejemplos:

### SQL Injection

DVWA

```
Vulnerabilities → SQL Injection
```

---

### Cross Site Scripting (XSS)

DVWA

```
Vulnerabilities → XSS Stored
```

---

### Broken Authentication

Juice Shop incluye múltiples retos interactivos.

---

# 🛡️ Objetivo del laboratorio

Practicar:

* explotación de vulnerabilidades web
* monitoreo de infraestructura
* observabilidad en contenedores
* análisis de métricas
* seguridad en aplicaciones

Tecnologías utilizadas:

* Docker
* Docker Compose
* Prometheus
* Grafana
* Node Exporter
* cAdvisor
* Uptime Kuma
* DVWA
* OWASP Juice Shop

---

# 📚 Recursos útiles

OWASP Top 10

https://owasp.org/www-project-top-ten/

Prometheus

https://prometheus.io/

Grafana

https://grafana.com/

DVWA

https://github.com/digininja/DVWA

OWASP Juice Shop

https://owasp.org/www-project-juice-shop/

---

# 🚧 Mejoras futuras

Este laboratorio puede ampliarse agregando:

* honeypots
* IDS/IPS
* centralización de logs
* detección de ataques
* simulación automática de ataques

Herramientas interesantes:

* Falco
* Suricata
* Cowrie
* ELK Stack

---

# 👨‍💻 Autor

Laboratorio creado para práctica de:

* Cybersecurity
* DevSecOps
* Blue Team
* Red Team
* Observability

Proyecto ideal para **portafolio profesional de ciberseguridad**.
