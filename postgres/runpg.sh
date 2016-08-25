#!/bin/bash

DATA="/opt/data"
PGDATA="${DATA}/pg-data"
PGVersion="9.4"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

sleep 6

if ! [ -d "$PGDATA/base" ]; then
	echo "$PGDATA does not exist. creating database"
	/usr/lib/postgresql/9.4/bin/initdb -D $PGDATA
	service postgresql start
	psql --command "CREATE USER rstudio"
	createdb -O rstudio rstudio
	psql --command "CREATE USER hive"
	createdb -O hive hive
	createdb -O rstudio example
	for file in $DATA/pg-example/*.sql; do
		cat $file | psql -U rstudio example >/dev/null
	done
	psql --command "GRANT ALL PRIVILEGES ON DATABASE example TO rstudio"
	cd /usr/share/postgresql/9.4
	service postgresql stop
fi


/usr/bin/pg_ctlcluster ${PGVersion} main start --foreground
