#!/bin/bash
set -e

read -p "Tem certeza que deseja remover o Mail Guardian? (s/N): " CONFIRM
if [[ "$CONFIRM" != "s" && "$CONFIRM" != "S" ]]; then
  echo "Cancelado."
  exit 0
fi

if [[ $EUID -ne 0 ]]; then
  echo "Este script deve ser executado como root"
  exit 1
fi

BACKUP_DIR="/var/backups/mail-guardian-$(date +%Y%m%d-%H%M%S)"

echo "[+] Removendo Mail Guardian v5..."
echo "[+] Criando backup em $BACKUP_DIR"

# Criar diretório de backup
mkdir -p "$BACKUP_DIR"

# Copiar arquivos de configuração e logs importantes
cp -r /etc/mail-guardian "$BACKUP_DIR/" 2>/dev/null || true
cp -r /var/log/mail-guardian "$BACKUP_DIR/" 2>/dev/null || true
cp -r /var/lib/mail-guardian "$BACKUP_DIR/" 2>/dev/null || true

echo "[+] Backup concluído em $BACKUP_DIR"

# Parar e desabilitar serviço
systemctl stop mail-guardian || true
systemctl disable mail-guardian || true

# Remover arquivos e diretórios
echo "[+] Removendo diretórios e arquivos..."
rm -rf /opt/mail-guardian
rm -rf /etc/mail-guardian
rm -rf /var/lib/mail-guardian
rm -rf /var/log/mail-guardian

# Remover binário e serviço
rm -f /usr/local/bin/mail-guardian
rm -f /etc/systemd/system/mail-guardian.service

# Reload systemd
systemctl daemon-reload

echo "[✅] Mail Guardian removido com sucesso!"
echo "[💾] Backup disponível em: $BACKUP_DIR"
