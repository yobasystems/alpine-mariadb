FROM yobasystems/alpine:3.19.3-armhf

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dominic Taylor <dominic@yoba.systems>" \
    architecture="arm32v7/armhf" \
    mariadb-version="10.11.6" \
    alpine-version="3.19.3" \
    build="19-Aug-2024" \
    org.opencontainers.image.title="alpine-mariadb" \
    org.opencontainers.image.description="MariaDB Container image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yoba.systems>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="10.11.6" \
    org.opencontainers.image.url="https://hub.docker.com/r/yobasystems/alpine-mariadb/" \
    org.opencontainers.image.source="https://github.com/yobasystems/alpine-mariadb" \
    org.opencontainers.image.base.name="docker.io/yobasystems/alpine:3.19.3" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen && \
    rm -f /var/cache/apk/*

ADD files/run.sh /scripts/run.sh
RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
