#!/bin/bash

# ==============================
# Linux Privilege Escalation Recon
# Autor: secthum
# Uso: bash linux_recon.sh
# ==============================

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

echo -e "${GREEN}[*] Iniciando Recon de Sistema Linux${NC}"
echo "--------------------------------------"

# Info del sistema
echo -e "\n${YELLOW}[+] Información del sistema${NC}"
uname -a
cat /etc/os-release 2>/dev/null

# Usuario actual
echo -e "\n${YELLOW}[+] Usuario actual${NC}"
whoami
id

# Usuarios con shell
echo -e "\n${YELLOW}[+] Usuarios con shell${NC}"
cat /etc/passwd | grep -E "/bin/bash|/bin/sh"

# Grupos interesantes
echo -e "\n${YELLOW}[+] Grupos interesantes${NC}"
groups
getent group sudo docker lxd adm 2>/dev/null

# SUID binaries
echo -e "\n${YELLOW}[+] Archivos SUID${NC}"
find / -perm -4000 -type f 2>/dev/null

# SGID binaries
echo -e "\n${YELLOW}[+] Archivos SGID${NC}"
find / -perm -2000 -type f 2>/dev/null

# Capabilities
echo -e "\n${YELLOW}[+] Capabilities${NC}"
getcap -r / 2>/dev/null

# Cron jobs
echo -e "\n${YELLOW}[+] Cron jobs${NC}"
ls -la /etc/cron* 2>/dev/null
cat /etc/crontab 2>/dev/null

# Servicios activos
echo -e "\n${YELLOW}[+] Servicios activos${NC}"
systemctl list-units --type=service --state=running 2>/dev/null

# Archivos con permisos de escritura peligrosos
echo -e "\n${YELLOW}[+] Archivos escribibles por el usuario${NC}"
find / -writable -type f 2>/dev/null | head -n 50

# Archivos sensibles
echo -e "\n${YELLOW}[+] Archivos sensibles${NC}"
ls -la /etc/passwd /etc/shadow /etc/sudoers 2>/dev/null

# PATH inseguro
echo -e "\n${YELLOW}[+] PATH${NC}"
echo $PATH | tr ':' '\n'

# Variables de entorno
echo -e "\n${YELLOW}[+] Variables de entorno${NC}"
env

# Historiales
echo -e "\n${YELLOW}[+] Historial de comandos${NC}"
ls -la ~/.*history 2>/dev/null

echo -e "\n${GREEN}[*] Recon finalizado${NC}"
