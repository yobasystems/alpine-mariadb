FROM yobasystems/alpine:3.9.0-amd64
LABEL maintainer "Dominic Taylor <dominic@yobasystems.co.uk>" architecture="AMD64/x86_64"
LABEL mariadb-version="10.3.13" alpine-version="3.9.0" build="28-Feb-2019"

ARG COMMIT_TIME
ARG CI_APPLICATION_TAG_SHORT
LABEL org.label-schema.build-date="$COMMIT_TIME" \
      org.label-schema.name="alpine-mariadb" \
      org.label-schema.description="MariaDB Docker image running on Alpine Linux" \
      org.label-schema.vcs-ref="$CI_APPLICATION_TAG_SHORT" \
      org.label-schema.vcs-url="https://github.com/yobasystems/alpine-mariadb" \
      org.label-schema.vendor="Yoba Systems" \
      org.label-schema.version="10.3.13" \
      org.label-schema.schema-version="1.0"

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
