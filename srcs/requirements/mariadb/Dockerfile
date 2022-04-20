FROM alpine:3.13

RUN	apk update && apk upgrade && apk add --no-cache \
        mariadb \
        mariadb-client

COPY setup.sh /tmp/setup.sh

ENTRYPOINT ["sh", "/tmp/setup.sh"]