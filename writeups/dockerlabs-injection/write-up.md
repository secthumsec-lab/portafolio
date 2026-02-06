# Writeup DockerLabs – <Injection>

Este documento contiene el writeup del laboratorio **<injection>** de la plataforma **DockerLabs**.

El objetivo de este writeup es documentar el proceso seguido para comprometer el contenedor, detallando de forma clara y ordenada las técnicas utilizadas durante la resolución del laboratorio, con fines educativos y de aprendizaje en ciberseguridad.


---

![maquina](images/Screenshot_2026-02-06_14-51-03.jpg)
Comenzaremos realizando un analisis del sistema vulnerable y descubirmos 2 servicios abiertos 22,80 (ssh - http )
![[Screenshot_2026-02-06_14-54-06.jpg]]
![[Screenshot_2026-02-06_14-54-54.jpg]]
![[Screenshot_2026-02-06_14-56-01.jpg]]
perfecto es un panel de login, comenzaremos a forzar errores en la aplicacion con diferentes payloads
![[Screenshot_2026-02-06_14-58-25.jpg]]
![[Screenshot_2026-02-06_14-59-25.jpg]]
INJECCIONES SQL DETECTED
![[Screenshot_2026-02-06_14-59-53.jpg]]
obtenemos un usuario dylan - password coneccion por sshal servidor como usuario dylan
![[Screenshot_2026-02-06_15-04-47.jpg]]
Ejecutaremos nuestro script automatizado blue-eye de nuestro repositorio personal de github  o por medio de un http.server de python3 -m
![[Screenshot_2026-02-06_15-12-04.jpg]]
Descubrimos un binario usr/bin/env posiblemente vulnerable
![[Screenshot_2026-02-06_15-14-34.jpg]]

