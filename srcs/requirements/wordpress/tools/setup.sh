#!/bin/sh

# wait until database is ready
while ! mariadb -h$MARIADB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_NAME --silent; do
	echo "[i] waiting database connection..."
	sleep 10;
done

# check if wordpress is installed
if [ ! -f "/var/www/html/$WP_FILE_ONINSTALL" ]; then
	echo "[i] wordpress installing..."

	# wp-cli
  # wp core download --allow-root
  echo "[i] wordpress expanding..."
  tar -xzvf /tmp/wordpress-6.2.tar.gz -C /var/www/html/ >/dev/null && chmod -R 755 /var/www/html/wordpress
  cd /var/www/html/wordpress
  echo "[i] config creating..."
	wp config create \
    --dbname=$WP_DB_NAME \
    --dbuser=$WP_DB_USER \
    --dbpass=$WP_DB_PASSWORD \
		--dbhost=$MARIADB_HOST \
    --dbcharset="utf8" \
    --dbcollate="utf8_general_ci" \
    --allow-root
  echo "[i] wordpress installing..."
	wp core install \
    --url=$DOMAIN_NAME \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email \
    --allow-root
  echo "[i] user creating..."
	wp user create \
    $WP_USER $WP_EMAIL \
    --role=author \
    --user_pass=$WP_PASSWORD \
    --allow-root

	# update plugins
  wp plugin update --all --allow-root

  mv /tmp/index.html /var/www/html/wordpress
	touch /var/www/html/$WP_FILE_ONINSTALL
fi

mkdir -p /var/run/php-fpm7
echo "[i] => Done wordpress setup!"

exec "$@"
