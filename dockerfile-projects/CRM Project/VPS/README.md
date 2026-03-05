# VPS Deployment Instructions

Esta carpeta contiene una versión lista para ejecutar en un servidor VPS económico. Los archivos son copias de la configuración principal adaptadas para producción.

## Pasos para desplegar

1. **Clona o copia este directorio en el VPS**.
2. **Instala Docker y Docker Compose** siguiendo la documentación oficial.
3. **Copia `.env.vps` a `.env`** y ajusta las contraseñas y usuarios por valores seguros.
4. (Opcional) Ajusta los puertos, volúmenes y nombres de contenedor si hay conflictos con otros servicios.
5. Ejecuta:
   ```bash
   docker-compose pull       # traiga imágenes actualizadas
   docker-compose build      # (si ha modificado el Dockerfile)
   docker-compose up -d
   ```
6. Verifica el estado con `docker-compose ps` y `docker-compose logs -f`.

## Recomendaciones para VPS económico

- Use volúmenes montados en disco persistente (p.ej., `/var/lib/docker/volumes`), no tmpfs.
- Reserve al menos **1 GB de RAM** y **2 CPU** para manejar PHP y MySQL.
- Configure un **firewall** (ufw/iptables) para exponer sólo el puerto 80/443.
- Utilice **Let's Encrypt** con un contenedor adicional (e.g., [certbot](https://hub.docker.com/_/certbot)) y un proxy inverso (nginx) si necesita HTTPS.
- Monitoree el uso de recursos; considere ajustes en `php.ini` y `my.cnf` para bajar consumo si el VPS es muy limitado.
- Mantenga la imagen y contenedores actualizados regularmente (`docker-compose pull && docker-compose restart`).

## Archivos incluidos

- `docker-compose.yml` – Orquestación de la pila (MySQL + PHP/Apache).
- `Dockerfile` – Construye la imagen PHP 8.1 con todas las dependencias.
- `php.ini` – Configuración de PHP optimizada para rendimiento y seguridad.
- `mysql/init.sql` – Esquema inicial y datos de ejemplo.
- `nginx/default.conf` – Plantilla de proxy inverso/SSL (no es usada por defecto, incluir si agrega un contenedor nginx).
- `setup.sh` / `install-suitecrm.sh` – Scripts convenience para entorno de desarrollo, pueden eliminarse en producción si no se necesitan.
- `.env.vps` – Ejemplo de variables de entorno.

## Personalizaciones posibles

- Cambiar `container_name` para evitar colisiones.
- Usar una red Docker personalizada si el VPS ya ejecuta otros contenedores.
- Remover el volumen `crmproject_data` y usar un bind mount si prefiere gestionar manualmente.

¡Listo! Con estos pasos tendrás la versión funcional en un VPS económico y lista para usar.