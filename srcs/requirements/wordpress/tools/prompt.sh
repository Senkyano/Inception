#!/bin/bash
DB_USERNAME=$(cat /run/secrets/db_username.txt)
DB_PASSWORD=$(cat /run/secrets/db_password.txt)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password.txt)

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

sed -i 's/listen\s*=\s*\/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;pm.status_path = \/status/pm.status_path = \/php_fpm_status/' /etc/php/7.4/fpm/pool.d/www.conf


cd /var/www/html

wp core download --allow-root --path=/var/www/html/wordpress

wp config create --allow-root --path=/var/www/html/wordpress --dbname=${DB_DATABASE} --dbuser=${DB_USERNAME} --dbpass=${DB_PASSWORD} --dbhost=mariadb

chmod 777 /var/www/html/*

wp core install --allow-root --path=/var/www/html/wordpress --url=https://"$DOMAIN_NAME" --title="$WP_TITLE" --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}

wp user create --allow-root --path=/var/www/html/wordpress ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWD} --role=author

wp term create category 'Science' --description='Science' --allow-root --path=/var/www/html/wordpress --slug=science

wp post create --allow-root --path=/var/www/html/wordpress --post_author=llarue --post_title='RECOGNIZING METEOROLOGICAL SIGNIFICANCE' --post_name='recognizing-meterological-significance' --post_category='Science' --post_status=publish 
wp post create --allow-root --path=/var/www/html/wordpress --post_author=llarue --post_title='THE SCIENCE BEHIND RAINBOWS' --post_name='the-science-behind-rainbows' --post_category='Science' --post_status=publish

php-fpm7.4 -F -R -y /etc/php/7.4/fpm/php-fpm.conf