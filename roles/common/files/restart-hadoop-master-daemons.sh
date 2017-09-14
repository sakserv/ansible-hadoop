#!/bin/bash

source ${HADOOP_HOME}/env.sh

su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon stop resourcemanager"
su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon start resourcemanager"

su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon stop timelineserver"

su - yarn -c "${HADOOP_HOME}/bin/mapred --daemon stop historyserver"

su - hdfs -c "${HADOOP_HOME}/bin/hdfs --daemon stop namenode"
su - hdfs -c "${HADOOP_HOME}/bin/hadoop namenode -format -nonInteractive || true"
su - hdfs -c "${HADOOP_HOME}/bin/hdfs --daemon start namenode"

su - hdfs -c "${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /tmp/hadoop-yarn"
su - hdfs -c "${HADOOP_HOME}/bin/hdfs dfs -chown yarn:hadoop /tmp/hadoop-yarn"

su - yarn -c "${HADOOP_HOME}/bin/mapred --daemon start historyserver"
su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon start timelineserver"
