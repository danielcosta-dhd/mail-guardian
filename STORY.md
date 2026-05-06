## 👨‍💻 Sobre o Autor

Meu nome é **Daniel Costa**, e sou o criador do Mail Guardian.  
Em 2020, trabalhei na Secretaria de Saúde de Minas Gerais, onde enfrentei um ataque externo coordenado contra os servidores de e-mail da instituição.  
Através da análise de logs e da aplicação de regras de firewall, consegui bloquear o ataque e manter a infraestrutura funcionando.  

Essa experiência me inspirou a desenvolver o Mail Guardian: primeiro como um script simples, depois evoluindo com apoio de ferramentas de inteligência artificial (DeepSeek, ChatGPT e Gemini), que ajudaram a estruturar, refinar e integrar novas funcionalidades.  

Meu objetivo não é competir com soluções já consolidadas, mas **complementá-las**, oferecendo uma camada comportamental que aumenta a segurança de servidores pequenos e médios.  
Este projeto é fruto de estudo, prática e da vontade de contribuir para que outros administradores não precisem passar pelo mesmo tipo de ataque.




# 📖 A História do Mail Guardian

## 🌍 Origem
Em 2020, enquanto trabalhava na Secretaria de Saúde de Minas Gerais, enfrentei um ataque externo coordenado contra os servidores de e-mail da instituição.  
O ataque vinha de fora, com domínios internacionais (inclusive do Japão), e gerava loops de retransmissão entre servidores, saturando a infraestrutura e ameaçando a reputação dos domínios.

Foi um momento crítico: precisei analisar manualmente os logs, identificar padrões e aplicar regras de firewall para bloquear os IPs maliciosos.  
Essa experiência dolorosa foi o ponto de partida para o que mais tarde se tornaria o **Mail Guardian**.

---

## 🛠️ Primeira Versão
A solução inicial era um script simples que:
- Lia os logs do Postfix e do Dovecot.  
- Monitorava a fila de e-mails (crescimento anormal indicava ataque).  
- Identificava contas comprometidas cruzando IDs de e-mails com os logs.  
- Bloqueava IPs/domínios suspeitos via `iptables` e `ipset`.  
- Limpava a fila e notificava administradores.  

Essa abordagem funcionou em produção, protegendo cerca de **5000 contas distribuídas em 10 servidores**.

---

## 🤖 Evolução com Inteligência Artificial
Com o tempo, decidi reescrever e ampliar a ideia usando IA. Cada modelo contribuiu de forma diferente:

- **DeepSeek** → ajudou a estruturar a lógica, cobrindo cerca de 75% da base.  
- **ChatGPT** → introduziu sistema de pesos, estatísticas e análise mais refinada.  
- **Gemini** → integrou o SQLite e ajustou o módulo de *abuse handling*, tornando o sistema mais robusto.  

Foi uma verdadeira saga: cada etapa trouxe desafios, divergências e aprendizados, mas o resultado foi um projeto mais sólido e flexível.

---

## 🔑 Filosofia
O Mail Guardian não nasceu para competir com ferramentas como SpamAssassin ou Rspamd.  
Ele nasceu para **complementá-las**, adicionando uma camada comportamental que:
- Analisa padrões de envio.  
- Bloqueia abusos externos e internos.  
- Preserva redes confiáveis e parceiros.  
- Reage em tempo real com firewall dinâmico.  

---

## 👨‍💻 Sobre o Autor
Meu nome é **Daniel Costa**, criador do Mail Guardian.  
Sou administrador de sistemas evoluíndo pra DevOps com experiência prática em ambientes críticos.  
Este projeto é fruto de estudo, prática e da vontade de contribuir para que outros administradores não precisem passar pelo mesmo tipo de ataque que enfrentei em 2020.

---

## 📌 Conclusão
O Mail Guardian é mais do que um código: é uma história de resiliência, aprendizado e colaboração entre humano e inteligência artificial.  
Ele já nasceu testado em campo e continua evoluindo como projeto open source, pronto para ajudar servidores pequenos e médios a se protegerem contra abusos.
