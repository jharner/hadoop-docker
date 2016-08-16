#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

if [[ ! -d /hadoop-data/ ]]; then
	echo "hadoop data directory missing"
	exit 1
fi

CREATEDIR=0
if [[ ! -d /hadoop-data/nn ]]; then
	rm -rf /hadoop-data/dfs
	/usr/local/hadoop/bin/hdfs namenode -format 
	CREATEDIR=1
fi

service sshd start
$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh

if [[ CREATEDIR ]]; then
	sleep 5
	echo "creating hdfs:/user/rstudio"
	/usr/local/hadoop/bin/hdfs dfs -mkdir /user
	/usr/local/hadoop/bin/hdfs dfs -mkdir /user/rstudio
	/usr/local/hadoop/bin/hdfs dfs -chown rstudio:rstudio /user/rstudio
fi

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
