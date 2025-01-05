#!/bin/bash

sleep 10

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

sed -i 's/listen\s*=\s*\/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;pm.status_path = \/status/pm.status_path = \/php_fpm_status/' /etc/php/7.4/fpm/pool.d/www.conf

wp core download --allow-root --path=/var/www/html/wordpress

cd /var/www/html/wordpress
wp config create --allow-root --dbname=${DB_DATABASE} --dbuser=${DB_USERNAME} --dbpass=${DB_PASSWORD} --dbhost=mariadb

chmod 777 /var/www/html/*
wp core install --allow-root --url=https://${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}

wp user create --allow-root ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWD} --role=contributor

php-fpm7.4 -F -R -y /etc/php/7.4/fpm/php-fpm.conf