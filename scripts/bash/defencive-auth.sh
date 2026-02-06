#!/bin/bash

# ==============================
# Linux Defensive Audit Script
# Autor: secthum
# Enfoque: Blue Team / Forensics básica
# ==============================

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

echo -e "${GREEN}[*] Iniciando Auditoría Defensiva de Linux${NC}"
echo "------------------------------------------"

# Fecha actual
echo -e "\n${YELLOW}[+] Fecha del sistema${NC}"
date

# Usuario actual
echo -e "\n${YELLOW}[+] Usuario actual${NC}"
whoami
id

# Últimos logins
echo -e "\n${YELLOW}[+] Últimos logins${NC}"
last -a | head -n 10

# Fallos de autenticación
echo -e "\n${YELLOW}[+] Intentos fallidos de login${NC}"
grep -i "fail" /var/log/auth.log 2>/dev/null | tail -n 20
grep -i "failed" /var/log/secure 2>/dev/null | tail -n 20

# Uso de sudo
echo -e "\n${YELLOW}[+] Uso de sudo${NC}"
grep -i "sudo" /var/log/auth.log 2>/dev/null | tail -n 20

# Historial bash
echo -e "\n${YELLOW}[+] Historial de comandos bash${NC}"
for h in /home/*/.bash_history ~/.bash_history; do
    echo -e "${GREEN}Archivo: $h${NC}"
    tail -n 20 "$h" 2>/dev/null
done

# Archivos modificados en las últimas 24h
echo -e "\n${YELLOW}[+] Archivos modificados en las últimas 24h${NC}"
find /etc /bin /sbin /usr/bin /usr/sbin -mtime -1 2>/dev/null

# Archivos ocultos recientes
echo -e "\n${YELLOW}[+] Archivos ocultos recientes${NC}"
find /home -name ".*" -mtime -1 2>/dev/null

# Procesos sospechosos
echo -e "\n${YELLOW}[+] Procesos en ejecución${NC}"
ps aux --sort=-%cpu | head -n 10

# Variables LD_PRELOAD (posibles keyloggers simples)
echo -e "\n${YELLOW}[+] LD_PRELOAD${NC}"
echo "$LD_PRELOAD"

# Servicios habilitados
echo -e "\n${YELLOW}[+] Servicios habilitados al arranque${NC}"
systemctl list-unit-files --type=service --state=enabled 2>/dev/null

# Servicios iniciados recientemente
echo -e "\n${YELLOW}[+] Servicios iniciados recientemente${NC}"
journalctl -u ssh --since "24 hours ago" 2>/dev/null | tail -n 20

# Cron jobs
echo -e "\n${YELLOW}[+] Cron jobs del sistema${NC}"
ls -la /etc/cron* 2>/dev/null
cat /etc/crontab 2>/dev/null

# Archivos con permisos peligrosos
echo -e "\n${YELLOW}[+] Archivos world-writable${NC}"
find / -type f -perm -0002 2>/dev/null | head -n 50

# Conexiones de red
echo -e "\n${YELLOW}[+] Conexiones de red activas${NC}"
ss -tunap 2>/dev/null | head -n 20

echo -e "\n${GREEN}[*] Auditoría defensiva finalizada${NC}"
