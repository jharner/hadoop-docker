#!/usr/bin/env bash

# remove output from hdfs and the local filesystem
hdfs dfs -rm -r -f output
rm -rf output

# load the data into hdfs
# for efficiency comment the following line after the first execution of this shell script
hdfs dfs -put -f short.csv

# run the hadoop job
hadoop jar $HADOOP_MAPRED_HOME/hadoop-streaming.jar \
  -files mapper.R \
  -inputformat org.apache.hadoop.mapred.lib.NLineInputFormat \
	-input short.csv -output output \
	-mapper mapper.R 

# get output from hdfs
hdfs dfs -get output

