#!/bin/sh

# Function to read secret from file
read_secret() {
    _secret_file="$1"
    if [ -f "$_secret_file" ] && [ -r "$_secret_file" ]; then
        cat "$_secret_file"
    else
        echo ""
    fi
}

# Set MYSQL_ variables based on MARIADB_ variables or secrets if MYSQL_ is not set
for var in ROOT_PASSWORD DATABASE USER PASSWORD CHARSET COLLATION; do
    eval mysql_var="\$MYSQL_${var}"
    eval mariadb_var="\$MARIADB_${var}"
    
    # Check environment variables
    if [ -z "$mysql_var" ] && [ -n "$mariadb_var" ]; then
        eval "export MYSQL_${var}=\$mariadb_var"
    fi
    
    # Check secrets
    mysql_secret="/run/secrets/mysql_$(echo $var | tr '[:upper:]' '[:lower:]')"
    mariadb_secret="/run/secrets/mariadb_$(echo $var | tr '[:upper:]' '[:lower:]')"
    
    if [ -z "$mysql_var" ] && [ -f "$mariadb_secret" ]; then
        eval "export MYSQL_${var}=$(read_secret "$mariadb_secret")"
    elif [ -z "$mysql_var" ] && [ -f "$mysql_secret" ]; then
        eval "export MYSQL_${var}=$(read_secret "$mysql_secret")"
    fi
done

# Handle *_FILE variables
for var in ROOT_PASSWORD DATABASE USER PASSWORD; do
    eval mysql_var="\$MYSQL_${var}"
    eval mysql_file_var="\$MYSQL_${var}_FILE"
    eval mariadb_file_var="\$MARIADB_${var}_FILE"
    
    if [ -z "$mysql_var" ] && [ -n "$mysql_file_var" ]; then
        eval "export MYSQL_${var}=$(read_secret "$mysql_file_var")"
    elif [ -z "$mysql_var" ] && [ -n "$mariadb_file_var" ]; then
        eval "export MYSQL_${var}=$(read_secret "$mariadb_file_var")"
    fi
done

