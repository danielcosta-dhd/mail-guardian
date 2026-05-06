# Mail Guardian Whitepaper

## 📌 Linha do Tempo
- **2020**: Ataque externo coordenado contra servidores da Secretaria de Saúde de MG.  
- **Primeira resposta**: análise manual de logs, firewall dinâmico e script inicial.  
- **DeepSeek**: ajudou a estruturar a lógica (≈75% da base).  
- **ChatGPT**: introduziu sistema de pesos e estatísticas.  
- **Gemini**: integrou SQLite e ajustou módulo de abuse handling.  
- **2024–2025**: reescrita e evolução para projeto open source, com foco em complementar Postfix/Dovecot/iRedMail.

---

## 🧩 Como o Algoritmo Funciona (Simplificado)

1. **Leitura de logs**  
   - Postfix e Dovecot são monitorados em tempo real.  
   - A fila de e-mails é analisada: crescimento anormal indica possível ataque.

2. **Identificação da conta atacada**  
   - Cruzamento do ID do e-mail com os logs.  
   - Contas comprometidas são isoladas.

3. **Verificação de reputação**  
   - Comparação com listas de blacklist.  
   - Análise de padrões de endereços:  
     - **Legítimos**: `nome.sobrenome@empresa.com`, `apelido@dominio.com`.  
     - **Suspeitos**: `jpkld@dominio.biz`, `xyz123@coisaestranha.co`.

4. **Ação automática**  
   - Bloqueio de IP/domínio via `iptables`/`ipset`.  
   - Limpeza da fila de e-mails comprometidos.  
   - Notificação ao administrador (e-mail/Telegram).

5. **Exceções configuráveis**  
   - Redes internas e de parceiros são preservadas.  
   - Caso um parceiro envie spam, apenas o usuário é isolado e o domínio é comunicado.
---

## 🚀 Diferenciais
- Camada **comportamental** além de filtros tradicionais.  
- Reação imediata com bloqueio dinâmico.  
- Preservação de redes confiáveis.  
- Complementaridade com SpamAssassin/Rspamd.  
- Dashboard simples para monitoramento.

---

## 🔮 Futuro
- IA dinâmica para classificação de padrões.  
- Banco de dados robusto (SQLite/PostgreSQL).  
- Expansão da comunidade open source.  
- Integração nativa com Postfix/Dovecot.

---

## 🏁 Conclusão
O Mail Guardian nasceu de um ataque real e doloroso, transformado em inovação.  
Ele não substitui ferramentas existentes, mas **as complementa**, oferecendo uma camada comportamental que protege servidores pequenos e médios contra abusos externos e internos.
