#!/bin/sh

#while true; do sleep 1000; done

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export HIVE_HOME=/opt/hive
export HADOOP_HOME=/opt/hadoop 

until psql -h postgres -U hive -c 'select 1' >/dev/null 2>&1; do
	>2& echo "waiting on postgres"
	sleep 2
done

if [ ! -e /opt/hive.schema.inited ]; then
	echo "initing hive schema"
	/opt/hive/bin/schematool -initSchema -dbType postgres
	touch /opt/hive.schema.inited
fi

echo "starrting hiveserver2"

/opt/hive/bin/hiveserver2
