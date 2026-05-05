Changelog
[5.0] - 2024-11-25
Adicionado

    Sistema completo de parsing de logs Postfix

    Bloqueio automático via ipset/iptables

    CLI para gerenciamento (stats, unblock, blocked, status)

    Integração com AbuseIPDB

    Whitelist de IPs

    SQLite para persistência de dados

Corrigido

    Regex robusto para extração de emails e IPs

    Suporte a IPv6

    Tratamento de erros no systemd

Melhorado

    Performance do parser

    Documentação completa

    Script de instalação automatizado
    EOF

10. Script de teste

cat > $PROJECT_NAME/tests/test_parser.sh <<'EOF'
#!/bin/bash
Teste unitário do parser

echo "[TEST] Testando extração de email e IP..."
Mock de log

TEST_LOG="Nov 25 10:00:00 mail postfix/smtpd[12345]: disconnect from unknown[192.168.1.100] from=teste@dominio.com"
Extrair email

EMAIL=(echo"(echo"TEST_LOG" | grep -oE 'from=<[^>]*>' | sed 's/from=<//;s/>//')
if [[ "EMAIL"=="teste@dominio.com"]];thenecho"✓Extrac\ca~odeemail:OK"elseecho"✗Extrac\ca~odeemail:FAIL(got:EMAIL"=="teste@dominio.com"]];thenecho"✓Extrac\c​a~odeemail:OK"elseecho"✗Extrac\c​a~odeemail:FAIL(got:EMAIL)"
exit 1
fi
Extrair IP

IP=(echo"(echo"TEST_LOG" | grep -oE '[0−9]+[˙0−9]+[˙0−9]+[˙0−9]+[0−9]+[˙​0−9]+[˙​0−9]+[˙​0−9]+' | tr -d '[]')
if [[ "IP"=="192.168.1.100"]];then echo"✓Extrac\ca~odeIP:OK"elseecho"✗Extrac\ca~odeIP:FAIL(got:IP"=="192.168.1.100"]];thenecho"✓Extrac\c​a~odeIP:OK"elseecho"✗Extrac\c​a~odeIP:FAIL(got:IP)"
exit 1
fi

echo "✅ Todos os testes passaram!"
