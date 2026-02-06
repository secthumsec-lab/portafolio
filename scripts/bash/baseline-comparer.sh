#!/bin/bash

# ==========================================
# Baseline Compare Script
# Autor: secthum
# Compara estado actual vs baseline
# ==========================================

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
NC="\e[0m"

BASE_DIR="baseline_data"
BINARIES="/bin /sbin /usr/bin /usr/sbin"

alert () {
  echo -e "${RED}[HIGH] $1${NC}"
}

warn () {
  echo -e "${YELLOW}[MED] $1${NC}"
}

info () {
  echo -e "${BLUE}[*] $1${NC}"
}

echo -e "${GREEN}[*] Comparando sistema contra baseline${NC}"

# Usuarios
info "Usuarios nuevos detectados"
cut -d: -f1,3,4 /etc/passwd | diff $BASE_DIR/users.txt - && \
alert "Usuarios nuevos o modificados"

# Servicios
info "Servicios nuevos o modificados"
systemctl list-units --type=service --state=running | diff $BASE_DIR/services.txt - && \
warn "Cambios en servicios detectados"

# Puertos
info "Puertos nuevos en escucha"
ss -tulnp | diff $BASE_DIR/ports.txt - && \
alert "Puertos nuevos detectados"

# Cron
info "Cambios en cron jobs"
(ls -la /etc/cron*; crontab -l 2>/dev/null) | diff $BASE_DIR/cron.txt - && \
alert "Persistencia por cron detectada"

# SUID
info "Cambios en binarios SUID"
find / -perm -4000 -type f 2>/dev/null | diff $BASE_DIR/suid.txt - && \
warn "Nuevos SUID detectados"

# Binarios críticos
info "Cambios en binarios críticos"
> /tmp/current_hashes.txt
for dir in $BINARIES; do
  find $dir -type f -exec sha256sum {} \; 2>/dev/null >> /tmp/current_hashes.txt
done

diff $BASE_DIR/binaries_hashes.txt /tmp/current_hashes.txt && \
alert "Binarios críticos modificados"

rm /tmp/current_hashes.txt

echo -e "\n${GREEN}[*] Comparación finalizada${NC}"
