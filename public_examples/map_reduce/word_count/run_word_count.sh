#!/usr/bin/env bash
set -x

HADOOP_STREAMING_JAR=/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming.jar
HDFS_OUTPUT_DIR=word_count

hdfs dfs -rm -r -skipTrash $HDFS_OUTPUT_DIR

yarn jar $HADOOP_STREAMING_JAR \
        -files mapper.py,reducer.py \
        -mapper 'python3 mapper.py' \
        -reducer 'python3 reducer.py' \
        -input /data/wiki/en_articles_part \
        -output $HDFS_OUTPUT_DIR

echo $?
