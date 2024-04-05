FROM alpine:3.18

ENV MARIADB_USER=mysql
ENV MARIADB_BASEDIR=/usr
ENV MARIADB_DATADIR=/var/lib/mysql
ENV MARIADB_RUNTIME_DIR=/run/mysqld

RUN apk update && apk upgrade && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-common && \
    rm -rf /var/cache/apk/*

RUN mkdir -p ${MARIADB_RUNTIME_DIR} && \
    chown -R mysql:mysql ${MARIADB_RUNTIME_DIR}

RUN mkdir -p ${MARIADB_DATADIR} && \
    chown -R mysql:mysql ${MARIADB_DATADIR}

RUN mysql_install_db --user=${MARIADB_USER} --basedir=${MARIADB_BASEDIR} --datadir=${MARIADB_DATADIR}

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf


RUN echo "USE mysql ;\
    FLUSH PRIVILEGES ;\
    DROP DATABASE IF EXISTS test ;\
    GRANT ALL ON *.* TO 'root'@'%' identified by '$MARIADB_ROOT_PASSWORD' WITH GRANT OPTION ;\
    GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MARIADB_ROOT_PASSWORD' WITH GRANT OPTION ;\
    SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MARIADB_ROOT_PASSWORD}') ;\
    SET PASSWORD FOR 'root'@'%'=PASSWORD('${MARIADB_ROOT_PASSWORD}') ;\
    FLUSH PRIVILEGES ;\
    CREATE DATABASE IF NOT EXISTS $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci ;\
    CREATE USER '$WP_DB_USER'@'localhost' IDENTIFIED BY '$WP_DB_PASSWORD';\
    CREATE USER '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASSWORD';\
    GRANT ALL PRIVILEGES ON *.* TO '$WP_DB_USER'@'localhost';\
    GRANT ALL PRIVILEGES ON *.* TO '$WP_DB_USER'@'%';\
    FLUSH PRIVILEGES ;"| mysql

ENTRYPOINT [ "/usr/bin/mysqld" ]
CMD [ "--user=mysql", "--console" ]