FROM php:7.4-apache

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

RUN a2enmod rewrite

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY . /var/www/html

WORKDIR /var/www/html

RUN composer install --no-scripts --no-autoloader
RUN composer dump-autoload

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 80
