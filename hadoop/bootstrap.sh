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
	rm -rf /hadoop-data/*
	echo "running namenode init"
	/usr/local/hadoop/bin/hdfs namenode -format
	CREATEDIR=1
fi

service sshd start
$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh

#add hadoop bin directory to path
PATH=/usr/local/hadoop/bin:$PATH
#if we initialized namenode's file system, create default paths
if [[ $CREATEDIR == 1 ]]; then
	sleep 2
	echo "creating hdfs directory structure"
	for aPath in /tmp /user/rstudio; do
		hdfs dfs -test -d hdfs://127.0.0.1:9000/$aPath
		if [ $? == 1 ]; then
			hdfs dfs -mkdir -p $aPath
			hdfs dfs -chown rstudio:rstudio $aPath
			hdfs dfs -chmod 777 $aPath
		fi
	done
	echo "hdfs setup complete"
fi

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
