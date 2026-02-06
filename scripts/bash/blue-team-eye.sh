#!/bin/bash

# ==============================
# Linux Host Situational Awareness
# Autor: secthum
# Enfoque: Blue Team / Security Insight
# ==============================

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
NC="\e[0m"

section () {
  echo -e "\n${GREEN}==============================${NC}"
  echo -e "${GREEN}[*] $1${NC}"
  echo -e "${GREEN}==============================${NC}"
}

explain () {
  echo -e "${BLUE}↳ $1${NC}"
}

section "Contexto del sistema"
explain "Identifica kernel, arquitectura y versión. Kernels antiguos suelen tener más superficie de ataque."
uname -a
cat /etc/os-release 2>/dev/null

section "Usuario y privilegios"
explain "Permite saber qué tanto control tiene el usuario actual y si pertenece a grupos peligrosos."
whoami
id
groups

section "Comprobación de sudo"
explain "Si el usuario puede usar sudo sin contraseña, es una escalada directa."
sudo -l 2>/dev/null

section "Grupos críticos"
explain "Grupos como docker o lxd permiten acceso root indirecto."
getent group sudo docker lxd adm 2>/dev/null

section "Servicios activos"
explain "Servicios expuestos o innecesarios amplían la superficie de ataque."
systemctl list-units --type=service --state=running 2>/dev/null | head -n 15

section "Puertos en escucha"
explain "Puertos locales pueden indicar servicios internos, backdoors o pivotes."
ss -tulnp 2>/dev/null

section "Procesos destacados"
explain "Busca procesos como root, ejecutándose desde /tmp o intérpretes."
ps -eo pid,user,%cpu,%mem,cmd --sort=-%cpu | head -n 10

section "Persistencia básica"
explain "Cron jobs y servicios habilitados suelen usarse para persistencia."
ls -la /etc/cron* 2>/dev/null
systemctl list-unit-files --state=enabled 2>/dev/null | head -n 15

section "Archivos sensibles"
explain "Permisos incorrectos aquí pueden permitir escaladas graves."
ls -la /etc/passwd /etc/shadow /etc/sudoers 2>/dev/null

section "Binarios con SUID"
explain "SUID permite ejecutar binarios como root; algunos son explotables si están mal configurados."
find / -perm -4000 -type f 2>/dev/null | head -n 10

section "Variables de entorno"
explain "Variables como PATH o LD_PRELOAD pueden ser abusadas."
echo "PATH:"
echo "$PATH" | tr ':' '\n'
echo "LD_PRELOAD:"
echo "$LD_PRELOAD"

section "Archivos modificados recientemente"
explain "Cambios recientes en binarios o configs pueden indicar actividad sospechosa."
find /etc /bin /usr/bin -mtime -1 2>/dev/null | head -n 10

section "Historial de comandos"
explain "El historial puede revelar actividad manual, scripts o errores operativos."
tail -n 10 ~/.bash_history 2>/dev/null

echo -e "\n${GREEN}[*] Análisis rápido completado${NC}"
