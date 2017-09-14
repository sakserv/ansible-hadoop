#!/bin/bash

source ${HADOOP_HOME}/env.sh

su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon stop nodemanager"
su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon start nodemanager"

su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon stop resourcemanager"
su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon start resourcemanager"

su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon stop timelineserver"
su - yarn -c "${HADOOP_HOME}/bin/yarn --daemon start timelineserver"
