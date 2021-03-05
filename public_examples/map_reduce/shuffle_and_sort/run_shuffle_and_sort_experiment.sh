#!/usr/bin/env bash
set -x

HADOOP_STREAMING_JAR=/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming.jar
HDFS_OUTPUT_DIR="shuffle_and_sort_experiment"

hdfs dfs -rm -r -skipTrash ${HDFS_OUTPUT_DIR}*

# bad practice
    # -D stream.map.output.field.separator=. \
# best practice
    # -D mapreduce.map.output.key.field.separator=. \
    # -D stream.num.map.output.key.fields=2 \
    # -combiner cat \
    # -D stream.num.reduce.output.key.fields=2 \
yarn jar $HADOOP_STREAMING_JAR \
    -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
    -D mapreduce.partition.keycomparator.options="-k1,1nr -k2,2" \
    -D mapreduce.partition.keypartitioner.options=-k2.1,2.1 \
    -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner \
    -mapper cat \
    -reducer cat \
    -numReduceTasks 2 \
    -input user_profiles \
    -output ${HDFS_OUTPUT_DIR}

hdfs dfs -ls ${HDFS_OUTPUT_DIR}
echo ""
hdfs dfs -text ${HDFS_OUTPUT_DIR}/*0 | head
echo ""
hdfs dfs -text ${HDFS_OUTPUT_DIR}/*1 | head

echo $?
