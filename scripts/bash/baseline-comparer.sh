#!/bin/bash

# ==========================================
# Baseline Compare - Advanced & Descriptive
# Autor: secthum
# Detecta cambios y explica el riesgo
# ==========================================

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
NC="\e[0m"

BASE_DIR="baseline_data"
BINARIES="/bin /sbin /usr/bin /usr/sbin"

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

section "Usuarios nuevos o modificados"
info "Usuarios inesperados pueden ser cuentas backdoor o persistencia."

cut -d: -f1,3,4 /etc/passwd > /tmp/current_users.txt
diff $BASE_DIR/users.txt /tmp/current_users.txt > /tmp/users_diff.txt

if [ -s /tmp/users_diff.txt ]; then
  alert "Cambios detectados en usuarios del sistema"
  cat /tmp/users_diff.txt
  info "Riesgo: cuentas nuevas pueden permitir acceso persistente o escalada."
else
  echo -e "${GREEN}✔ Sin cambios detectados${NC}"
fi

# ------------------------------------------

section "Servicios nuevos o alterados"
info "Servicios nuevos pueden ejecutar código con privilegios elevados."

systemctl list-units --type=service --state=running > /tmp/current_services.txt
diff $BASE_DIR/services.txt /tmp/current_services.txt > /tmp/services_diff.txt

if [ -s /tmp/services_diff.txt ]; then
  warn "Cambios en servicios activos detectados"
  cat /tmp/services_diff.txt
  info "Interpretación: revisar servicios desconocidos o custom."
else
  echo -e "${GREEN}✔ Sin cambios detectados${NC}"
fi

# ------------------------------------------

section "Puertos nuevos en escucha"
info "Puertos nuevos pueden indicar backdoors, C2 o pivotes internos."

ss -tulnp > /tmp/current_ports.txt
diff $BASE_DIR/ports.txt /tmp/current_ports.txt > /tmp/ports_diff.txt

if [ -s /tmp/ports_diff.txt ]; then
  alert "Puertos nuevos detectados"
  cat /tmp/ports_diff.txt
  info "Riesgo: servicios ocultos o acceso remoto no autorizado."
else
  echo -e "${GREEN}✔ Sin cambios detectados${NC}"
fi

# ------------------------------------------

section "Cambios en cron (persistencia)"
info "Cron es un método clásico de persistencia post-explotación."

(ls -la /etc/cron*; crontab -l 2>/dev/null) > /tmp/current_cron.txt
diff $BASE_DIR/cron.txt /tmp/current_cron.txt > /tmp/cron_diff.txt

if [ -s /tmp/cron_diff.txt ]; then
  alert "Cambios en cron detectados"
  cat /tmp/cron_diff.txt
  info "Riesgo: ejecución periódica de payloads o scripts maliciosos."
else
  echo -e "${GREEN}✔ Sin cambios detectados${NC}"
fi

# ------------------------------------------

section "SUID nuevos o sospechosos"
info "SUID permiten ejecutar binarios como root."

find / -perm -4000 -type f 2>/dev/null > /tmp/current_suid.txt
diff $BASE_DIR/suid.txt /tmp/current_suid.txt > /tmp/suid_diff.txt

if [ -s /tmp/suid_diff.txt ]; then
  warn "Cambios en binarios SUID detectados"
  cat /tmp/suid_diff.txt
  info "Riesgo: SUID no estándar pueden permitir escalada de privilegios."
else
  echo -e "${GREEN}✔ Sin cambios detectados${NC}"
fi

# ------------------------------------------

section "Binarios críticos modificados"
info "Binarios alterados pueden indicar reemplazo malicioso."

> /tmp/current_hashes.txt
for dir in $BINARIES; do
  find $dir -type f -exec sha256sum {} \; 2>/dev/null >> /tmp/current_hashes.txt
done

diff $BASE_DIR/binaries_hashes.txt /tmp/current_hashes.txt > /tmp/bin_diff.txt

if [ -s /tmp/bin_diff.txt ]; then
  alert "Cambios en binarios críticos detectados"
  head -n 20 /tmp/bin_diff.txt
  info "Riesgo: rootkits, backdoors o binarios troyanizados."
else
  echo -e "${GREEN}✔ Sin cambios detectados${NC}"
fi

# ------------------------------------------

section "Resumen rápido de riesgo"
info "Si ves múltiples HIGH, asume compromiso hasta probar lo contrario."

echo -e "${YELLOW}• Usuarios nuevos → Persistencia${NC}"
echo -e "${YELLOW}• Servicios nuevos → Ejecución privilegiada${NC}"
echo -e "${YELLOW}• Puertos nuevos → Backdoor / C2${NC}"
echo -e "${YELLOW}• Cron → Persistencia automática${NC}"
echo -e "${YELLOW}• SUID → Escalada de privilegios${NC}"
echo -e "${YELLOW}• Binarios → Compromiso profundo${NC}"

# ------------------------------------------

rm -f /tmp/current_* /tmp/*_diff.txt

echo -e "\n${GREEN}[*] Comparación avanzada finalizada${NC}"
