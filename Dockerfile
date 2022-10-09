FROM php:8.0-apache
RUN a2enmod rewrite
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
     install-php-extensions mysqli pdo_mysql json intl xml mbstring
RUN apt-get update && apt-get upgrade -y

