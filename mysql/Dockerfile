FROM --platform=linux/amd64 mysql:8.0

VOLUME /data

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    MYSQL_DATABASE=gloves_shop \
    MYSQL_USER=gloves_user \
    MYSQL_PASSWORD=gloves_password

COPY scripts/* /docker-entrypoint-initdb.d/