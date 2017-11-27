source env.sh
export YARN_EXAMPLES_JAR=./share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-*-tests.jar
CNTR_ID="hadoop-build:latest"
bin/yarn jar $YARN_EXAMPLES_JAR sleep -Dmapreduce.map.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID" -Dyarn.app.mapreduce.am.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID" -Dmapreduce.reduce.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID" sleep -m 1 -r 0 -mt 60000
