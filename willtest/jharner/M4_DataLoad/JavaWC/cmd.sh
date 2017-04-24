#!/usr/bin/env bash

export HADOOP_BASE=$HADOOP_MAPRED_HOME

hdfs dfs -rm -r -f wcjava
rm -r -f output

hdfs dfs -mkdir wcjava
hdfs dfs -put data wcjava/data

hadoop jar WordCount.jar WordCount wcjava/data wcjava/output 

hdfs dfs -get wcjava/output output

