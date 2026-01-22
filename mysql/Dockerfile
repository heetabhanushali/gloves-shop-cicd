FROM --platform=linux/amd64 mysql:8.0

VOLUME /data

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    MYSQL_DATABASE=cities \
    MYSQL_USER=shipping \
    MYSQL_PASSWORD=secret

COPY config.sh /root/
RUN /root/config.sh

COPY scripts/* /docker-entrypoint-initdb.d/