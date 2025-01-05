#!/bin/bash
DB_USERNAME=$(cat /run/secrets/db_username)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

sed -i 's/listen\s*=\s*\/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;pm.status_path = \/status/pm.status_path = \/php_fpm_status/' /etc/php/7.4/fpm/pool.d/www.conf


cd /var/www/html

wp core download --allow-root

wp config create --allow-root --dbname=${DB_DATABASE} --dbuser=${DB_USERNAME} --dbpass=${DB_PASSWORD} --dbhost=mariadb --url=https://${DOMAIN_NAME}

chmod 777 /var/www/html/*

wp core install --allow-root --url=https://${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}

wp user create --allow-root ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWD} --role=author

chown -R root:root /var/www/html

if [! -d /run/php ]; then
	mkdir /run/php;
fi

php-fpm7.4 -F -R -y /etc/php/7.4/fpm/php-fpm.conf

# #!/bin/bash

# # Attente pour s'assurer que mariaDB est prêt
# sleep 10

# cd /var/www/html

# if ! wp core is-installed --allow-root 2>/dev/null; then
# sleep 10

# wp core download --allow-root

# wp config create --allow-root --dbname=${DB_DATABASE} \
#             --dbuser=${DB_USERNAME} \
#             --dbpass=${DB_ROOT_PASSWORD} \
#             --dbhost=${SQL_HOST} \
#             --url=https://${DOMAIN_NAME}

# chmod 777 /var/www/html/*

# wp core install --allow-root \
#             --url=https://${DOMAIN_NAME} \
#             --title=${SITE_TITLE} \
#             --admin_user=${ADMIN_USER} \
#             --admin_password=${ADMIN_PASSWORD} \
#             --admin_email=${ADMIN_EMAIL}

# wp user create --allow-root \
#             ${USER1_LOGIN} ${USER1_MAIL} \
#             --role=author \
#             --user_pass=${USER1_PASS}

# chown -R root:root /var/www/html

# fi

# if [ ! -d /run/php ]; then
#     mkdir /run/php;
# fi

# # Démarrage de PHP-FPM
# exec /usr/sbin/php-fpm7.4 -F -R