#!/bin/sh

separator() {
  echo '::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
  echo $1
  echo '::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
  echo ''
  echo ''
}

# Installing php extensions
install_dependencies() {
    separator 'Installing php extensions'
    apk update && apk add oniguruma-dev zlib-dev libpng-dev postgresql-dev libzip-dev
    pecl install redis && docker-php-ext-enable redis
    docker-php-ext-install mbstring exif pcntl bcmath gd zip mysqli pdo pdo_mysql
    apk update && apk upgrade
}

# Installing php composer
install_composer() {
    separator 'Install php composer'
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    separator 'Verify instalation'
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    separator 'Execute Instalation'
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    separator 'Move composer bin to /usr/local/bin/composer'
    mv composer.phar /usr/local/bin/composer
}

install_dependencies
install_composer