#!/usr/bin/env bash
set -x
 
HADOOP_STREAMING_JAR=/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming.jar
OUT_DIR=my_hdfs_output

hdfs dfs -rm -r $OUT_DIR
 
yarn jar $HADOOP_STREAMING_JAR \
    -mapper "wc -l" \
    -numReduceTasks 0 \
    -input /data/wiki/en_articles_part \
    -output $OUT_DIR
 
echo $?
