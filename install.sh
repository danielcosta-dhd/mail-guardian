#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
  echo "Este script deve ser executado como root"
  exit 1
fi

echo "[+] Instalando Mail Guardian v5..."

# Detectar distribuição
if [ -f /etc/os-release ]; then
  . /etc/os-release
  DISTRO=$ID
else
  echo "Não consegui identificar a distribuição."
  exit 1
fi

echo "[+] Detectado: $DISTRO"

# Instalar dependências conforme distro
case "$DISTRO" in
  ubuntu|debian)
    apt-get update
    apt-get install -y sqlite3 ipset curl iptables gawk
    ;;
  centos|rhel)
    yum install -y sqlite ipset curl iptables gawk
    ;;
  fedora)
    dnf install -y sqlite ipset curl iptables gawk
    ;;
  arch)
    pacman -Sy --noconfirm sqlite ipset curl iptables gawk
    ;;
  *)
    echo "Distribuição $DISTRO não suportada ainda."
    exit 1
    ;;
esac

echo "[+] Criando diretórios..."
mkdir -p /opt/mail-guardian/core
mkdir -p /etc/mail-guardian
mkdir -p /var/lib/mail-guardian
mkdir -p /var/log/mail-guardian

echo "[+] Copiando arquivos..."
cp src/core/*.sh /opt/mail-guardian/core/
cp src/cli/mail-guardian /usr/local/bin/
cp config/main.conf.example /etc/mail-guardian/main.conf
cp systemd/mail-guardian.service /etc/systemd/system/

echo "[+] Ajustando permissões..."
chmod +x /opt/mail-guardian/core/*.sh
chmod +x /usr/local/bin/mail-guardian

echo "[+] Configurando serviço..."
systemctl daemon-reload
systemctl enable mail-guardian
systemctl start mail-guardian

echo "[✅] Instalação concluída!"
echo "Configure: /etc/mail-guardian/main.conf"
echo "Comandos: mail-guardian --help"

