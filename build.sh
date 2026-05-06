#!/bin/bash

BASE="mail-guardian-final"

mkdir -p $BASE/{core,config,data,dashboard}

echo "Copiando estrutura..."

cp -r /opt/mail-guardian/core/* $BASE/core/ 2>/dev/null
cp -r /etc/mail-guardian/* $BASE/config/ 2>/dev/null
cp -r /opt/mail-guardian/dashboard/* $BASE/dashboard/ 2>/dev/null

echo "Criando arquivos base..."

touch $BASE/data/state.db
touch $BASE/data/events.log

echo "Compactando..."

zip -r ${BASE}.zip $BASE

echo "Pronto: ${BASE}.zip"
