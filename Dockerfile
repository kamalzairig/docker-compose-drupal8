FROM php:5.6-apache

MAINTAINER Kamal ZAIRIG <kamal.zairig@gmail.com>

ENV TERM xterm

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y nano mysql-client php5-mysql libpng12-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip opcache \
	&& docker-php-ext-enable gd opcache pdo_mysql zip

# install Drush with Composer globally
RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/composer \
        && composer global require drush/drush:8.* \
        && ln -s $HOME/.composer/vendor/bin/drush /usr/local/bin/drush
