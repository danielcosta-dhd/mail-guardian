FROM debian:stable-slim

# Instalar dependências
RUN apt-get update && apt-get install -y \
    sqlite3 ipset curl iptables gawk python3 python3-pip systemd \
    && rm -rf /var/lib/apt/lists/*

# Criar diretórios
RUN mkdir -p /opt/mail-guardian/core \
    /etc/mail-guardian \
    /var/lib/mail-guardian \
    /var/log/mail-guardian

# Copiar arquivos do projeto
COPY src/core/*.sh /opt/mail-guardian/core/
COPY src/cli/mail-guardian /usr/local/bin/
COPY config/main.conf.example /etc/mail-guardian/main.conf
COPY systemd/mail-guardian.service /etc/systemd/system/

# Permissões
RUN chmod +x /opt/mail-guardian/core/*.sh \
    && chmod +x /usr/local/bin/mail-guardian

# Configurar serviço
RUN systemctl enable mail-guardian

CMD ["/usr/local/bin/mail-guardian", "--help"]

