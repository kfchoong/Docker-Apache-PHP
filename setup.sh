#!/bin/bash

echo "***********************************"
echo "Setup Apache-PHP-MySQL Docker Image"
echo "***********************************"
echo "Setting up \"src\" and \"data\" folders"

if [ ! -d "src" ]; then
	mkdir src
fi
if [ ! -d "data" ]; then
	mkdir data
fi

echo "Enter Project name (e.g. ounch_webserver):"
read project_name
echo "Enter Web server port (e.g. 8000):"
read web_port
echo "Enter MySQL server port (e.g. 9906):"
read mysql_port
echo "Enter MySQL Root Password:"
read mysql_root_password
echo "Enter MySQL Database:"
read mysql_database
echo "Enter MySQL User:"
read mysql_user
echo "Enter MySQL User Password:"
read mysql_user_password
echo "Enter phpmyadmin port (e.g. 8080):"
read phpmyadmin_port


cat <<EOF > ./docker-compose.yml
version: '3.8'
services:
  php-apache-environment:
    container_name: $project_name-php-apache
    build:
      context: ./
      dockerfile: Dockerfile
    volumes:
      - ./src:/var/www/html/
    ports:
      - $web_port:80
  db:
    container_name: $project_name-db
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: $mysql_root_password
      MYSQL_DATABASE: $mysql_database
      MYSQL_USER: $mysql_user
      MYSQL_PASSWORD: $mysql_user_password
    ports:
      - "$mysql_port:3306"
    volumes:
      - ./data:/var/lib/mysql
  phpmyadmin:
  	container_name: $project_name-phpmyadmin
    image: phpmyadmin/phpmyadmin
    ports:
      - '$phpmyadmin_port:80'
    restart: always
    environment:
      PMA_HOST: db
    depends_on:
      - db
EOF
