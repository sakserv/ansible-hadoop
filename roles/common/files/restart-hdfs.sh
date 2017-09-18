#!/bin/bash

source ${HADOOP_HOME}/env.sh

su - hdfs -c "${HADOOP_HOME}/sbin/hadoop-daemon.sh stop datanode"
su - hdfs -c "${HADOOP_HOME}/sbin/hadoop-daemon.sh stop namenode"

su - hdfs -c "${HADOOP_HOME}/sbin/hadoop-daemon.sh start namenode"
su - hdfs -c "${HADOOP_HOME}/sbin/hadoop-daemon.sh start datanode"
