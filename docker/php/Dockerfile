FROM php:7.4-fpm-alpine

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
ENV PATH="~/.composer/vendor/bin:./vendor/bin:${PATH}"

# Add PHPIZE deps
RUN apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS

# MySQL
RUN docker-php-ext-install -j $(nproc) mysqli pdo_mysql

## Redis 5.2.2
RUN pecl install redis-5.2.2 \
  && docker-php-ext-enable redis

## Enable Opcache
RUN docker-php-ext-enable opcache 

## Magento deps
## https://devdocs.magento.com/guides/v2.3/install-gde/prereq/php-settings.html#verify-installed-extensions
RUN docker-php-ext-install -j $(nproc) bcmath
# RUN docker-php-ext-install -j $(nproc) ctype
# RUN apk add --no-cache curl-dev \
#   && docker-php-ext-install -j $(nproc) curl
# RUN apk add --no-cache libxml2-dev \
#   && docker-php-ext-install -j $(nproc) dom
RUN apk add --no-cache libpng-dev libjpeg-turbo-dev freetype-dev libwebp-dev \
  && docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg \
  && docker-php-ext-install -j $(nproc) gd
# RUN docker-php-ext-install -j $(nproc) hash
# RUN docker-php-ext-install -j $(nproc) iconv
RUN apk add --no-cache icu icu-dev \
  && docker-php-ext-install -j $(nproc) intl
# RUN docker-php-ext-install -j $(nproc) mbstring
# RUN docker-php-ext-install -j $(nproc) openssl
# RUN docker-php-ext-install -j $(nproc) simplexml
RUN apk add --no-cache libxml2-dev \
  && docker-php-ext-install -j $(nproc) soap
RUN apk add --no-cache libxslt-dev \
  && docker-php-ext-install -j $(nproc) xsl
RUN apk add --no-cache libzip-dev \
  && docker-php-ext-install -j $(nproc) zip
RUN docker-php-ext-install -j $(nproc) sockets


## https://devdocs.magento.com/guides/v2.3/install-gde/system-requirements-tech.html#required-system-dependencies
RUN apk add \
  bash \
  mariadb-common

## XDebug 2.9.6
# RUN pecl install xdebug-2.9.6 \
#    && docker-php-ext-enable xdebug

# Cleanup PHPIZE deps
RUN apk del .phpize-deps

# Custom PHP configs
ADD custom.ini /usr/local/etc/php/conf.d/custom.ini