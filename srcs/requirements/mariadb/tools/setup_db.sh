#!/bin/bash

service mariadb start

mysql -u root -e "CREATE DATABASE openWorld;"
mysql -u root -e "CREATE USER 'rihoy'@'host' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON openWorld.* TO 'rihoy'@'host' IDENTIFIED BY 'password';"
mysql -u root -e "FLUSH PRIVILEGES;"
