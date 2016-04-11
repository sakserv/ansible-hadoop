#!/bin/bash

source ${HADOOP_HOME}/env.sh

su - yarn -c "${HADOOP_HOME}/sbin/yarn-daemon.sh start nodemanager"
