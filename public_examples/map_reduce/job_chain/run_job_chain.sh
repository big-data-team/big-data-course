#!/usr/bin/env bash
set -x

HADOOP_STREAMING_JAR=/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming.jar
HDFS_OUTPUT_DIR="streaming_wc_result"
NUM_REDUCERS=8

hdfs dfs -rm -r -skipTrash ${HDFS_OUTPUT_DIR}*

# Wordcount
( yarn jar $HADOOP_STREAMING_JAR \
    -D mapreduce.job.name="Streaming WordCount. Phase 1" \
    -files count_mapper.py,sum_reducer.py \
    -mapper 'python3 count_mapper.py' \
    -reducer 'python3 sum_reducer.py' \
    -input /data/wiki/en_articles_part \
    -output ${HDFS_OUTPUT_DIR}_tmp &&

# useful flags
# complex key
    # -D mapreduce.map.output.key.field.separator=. \
    # -D stream.num.map.output.key.fields=2 \
    # -combiner cat \
    # -D stream.num.reduce.output.key.fields=2 \
# partitioner
    # -D mapreduce.partition.keypartitioner.options=-k2.1,2.1 \
    # -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner \
# comparator
    # -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
    # -D mapreduce.partition.keycomparator.options="-k1,1nr -k2,2" \
# bad practice
    # -D stream.map.output.field.separator=. \

# Global sorting as we use only 1 reducer
yarn jar $HADOOP_STREAMING_JAR \
    -D mapreduce.job.name="Streaming WordCount. Phase 2" \
    -mapper cat \
    -reducer cat \
    -numReduceTasks 1 \
    -input ${HDFS_OUTPUT_DIR}_tmp \
    -output ${HDFS_OUTPUT_DIR} 
) || echo "Error happens"

hdfs dfs -rm -r -skipTrash ${HDFS_OUTPUT_DIR}_tmp

hdfs dfs -cat ${HDFS_OUTPUT_DIR}/* | head -15

echo $?
