source env.sh

# JAR
export YARN_EXAMPLES_JAR=./share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar

# ENV Vars
CNTR_ID="hadoop-build:latest"
MAP_ENV="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID,YARN_CONTAINER_RUNTIME_DOCKER_MOUNTS='/tmp:/newtmp:rw,/etc/passwd:/tmp/passwd:ro'"
REDUCE_ENV="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID,YARN_CONTAINER_RUNTIME_DOCKER_MOUNTS='/tmp:/newtmp:rw,/etc/passwd:/tmp/passwd:ro'"
AM_ENV="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$CNTR_ID,YARN_CONTAINER_RUNTIME_DOCKER_MOUNTS='/tmp:/newtmp:rw,/etc/passwd:/tmp/passwd:ro'"

# Run PI job
bin/yarn jar $YARN_EXAMPLES_JAR pi \
	-Dmapreduce.map.env="$MAP_ENV" \
	-Dyarn.app.mapreduce.am.env="$AM_ENV" \
	-Dmapreduce.reduce.env="$REDUCE_ENV" \
	1 40000
