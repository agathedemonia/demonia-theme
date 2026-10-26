#!/bin/bash
# Relance le banc de test PrestaShop 9.1.4 + Classic 3.1.2 après une mise en veille du poste.
pgrep -x mariadbd >/dev/null || (mysqld_safe --user=mysql >/dev/null 2>&1 &)
grep -q "api.prestashop.com" /etc/hosts || echo "127.0.0.1 api.prestashop.com" >> /etc/hosts
for i in $(seq 1 20); do mysqladmin -uroot status >/dev/null 2>&1 && break; sleep 1; done
apachectl start 2>/dev/null || apachectl graceful 2>/dev/null
sleep 1
curl -s -o /dev/null -w "Boutique de test : HTTP %{http_code} sur http://localhost:8080/\n" http://localhost:8080/
