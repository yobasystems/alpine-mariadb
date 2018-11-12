FROM yobasystems/alpine:3.8.1-armhf
LABEL maintainer "Dominic Taylor <dominic@yobasystems.co.uk>" architecture="ARM32v7/armhf" version="10.2.15" alpineversion="3.8.1" build="11-nov-2018"

RUN apk --update add mariadb mariadb-client pwgen && \
    rm -f /var/cache/apk/*

ADD files/run.sh /scripts/run.sh
RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
