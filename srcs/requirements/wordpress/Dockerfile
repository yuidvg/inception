FROM alpine:3.18

ARG WP_DIR=/var/www/html
ARG WP_USER=wordpress
ARG LOG_DIR=/usr/log/php82/

RUN apk update && apk upgrade && apk add --no-cache \
  php82 \
  php82-fpm \
  php82-mysqli \
  curl \
  tar\
  rm -rf /var/cache/apk/*

RUN adduser -S ${WP_USER} && addgroup -S ${WP_USER}

RUN mkdir -p ${LOG_DIR} && chown -R ${WP_USER}:${WP_USER} ${LOG_DIR}

RUN  mkdir -p ${WP_DIR} && chown -R ${WP_USER}:${WP_USER} ${WP_DIR}

RUN curl -o wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz && \
  tar -xzf wordpress.tar.gz --strip-components=1 -C ${WP_DIR} && \
  rm -rf wordpress.tar.gz

EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm82", "--nodaemonize"]
