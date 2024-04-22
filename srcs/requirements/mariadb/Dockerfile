FROM alpine:3.18

ENV MARIADB_USER=mysql
ENV MARIADB_BASEDIR=/usr
ENV MARIADB_DATADIR=/var/lib/mysql
ENV MARIADB_RUNTIME_DIR=/run/mysqld

RUN apk update && apk upgrade && apk add --no-cache \
    mariadb \
    mariadb-client \
    openrc \
    envsubst \
    rm -rf /var/cache/apk/*

RUN mkdir -p ${MARIADB_RUNTIME_DIR} && \
    chown -R mysql:mysql ${MARIADB_RUNTIME_DIR}

RUN mkdir -p ${MARIADB_DATADIR} && \
    chown -R mysql:mysql ${MARIADB_DATADIR}

RUN mysql_install_db --user=${MARIADB_USER} --basedir=${MARIADB_BASEDIR} --datadir=${MARIADB_DATADIR}

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ../conf/db-setup.sql /

RUN envsubst < /db-setup.sql | mariadbd --user=mysql --bootstrap

EXPOSE 3306

ENTRYPOINT ["/usr/bin/mysqld_safe"]

CMD [ "--user=mysql", "--console", "--syslog", "--general-log", "--slow-query-log"]
