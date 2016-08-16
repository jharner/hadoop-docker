#!/bin/bash

PGVersion=$1

if [ -z "$PGVersion" ]; then
	echo "postgres version not specified"
	exit 1
fi

PGDATA="/opt/pgdata"

#eventually we'll need to check schema version number via metadata table
if ! [ -d "$PGDATA/base" ]; then
	echo "$PGDATA does not exist. creating database"
	/usr/lib/postgresql/9.4/bin/initdb -D $PGDATA
	service postgresql start
	psql --command "CREATE USER rstudio"
	createdb -O rstudio rstudio
	cd /usr/share/postgresql/9.4
	service postgresql stop
fi


/usr/bin/pg_ctlcluster ${PGVersion} main start --foreground
