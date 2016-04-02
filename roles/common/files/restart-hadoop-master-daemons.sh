#!/bin/bash

source ${HADOOP_HOME}/env.sh

su - yarn -c "${HADOOP_HOME}/sbin/yarn-daemon.sh stop resourcemanager"
su - yarn -c "${HADOOP_HOME}/sbin/yarn-daemon.sh start resourcemanager"

su - yarn -c "${HADOOP_HOME}/sbin/mr-jobhistory-daemon.sh stop historyserver"

su - hdfs -c "${HADOOP_HOME}/sbin/hadoop-daemon.sh stop namenode"
su - hdfs -c "${HADOOP_HOME}/bin/hadoop namenode -format -nonInteractive || true"
su - hdfs -c "${HADOOP_HOME}/sbin/hadoop-daemon.sh start namenode"

su - yarn -c "${HADOOP_HOME}/sbin/mr-jobhistory-daemon.sh start historyserver"
