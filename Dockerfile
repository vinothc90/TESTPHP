# Container image that runs your code
# FROM ubuntu:16.04
FROM php:7.2-apache

RUN apt-get update \
    && apt-get install -y git curl libmcrypt-dev libxrender1 libfontconfig unzip \
    libxml2-dev libpng-dev g++ make autoconf \
    && docker-php-source extract \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-source delete \
    && docker-php-ext-install pdo_mysql soap intl zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /tmp/*

RUN a2enmod rewrite headers

RUN a2dissite 000-default

COPY php/php.ini /usr/local/etc/php/conf.d/php.ini

COPY php/vhost.conf /etc/apache2/sites-available/vhost.conf
RUN a2ensite vhost

ENV SELENIUM_HOST=selenium
ENV GITLAB_CI_MAIN_APP_HOST=eot

WORKDIR /var/www/eot

EXPOSE 80
