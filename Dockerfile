 #
# Application
#
FROM php:8.0.2-apache

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_ENV=dev

RUN a2enmod ssl && a2enmod rewrite

 
# Install extensions
RUN apt-get update && apt-get install -y \
    wget \
    apt-utils \
    libxml2-dev \
    gnupg \
    apt-transport-https \
    git \
    libzip-dev \
    libicu-dev \
    build-essential \
    libsasl2-dev \
    libssl-dev \
    zlib1g-dev \
    libzip-dev \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && docker-php-ext-install zip intl zip exif sockets mysqli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

  
CMD ["apachectl", "-D", "FOREGROUND"]
 
