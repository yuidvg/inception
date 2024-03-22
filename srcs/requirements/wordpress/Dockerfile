FROM alpine:3.18

# https://make.wordpress.org/hosting/handbook/server-environment/
# https://pkgs.org/
RUN apk update && apk upgrade && apk add --no-cache \
  php82 \
  php82-fpm \
  curl \
  tar \
  wget

RUN adduser -S nginx && addgroup -S nginx
# fastcgiの処理に関連する設定
COPY ./conf/php-fpm.conf /etc/php82/php-fpm.conf
COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN mkdir -p /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp

RUN curl -o wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz && \
  tar -xzf wordpress.tar.gz --strip-components=1 -C /var/www/html
RUN chmod -R 777 /tmp/

ENTRYPOINT [ "php-fpm82", "--nodaemonize" ]