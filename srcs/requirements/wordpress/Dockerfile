FROM alpine:3.18

ARG WP_DIR=/var/www/html
ARG PHP_VERSION=82
ARG WP_VERSION=6.4.3

# https://make.wordpress.org/hosting/handbook/server-environment/
# https://pkgs.org/
RUN apk update && apk upgrade && apk add --no-cache \
  php${PHP_VERSION} \
  php${PHP_VERSION}-fpm \
  curl \
  tar

RUN adduser -S nginx && addgroup -S nginx

# fastcgiの処理に関連する設定
COPY ./conf/php-fpm.conf /etc/php${PHP_VERSION}/php-fpm.conf
COPY ./conf/www.conf /etc/php${PHP_VERSION}/php-fpm.d/www.conf

RUN mkdir -p /var/www/html

RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WP_VERSION}.tar.gz && \
  tar -xzf wordpress.tar.gz --strip-components=1 -C ${WP_DIR}

ENTRYPOINT [ "php-fpm${PHP_VERSION}", "--nodaemonize" ]