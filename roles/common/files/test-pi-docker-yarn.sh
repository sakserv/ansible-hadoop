source env.sh
export YARN_EXAMPLES_JAR=./share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar
CNTR_ID="sakserv/docker-hadoop-build:hadoop-3.0.0-alpha2"
bin/yarn jar $YARN_EXAMPLES_JAR pi -Dmapreduce.map.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID" -Dyarn.app.mapreduce.am.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID" -Dmapreduce.reduce.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID" 4 10000
