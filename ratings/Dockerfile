#
# Build the app
#
FROM --platform=linux/amd64 php:7.4-apache

RUN apt-get update && apt-get install -yqq unzip libzip-dev \
    && docker-php-ext-install pdo_mysql opcache zip

# Enable Apache mod_rewrite and status
RUN a2enmod rewrite && a2enmod status

# relax permissions on status
COPY status.conf /etc/apache2/mods-available/status.conf

WORKDIR /var/www/html

COPY html/ /var/www/html

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer install

# Permissions for Symfony
RUN rm -Rf /var/www/var/*
RUN chown -R www-data /var/www
RUN chmod -R 777 /var/www