---
github_repo: secthumsec-lab|Hacking-Etico
---
# Objetivo

Realizar la busqueda y explotacion de un sistema informatico.
# IP 172.17.0.2

# WRITE-UP

Realizamos una comprobacion de conectividad con el servidor por medio de ping

---
![alternativo](images/Screenshot_2026-02-05_20-23-09.jpg)

Datos relevantes
TTL = 64 proximidad con sistemas linux 

Ahora utilizaremos nmap para realizar una busqueda por servicios activos en el sisteme victima

---
![](Screenshot_2026-02-05_20-39-49.jpg)

Podemos notar 2 puertos expuestos
22 = ssh (secure-shell)
5000 = upnp 

---
Realizaremos un reconociento mas profundo con nmap para descubrir mas info sobre los servicios del sistema

![](Screenshot_2026-02-05_20-45-43.jpg)

Podemos ver la version ssh actualizada
por lo que asumimos que el vector de ataque sera por medio del puerto 5000 que parece ser algun tipo de documento o aplicacion web.

accedemos desde el navegador

![](Screenshot_2026-02-05_21-00-01.jpg)

Primero antes de buscar en la web manualmente algun tipo de funcionalidad para explotar vamos a realizar con gobuster ,dirb o ffuf un fuzzing de directorios y extenciones de archivos para crear una idea mejor de la infraestructura de la app.

![](Screenshot_2026-02-05_21-05-40.jpg)

Vemos un endpoit de codigo 200 OK llamado : register
accedemos y nos registramos para poder acceder a la aplicacion y buscar mas vectores.

![](Screenshot_2026-02-05_21-08-03.jpg)
accedemos
![](Screenshot_2026-02-05_21-08-58.jpg)
Podemos ver en la url un padron que nos llama la atencion.
id=55
intentamos manipular este valor directo en la url del navegador 
id=55 => id=54

# AIDOR - MOVIMENTACION LATERAL 
esta falla permite al atacante ver informacion de otros usuarios del sistema
![](Screenshot_2026-02-05_21-13-22.jpg)
Bajamos en el perfil de aidor y nos encontramos un hash de password ,entonces nos dirijimos a crackstation.net para intentar decriptarla.
![](Screenshot_2026-02-05_21-15-50.jpg)
![](Screenshot_2026-02-05_21-16-54.jpg)

ahora intentaremos conectarnos por ssh usando el usuario aidor con la password chocolate y estamos dentro del sistema.
![](Screenshot_2026-02-05_21-18-08.jpg)

realizaremos un reconocimiento en busqueda de permisos sudo e suid pero no encontramos nada relevante.
procedemos a listar el directorio /home/ en busca de algo mas como aplicaciones o usuarios del sistema.
![](Screenshot_2026-02-05_21-19-43.jpg)
vemos un app.py el cual tenemos permiso de lectura
lo leemos y encontramos un password hasheado que crackiaremos en crackstation.net nuevamente
![](Screenshot_2026-02-05_21-21-12.jpg)

![](Screenshot_2026-02-05_21-21-57.jpg)

ahora intentamos escalar privilegios con esa password como root usando su.
![](Screenshot_2026-02-05_21-22-55.jpg)
