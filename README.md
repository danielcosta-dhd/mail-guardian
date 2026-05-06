# 🛡️ Mail Guardian v5

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/bash-5.0+-green.svg)](https://www.gnu.org/software/bash/)
[![Debian](https://img.shields.io/badge/debian-11%2B-red.svg)](https://www.debian.org/)

**Intrusion Prevention System (IPS) dinâmico para Postfix/Dovecot**

Monitora logs em tempo real, detecta comportamentos maliciosos e bloqueia IPs automaticamente usando ipset/iptables.

## ✨ Features

📖 Leia o [Whitepaper](WHITEPAPER.md) para detalhes técnicos e históricos.

- 🚀 **Real-time monitoring** - Tail de logs com detecção instantânea
- 🔒 **Automatic blocking** - Bloqueio via ipset com timeout configurável
- 📊 **SQLite database** - Estatísticas persistentes de usuários e bloqueios
- 🌐 **AbuseIPDB integration** - Reporte automático de IPs maliciosos (opcional)
- 🛠 **CLI tools** - Comandos para stats, unblock, whitelist
- 📦 **Packaged as .deb** - Fácil instalação em Debian/Ubuntu

## 🎯 Protege Contra

- ✅ Spamming massivo de contas comprometidas
- ✅ Força bruta em autenticação SMTP/POP3/IMAP
- ✅ Enumeração de usuários
- ✅ Ataques de retransmissão (relay abuse)
- ✅ DDoS na camada de aplicação

## 📋 Requisitos

- Debian/Ubuntu (ou derivados)
- Postfix ou Dovecot configurado
- Bash 5.0+
- Dependências: `sqlite3`, `ipset`, `curl`, `iptables`, `gawk`

## 🚀 Instalação Rápida

```bash
# Download e instalação
wget https://github.com/danielcosta-dhd/mail-guardian/releases/latest/download/mail-guardian_5.0_all.deb
sudo dpkg -i mail-guardian_5.0_all.deb
sudo apt-get install -f  # resolver dependências

# Configuração inicial
sudo nano /etc/mail-guardian/main.conf

# Iniciar serviço
sudo systemctl start mail-guardian
sudo systemctl enable mail-guardian

🔧 Configuração

Edite /etc/mail-guardian/main.conf:
ini

MAX_EMAILS=50        # Limite de emails por usuário/hora
BLOCK_TIME=86400     # Tempo de bloqueio em segundos (24h)
REPORT_ABUSE=0       # Reportar para AbuseIPDB? (1=sim)
ABUSEIPDB_KEY=""     # Sua API key do AbuseIPDB

📖 Comandos
bash

mail-guardian stats     # Ranking de envios
mail-guardian blocked   # Últimos IPs bloqueados  
mail-guardian unblock <IP>  # Liberar IP
mail-guardian status    # Verificar firewall
mail-guardian clear     # Limpar estatísticas

📊 Arquitetura
text

Mail Logs (tail) → Parser → [SQLite Stats] → Threshold → [Block IP] → iptables/ipset
                    ↓                            ↓
                User tracking              AbuseIPDB Report

🤝 Contribuindo

    Fork o projeto

    Crie sua branch (git checkout -b feature/AmazingFeature)

    Commit suas mudanças (git commit -m 'Add AmazingFeature')

    Push para branch (git push origin feature/AmazingFeature)

    Abra um Pull Request

📝 Licença

Distribuído sob licença MIT. Veja LICENSE para mais informações.
👤 Autor

Daniel Costa

    GitHub: @danielcosta-dhd

    Email: danvesppadoli@gmail.com
📖 Conheça a [história do projeto](STORY.md).

🌟 Agradecimentos

    Projeto inspirado em falhas reais de segurança em servidores de email

    Comunidade AbuseIPDB pela API de reputação

#⚠️ Disclaimer

Este software é fornecido "como está", sem garantias. Use por sua conta e risco. Sempre teste em ambiente controlado antes de usar em produção.
