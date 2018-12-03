FROM yobasystems/alpine:3.8.1-aarch64
LABEL maintainer "Dominic Taylor <dominic@yobasystems.co.uk>" architecture="ARM64v8/aarch64" version="10.2.15" alpineversion="3.8.1" build="01-dec-2018" container-build="$CI_COMMIT_SHA"

RUN apk add --no-cache mariadb mariadb-client pwgen && \
    rm -f /var/cache/apk/*

ADD files/run.sh /scripts/run.sh
RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
