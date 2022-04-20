#!/bin/sh

if [ ! -f "/var/www/html/index.html" ]; then

  cp /tmp/index.html /var/www/html/index.html
  cp /tmp/style.css /var/www/html/style.css

  wp core download --allow-root
  wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
  wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
  wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
  wp theme install twentysixteen --activate --allow-root

  sed -i "40i define( 'WP_REDIS_HOST', 'redis' );"      wp-config.php

  wp plugin install redis-cache --activate --allow-root
  wp plugin update --all --allow-root

  wp redis enable --allow-root
fi

/usr/sbin/php-fpm7 -F -R

# -F, --nodaemonize
#      force to stay in foreground, and ignore daemonize option from config file

# Если вы запускаете php-fpm в контейнере docker, есть большая вероятность, что вы запускаете процесс от имени root.
# php-fpm не будет запускаться как root без дополнительного флага:

#  -R, --allow-to-run-as-root
#        Allow pool to run as root (disabled by default)