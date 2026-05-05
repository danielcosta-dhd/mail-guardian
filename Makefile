.PHONY: build install clean test deb help

VERSION ?= 5.0
PKG_NAME = mail-guardian

help:
@echo "Comandos disponíveis:"
@echo " make build - Criar estrutura de build"
@echo " make deb - Construir pacote .deb"
@echo " make install - Instalar localmente"
@echo " make test - Executar testes"
@echo " make clean - Limpar arquivos temporários"

build:
@echo "[+] Preparando build..."
@chmod +x src/core/*.sh
@chmod +x src/cli/mail-guardian

deb: build
@echo "[+] Construindo pacote .deb..."
@./scripts/build-deb.sh

install:
@echo "[+] Instalando Mail Guardian..."
@sudo cp -r src/core /opt/mail-guardian/
@sudo cp src/cli/mail-guardian /usr/local/bin/
@sudo cp config/main.conf.example /etc/mail-guardian/main.conf
@sudo cp systemd/mail-guardian.service /etc/systemd/system/
@sudo systemctl daemon-reload

test:
@echo "[+] Executando testes..."
@bash tests/test_parser.sh

clean:
@echo "[+] Limpando..."
@rm -rf pkg_build/
@rm -f .deb
@find . -type f -name ".log" -delete

release: clean deb
@echo "[+] Criando release v(VERSION)"@mkdir−preleases/@cp(VERSION)"@mkdir−preleases/@cp(PKG_NAME)_$(VERSION)_all.deb releases/
@echo "Release pronto em releases/"
