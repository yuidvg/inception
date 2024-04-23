FROM alpine:3.18

ENV MARIADB_USER=mysql
ENV MARIADB_BASEDIR=/usr
ENV MARIADB_DATADIR=/var/lib/mysql
ENV MARIADB_RUNTIME_DIR=/run/mysqld

RUN apk update && apk upgrade && apk add --no-cache \
    mariadb \
    envsubst \
    rm -rf /var/cache/apk/*

RUN mkdir -p ${MARIADB_RUNTIME_DIR} && \
    chown -R mysql:mysql ${MARIADB_RUNTIME_DIR}

RUN mkdir -p ${MARIADB_DATADIR} && \
    chown -R mysql:mysql ${MARIADB_DATADIR}

RUN mysql_install_db --user=${MARIADB_USER} --basedir=${MARIADB_BASEDIR} --datadir=${MARIADB_DATADIR}

RUN  mariadbd --user=mysql --bootstrap <<EOF
USE mysql ;
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS test ;
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'rootpassword';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wpdb CHARACTER SET utf8 COLLATE utf8_general_ci ;
GRANT ALL ON wpdb.* TO 'root'@'%' WITH GRANT OPTION ;
CREATE USER IF NOT EXISTS 'wpdbuser'@'%' IDENTIFIED BY 'wpdbuserpassword';
GRANT ALL ON wpdb.* TO 'wpdbuser'@'%';
FLUSH PRIVILEGES;
EOF

EXPOSE 3306

ENTRYPOINT ["/usr/bin/mysqld_safe", "--user=mysql", "--console", "--syslog", "--general-log", "--slow-query-log"]
