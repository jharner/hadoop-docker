#!/bin/sh

#while true; do sleep 1000; done

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export HIVE_HOME=/opt/hive
export HADOOP_HOME=/opt/hadoop 

until psql -h postgres -U hive -c 'select 1' >/dev/null 2>&1; do
	>2& echo "waiting on postgres"
	sleep 4
done

sleep 30

if [ ! -e /opt/hive.schema.inited ]; then
	echo "initing hive schema"
	su -lc "/opt/hive/bin/schematool -initSchema -dbType postgres" rstudio
	touch /opt/hive.schema.inited
	/opt/hive/bin/hive -S -e "create database if not exists rstudio;"
fi

/opt/hadoop/bin/hdfs dfs -chown -R rstudio:rstudio /user/hive

echo "starrting hiveserver2"

su -lc /opt/hive/bin/hiveserver2 rstudio
