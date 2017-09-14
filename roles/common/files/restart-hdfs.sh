#!/bin/bash

source ${HADOOP_HOME}/env.sh

su - hdfs -c "${HADOOP_HOME}/bin/hdfs --daemon stop datanode"
su - hdfs -c "${HADOOP_HOME}/bin/hdfs --daemon stop namenode"

su - hdfs -c "${HADOOP_HOME}/bin/hdfs --daemon start namenode"
su - hdfs -c "${HADOOP_HOME}/bin/hdfs --daemon start datanode"
