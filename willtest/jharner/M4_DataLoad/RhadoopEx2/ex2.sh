#!/usr/bin/env bash

# remove output from hdfs and the local filesystem
hdfs dfs -rm -r -f output
rm -rf output

hdfs dfs -put -f short.csv

hadoop jar $HADOOP_MAPRED_HOME/hadoop-streaming.jar \
  -files mapper.R,reducer.R \
  -inputformat org.apache.hadoop.mapred.lib.NLineInputFormat \
	-input short.csv -output output \
	-mapper mapper.R -reducer reducer.R

# get output from hdfs
hdfs dfs -get output
