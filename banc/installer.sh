#!/bin/bash
# Installe le banc de test : PrestaShop 9.1.4 + Classic 3.1.2, en français, avec données de démo.
# Prévu pour le poste de travail Ubuntu 24.04 de Claude. Domaines réseau requis :
# GitHub, repo.packagist.org, packagist.org, i18n.prestashop-project.org (+ registre npm).
# Usage : sudo ./installer.sh   (le mot de passe admin est généré et écrit dans ~/banc/identifiants-test.txt)
set -euo pipefail
PS_DIR=/home/claude/ps914
DB=ps_demonia; DB_USER=ps; DB_PASS=ps_local_test
CRED_DIR=/home/claude/banc

# 1. Pile serveur
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq mariadb-server apache2 libapache2-mod-php8.3 \
  php8.3-mysql php8.3-gd php8.3-intl php8.3-zip php8.3-curl php8.3-xml php8.3-mbstring php8.3-bcmath >/dev/null
sed -i 's/^memory_limit = .*/memory_limit = 512M/; s/^upload_max_filesize = .*/upload_max_filesize = 64M/; s/^post_max_size = .*/post_max_size = 64M/; s/^max_execution_time = .*/max_execution_time = 300/' \
  /etc/php/8.3/apache2/php.ini /etc/php/8.3/cli/php.ini

# 2. Sources 9.1.4, dépendances, assets
[ -d "$PS_DIR" ] || git clone --depth 1 --branch 9.1.4 https://github.com/PrestaShop/PrestaShop "$PS_DIR"
rm -rf "$PS_DIR/.git"
cd "$PS_DIR"
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --prefer-dist --no-interaction --no-progress -o
./tools/assets/build.sh all --force
grep -q "^version: 3.1.2" themes/classic/config/theme.yml || { echo "Classic n'est pas en 3.1.2"; exit 1; }

# 3. Flux des taux de change : api.prestashop.com n'est pas autorisé, on sert un flux vide (EUR seul).
mkdir -p /var/www/fake-ps-api/xml
printf '<?xml version="1.0" encoding="UTF-8"?>\n<currencies><source iso_code="EUR"/><list></list></currencies>\n' > /var/www/fake-ps-api/xml/currencies.xml
cat > /etc/apache2/sites-available/fake-ps-api.conf <<'CONF'
<VirtualHost *:80>
    ServerName api.prestashop.com
    DocumentRoot /var/www/fake-ps-api
</VirtualHost>
CONF
grep -q "api.prestashop.com" /etc/hosts || echo "127.0.0.1 api.prestashop.com" >> /etc/hosts

# 4. Apache sur le port 8080
cat > /etc/apache2/sites-available/ps.conf <<CONF
<VirtualHost *:8080>
    ServerName localhost
    DocumentRoot $PS_DIR
    <Directory $PS_DIR>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
CONF
grep -q "Listen 8080" /etc/apache2/ports.conf || echo "Listen 8080" >> /etc/apache2/ports.conf
a2enmod rewrite headers >/dev/null; a2dissite 000-default >/dev/null || true; a2ensite ps fake-ps-api >/dev/null
chmod o+x /home/claude; chown -R www-data:www-data "$PS_DIR"

# 5. Base de données
pgrep -x mariadbd >/dev/null || (mysqld_safe --user=mysql >/dev/null 2>&1 &)
for i in $(seq 1 20); do mysqladmin -uroot status >/dev/null 2>&1 && break; sleep 1; done
mysql -uroot -e "DROP DATABASE IF EXISTS $DB; CREATE DATABASE $DB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
  CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS'; GRANT ALL ON $DB.* TO '$DB_USER'@'localhost'; FLUSH PRIVILEGES;"
apachectl start 2>/dev/null || apachectl graceful

# 6. Installation (mot de passe admin généré, jamais versionné)
mkdir -p "$CRED_DIR"
PW="$(openssl rand -base64 18 | tr -dc 'A-Za-z0-9' | head -c 16)Aa1!"
printf "Back-office local (test uniquement)\nURL: http://localhost:8080/admin-dev/\nEmail: admin@demonia.test\nMot de passe: %s\n" "$PW" > "$CRED_DIR/identifiants-test.txt"
chmod 600 "$CRED_DIR/identifiants-test.txt"
rm -f app/config/parameters.php
sudo -u www-data env https_proxy="${https_proxy:-}" HTTPS_PROXY="${HTTPS_PROXY:-}" no_proxy="${no_proxy:-}" NO_PROXY="${NO_PROXY:-}" \
  SSL_CERT_FILE=/root/.ccr/ca-bundle.crt php -d memory_limit=1G install-dev/index_cli.php --step=all \
  --language=fr --country=fr --timezone=Europe/Paris --domain=localhost:8080 \
  --db_server=127.0.0.1 --db_name=$DB --db_user=$DB_USER --db_password=$DB_PASS --prefix=ps_ \
  --name="Démonia (test)" --firstname=Test --lastname=Demonia --email=admin@demonia.test --password="$PW" \
  --ssl=0 --rewrite=1 --fixtures=1 --newsletter=0 --send_email=0

echo "Installé. L'installateur active Hummingbird : activer Classic dans Apparence > Thème et logo (la commande prestashop:theme:enable échoue sans contexte back-office)."
