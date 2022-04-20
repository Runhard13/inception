FROM alpine:3.13

RUN apk update && apk upgrade && apk --no-cache add \
    nginx \
    openssl

#SSL
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 3650 -nodes \
                -out /etc/nginx/ssl/cdrennan.pem \
                -keyout /etc/nginx/ssl/cdrennan.key \
                -subj "/C=RU/ST=Tatarstan/L=Kazan/O=21school/OU=nginx/CN=localhost"

#Config
RUN mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

#Start
ENTRYPOINT ["nginx", "-g", "daemon off;"]