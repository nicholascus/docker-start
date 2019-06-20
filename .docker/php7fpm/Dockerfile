FROM php:7.2-fpm-stretch

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
   && php -r "if (hash_file('SHA384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
   && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install pdo_mysql bcmath

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN apt-get update && apt-get install -y git unzip vim

WORKDIR /app

VOLUME ["/app"]
