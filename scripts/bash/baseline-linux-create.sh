#!/bin/bash

# ==========================================
# Baseline Create Script
# Autor: secthum
# Guarda el estado "limpio" del sistema
# ==========================================

GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
NC="\e[0m"

BASE_DIR="baseline_data"
BINARIES="/bin /sbin /usr/bin /usr/sbin"

echo -e "${GREEN}[*] Creando baseline del sistema${NC}"
mkdir -p $BASE_DIR

echo -e "\n${BLUE}[+] Usuarios del sistema${NC}"
cut -d: -f1,3,4 /etc/passwd > $BASE_DIR/users.txt

echo -e "${BLUE}[+] Grupos del sistema${NC}"
cut -d: -f1,3 /etc/group > $BASE_DIR/groups.txt

echo -e "${BLUE}[+] Servicios activos${NC}"
systemctl list-units --type=service --state=running > $BASE_DIR/services.txt

echo -e "${BLUE}[+] Puertos en escucha${NC}"
ss -tulnp > $BASE_DIR/ports.txt

echo -e "${BLUE}[+] Cron jobs${NC}"
ls -la /etc/cron* > $BASE_DIR/cron.txt
crontab -l 2>/dev/null >> $BASE_DIR/cron.txt

echo -e "${BLUE}[+] Binarios SUID${NC}"
find / -perm -4000 -type f 2>/dev/null > $BASE_DIR/suid.txt

echo -e "${BLUE}[+] Hashes de binarios críticos${NC}"
> $BASE_DIR/binaries_hashes.txt
for dir in $BINARIES; do
  find $dir -type f -exec sha256sum {} \; 2>/dev/null >> $BASE_DIR/binaries_hashes.txt
done

echo -e "\n${GREEN}[*] Baseline creado correctamente${NC}"
echo -e "${YELLOW}Guarda este baseline como referencia de sistema limpio${NC}"
