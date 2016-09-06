FROM alpine:3.2
MAINTAINER Dominic Taylor <dominic@yobasystems.co.uk>

RUN echo '@mariadb5.5.47-r0 http://dl-cdn.alpinelinux.org/alpine/v3.2/main' >> /etc/apk/repositories

RUN apk --update add mariadb@mariadb5.5.47-r0 mariadb-client@mariadb5.5.47-r0 pwgen && rm -f /var/cache/apk/* && \
    echo "Success"

ADD files/run.sh /scripts/run.sh
RUN mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
