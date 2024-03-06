FROM alpine:3.18

# https://make.wordpress.org/hosting/handbook/server-environment/
# https://pkgs.org/
RUN apk update && apk upgrade && apk add --no-cache \
  php \
  php-fpm \
  php-mysqli \
  php-opcache \
  php-bcmath \
  php-exif \
  php-gd \
  php-curl \
  php-json \
  php-mbstring \
  php-intl \
  php-xml \
  php-zip \
  php-openssl \
  php-pear \
  php-phar \
  php-zip \
  php-zlib \
  mariadb-client \
  curl \
  ca-certificates \
  tar \
  wget \
  bash \
  less

RUN adduser -S nginx && addgroup -S nginx
# fastcgiの処理に関連する設定
COPY ./conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

RUN curl -o wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz \
  tar -xzf wordpress.tar.gz --strip-components=1 -C /var/www/html
COPY ./tools/index.html /tmp/
RUN chmod -R 777 /tmp/

ENTRYPOINT [ "setup.sh" ]

CMD [ "php-fpm8", "--nodaemonize" ]
