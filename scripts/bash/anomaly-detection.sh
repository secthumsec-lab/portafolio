#!/bin/bash

# ==========================================
# Linux Anomaly Detection Script
# Autor: secthum
# Enfoque: Blue Team / Threat Detection
# ==========================================

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

info () {
  echo -e "${BLUE}↳ $1${NC}"
}

warn () {
  echo -e "${YELLOW}[MED] $1${NC}"
}

alert () {
  echo -e "${RED}[HIGH] $1${NC}"
}

# ------------------------------------------

section "Contexto del sistema"
info "Ayuda a entender el entorno donde se detectan anomalías."
hostname
uptime
whoami

# ------------------------------------------

section "Usuarios y privilegios anómalos"
info "Usuarios nuevos o con UID 0 pueden indicar persistencia."

awk -F: '$3 == 0 { print }' /etc/passwd | while read u; do
  alert "Usuario con UID 0 detectado → $u"
done

# Usuarios creados recientemente
info "Usuarios creados recientemente pueden ser cuentas backdoor."
ls -lt /home 2>/dev/null | head -n 5

# ------------------------------------------

section "Grupos peligrosos"
info "Pertenecer a docker, lxd o sudo permite escalada indirecta."

for g in docker lxd sudo adm; do
  if getent group $g >/dev/null; then
    warn "Grupo sensible presente → $g"
    getent group $g
  fi
done

# ------------------------------------------

section "Procesos sospechosos"
info "Procesos ejecutándose desde rutas temporales o intérpretes."

ps -eo pid,user,cmd | grep -E "/tmp|/dev/shm|bash -i|nc |ncat|python -c|perl -e" | grep -v grep && \
alert "Procesos potencialmente maliciosos detectados"

# ------------------------------------------

section "Servicios sospechosos"
info "Servicios nuevos o desconocidos pueden ser persistencia."

systemctl list-unit-files --type=service | grep enabled | grep -vE "ssh|cron|rsyslog|systemd" | head -n 10 && \
warn "Servicios no estándar habilitados"

# ------------------------------------------

section "Persistencia en cron"
info "Cron es uno de los métodos más usados para persistencia."

ls -la /etc/cron* 2>/dev/null
find /etc/cron* -type f -mtime -1 2>/dev/null && \
alert "Cron modificado recientemente"

# ------------------------------------------

section "Binarios críticos modificados"
info "Cambios recientes en binarios pueden indicar reemplazo malicioso."

find /bin /sbin /usr/bin /usr/sbin -mtime -1 2>/dev/null | head -n 10 && \
alert "Binarios críticos modificados en las últimas 24h"

# ------------------------------------------

section "SUID anómalos"
info "SUID no estándar pueden ser usados para escalada de privilegios."

find / -perm -4000 -type f 2>/dev/null | grep -vE "sudo|passwd|su|mount|umount" | head -n 10 && \
warn "SUID no estándar detectados"

# ------------------------------------------

section "SSH y acceso remoto"
info "Claves nuevas o accesos recientes pueden indicar compromiso."

find /home -name authorized_keys -mtime -1 2>/dev/null && \
alert "Claves SSH agregadas recientemente"

last -a | head -n 5

# ------------------------------------------

section "Variables peligrosas"
info "LD_PRELOAD o PATH inseguros pueden usarse para secuestro de ejecución."

if [ ! -z "$LD_PRELOAD" ]; then
  alert "LD_PRELOAD activo → $LD_PRELOAD"
fi

echo "$PATH" | grep "\." && warn "PATH contiene '.' (riesgoso)"

# ------------------------------------------

section "Conexiones de red"
info "Conexiones activas pueden revelar C2, backdoors o pivotes."

ss -tunap 2>/dev/null | grep ESTAB | head -n 10

# ------------------------------------------

section "Archivos ocultos recientes"
info "Archivos ocultos recientes en home suelen indicar persistencia."

find /home -name ".*" -mtime -1 2>/dev/null | head -n 10 && \
warn "Archivos ocultos recientes detectados"

# ------------------------------------------

echo -e "\n${GREEN}[*] Detección de anomalías completada${NC}"
