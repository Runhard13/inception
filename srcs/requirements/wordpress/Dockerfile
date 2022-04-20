FROM alpine:3.13

RUN	apk update && apk upgrade && apk add --no-cache \
    wget \
    php7 \
    php7-fpm \
    php7-opcache \
    php7-gd\
    php7-mysqli \
    php7-zlib \
    php7-json \
    php7-phar \
    mariadb-client \
    php7-mbstring



# php config
RUN	adduser -S nginx &&	addgroup -S nginx

COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf

# static website
COPY index.html /tmp/index.html
COPY style.css /tmp/style.css

# install wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp


WORKDIR /var/www/html/wordpress

COPY setup.sh /tmp/setup.sh
ENTRYPOINT [ "sh", "/tmp/setup.sh" ]