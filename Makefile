# Makefile para Mail Guardian

.PHONY: install uninstall clean restart status

install:
    @echo "[+] Executando instalador..."
    @bash install.sh

uninstall:
    @echo "[+] Executando desinstalador..."
    @bash uninstall.sh

clean:
    @echo "[+] Limpando arquivos temporários..."
    @rm -rf /var/log/mail-guardian/*
    @rm -rf /var/lib/mail-guardian/*

restart:
    @echo "[+] Reiniciando serviço Mail Guardian..."
    @systemctl restart mail-guardian
    @systemctl status mail-guardian --no-pager

status:
    @echo "[+] Status do serviço Mail Guardian:"
    @systemctl status mail-guardian --no-pager