# execute any pre-init scripts
for i in /scripts/pre-init.d/*sh
do
    if [ -e "${i}" ]; then
        echo "[i] pre-init.d - processing $i"
        . "${i}"
    fi
done

if [ -d "/run/mysqld" ]; then
    echo "[i] mysqld already present, skipping creation"
    chown -R mysql:mysql /run/mysqld
else
    echo "[i] mysqld not found, creating...."
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
    echo "[i] DB data directory already present, skipping creation"
    chown -R mysql:mysql /var/lib/mysql
else
    echo "[i] DB data directory not found, creating initial DBs"

    # execute any first-run scripts
    for i in /scripts/first-run.d/*sh
    do
        if [ -e "${i}" ]; then
            echo "[i] first-run.d - processing $i"
            . "${i}"
        fi
    done

    chown -R mysql:mysql /var/lib/mysql

    mariadb-install-db --user=mysql --ldata=/var/lib/mysql > /dev/null

    # Handle MYSQL_ROOT_PASSWORD
    if [ -n "$MYSQL_ROOT_PASSWORD_FILE" ]; then
        MYSQL_ROOT_PASSWORD=$(read_secret "$MYSQL_ROOT_PASSWORD_FILE")
    elif [ -f "/run/secrets/mysql_root_password" ]; then
        MYSQL_ROOT_PASSWORD=$(read_secret "/run/secrets/mysql_root_password")
    fi

    if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
        MYSQL_ROOT_PASSWORD=$(pwgen 16 1)
        echo "[i] Root Password: $MYSQL_ROOT_PASSWORD"
    fi

    # Handle MYSQL_DATABASE
    if [ -n "$MYSQL_DATABASE_FILE" ]; then
        MYSQL_DATABASE=$(read_secret "$MYSQL_DATABASE_FILE")
    elif [ -f "/run/secrets/mysql_database" ]; then
        MYSQL_DATABASE=$(read_secret "/run/secrets/mysql_database")
    else
        MYSQL_DATABASE=${MYSQL_DATABASE:-""}
    fi

    # Handle MYSQL_USER
    if [ -n "$MYSQL_USER_FILE" ]; then
        MYSQL_USER=$(read_secret "$MYSQL_USER_FILE")
    elif [ -f "/run/secrets/mysql_user" ]; then
        MYSQL_USER=$(read_secret "/run/secrets/mysql_user")
    else
        MYSQL_USER=${MYSQL_USER:-""}
    fi

    # Handle MYSQL_PASSWORD
    if [ -n "$MYSQL_PASSWORD_FILE" ]; then
        MYSQL_PASSWORD=$(read_secret "$MYSQL_PASSWORD_FILE")
    elif [ -f "/run/secrets/mysql_password" ]; then
        MYSQL_PASSWORD=$(read_secret "/run/secrets/mysql_password")
    else
        MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
    fi

    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    cat << EOF > "$tfile"
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF

    if [ "$MYSQL_DATABASE" != "" ]; then
        echo "[i] Creating database: $MYSQL_DATABASE"
        if [ "$MYSQL_CHARSET" != "" ] && [ "$MYSQL_COLLATION" != "" ]; then
            echo "[i] with character set [$MYSQL_CHARSET] and collation [$MYSQL_COLLATION]"
            echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET $MYSQL_CHARSET COLLATE $MYSQL_COLLATION;" >> "$tfile"
        else
            echo "[i] with character set: 'utf8' and collation: 'utf8_general_ci'"
            echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> "$tfile"
        fi

        if [ "$MYSQL_USER" != "" ]; then
            echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
            echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> "$tfile"
        fi
    fi

    /usr/bin/mariadbd --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < "$tfile"
    rm -f "$tfile"

    # only run if we have a starting MYSQL_DATABASE env variable AND
    # the /docker-entrypoint-initdb.d/ file is not empty
    if [ "$MYSQL_DATABASE" != "" ] && [ "$(ls -A /docker-entrypoint-initdb.d 2>/dev/null)" ]; then

        # start the server temporarily so that we can import seed files
        echo
        echo "Preparing to process the contents of /docker-entrypoint-initdb.d/"
        echo
        TEMP_OUTPUT_LOG=/tmp/mariadbd_output
        /usr/bin/mariadbd --user=mysql --skip-name-resolve --skip-networking=0 --silent-startup > "${TEMP_OUTPUT_LOG}" 2>&1 &
        PID="$!"
        
        # watch the output log until the server is running
        until tail "${TEMP_OUTPUT_LOG}" | grep -q "Version:"; do
            sleep 0.2
        done

        # use mysql client to import seed files while temp db is running
        # use the starting MYSQL_DATABASE so mysql knows where to import
        MYSQL_CLIENT="/usr/bin/mariadb -u root -p$MYSQL_ROOT_PASSWORD"
        
        # loop through all the files in the seed directory
        # redirect input (<) from .sql files into the mysql client command line
        # pipe (|) the output of using `gunzip -c` on .sql.gz files
        for f in /docker-entrypoint-initdb.d/*; do
            case "$f" in
                *.sql)    echo "  $0: running $f"; eval "${MYSQL_CLIENT} ${MYSQL_DATABASE} < $f"; echo ;;
                *.sql.gz) echo "  $0: running $f"; gunzip -c "$f" | eval "${MYSQL_CLIENT} ${MYSQL_DATABASE}"; echo ;;
            esac
        done

        # send the temporary mariadbd server a shutdown signal
        # and wait till it's done before completeing the init process
        kill -s TERM "${PID}"
        wait "${PID}"
        rm -f TEMP_OUTPUT_LOG
        echo "Completed processing seed files."
    fi;

    echo
    echo 'DB init process done. Ready for start up.'
    echo

    echo "exec /usr/bin/mariadbd --user=mysql --console --skip-name-resolve --skip-networking=0" "$@"
fi

# execute any pre-exec scripts
for i in /scripts/pre-exec.d/*sh
do
    if [ -e "${i}" ]; then
        echo "[i] pre-exec.d - processing $i"
        . "${i}"
    fi
done

exec /usr/bin/mariadbd --user=mysql --console --skip-name-resolve --skip-networking=0 "$@"