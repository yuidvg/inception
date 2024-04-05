FROM alpine:3.18

ARG WP_DIR=/var/www/html
ARG PHP_VERSION=82
ENV PHP_VERSION=${PHP_VERSION}
ARG WP_VERSION=6.4.3
ARG WP_USER=wordpress
ARG LOG_DIR=/usr/log/php82/

# https://make.wordpress.org/hosting/handbook/server-environment/
# https://pkgs.org/
RUN apk update && apk upgrade && apk add --no-cache \
  php${PHP_VERSION} \
  php${PHP_VERSION}-fpm \
  php${PHP_VERSION}-mysqli \
  curl \
  tar

RUN adduser -S ${WP_USER} && addgroup -S ${WP_USER}

RUN mkdir -p ${LOG_DIR} && chown -R ${WP_USER}:${WP_USER} ${LOG_DIR}

RUN  mkdir -p ${WP_DIR} && chown -R ${WP_USER}:${WP_USER} ${WP_DIR}

RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WP_VERSION}.tar.gz && \
  tar -xzf wordpress.tar.gz --strip-components=1 -C ${WP_DIR} && \
  rm -rf wordpress.tar.gz

EXPOSE 9000

ENTRYPOINT php-fpm${PHP_VERSION} --nodaemonize
