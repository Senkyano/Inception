#!/bin/bash

# Lecture secret
DB_USERNAME=$(cat /run/secrets/db_username)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Modification de l'interface reseaux pour permettre la connexion a partir de n'importe quel reseaux
# sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Demarrer le service
service mariadb start

# Wait service has finish his initialisation
sleep 2

# Configuration
if mariadb -e "USE $DB_DANAME;" 2> /dev/null; then
	echo 'mariadb: DATA NAME Already exist'
else
	mysql -u root -e "CREATE DATABASE $DB_DANAME;"

	mysql -u root -e "CREATE USER '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_DANAME.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_DANAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD' WITH GRANT OPTION;"

	mysql -u root -e "FLUSH PRIVILEGES;"
fi

# Arrete le service
service mariadb stop

# Wait service
sleep 2

# Lancier mariadb pour qu'il tourne en arriere plan
# exec mysqld_safe --bind-address=0.0.0.0
exec mysqld_safe