#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
echo "Este script deve ser executado como root"
exit 1
fi

echo "[+] Instalando Mail Guardian v5..."
Instalar dependências

apt-get update
apt-get install -y sqlite3 ipset curl iptables gawk
Criar diretórios

mkdir -p /opt/mail-guardian/core
mkdir -p /etc/mail-guardian
mkdir -p /var/lib/mail-guardian
mkdir -p /var/log/mail-guardian
Copiar arquivos

cp src/core/*.sh /opt/mail-guardian/core/
cp src/cli/mail-guardian /usr/local/bin/
cp config/main.conf.example /etc/mail-guardian/main.conf
cp systemd/mail-guardian.service /etc/systemd/system/
Permissões

chmod +x /opt/mail-guardian/core/*.sh
chmod +x /usr/local/bin/mail-guardian
Iniciar serviço

systemctl daemon-reload
systemctl enable mail-guardian
systemctl start mail-guardian

echo "[✅] Instalação concluída!"
echo "Configure: /etc/mail-guardian/main.conf"
echo "Comandos: mail-guardian --help"
