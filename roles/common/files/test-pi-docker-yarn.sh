source env.sh
export YARN_EXAMPLES_JAR=./share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar
bin/yarn jar $YARN_EXAMPLES_JAR pi -Dmapreduce.map.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=centos" -Dyarn.app.mapreduce.am.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=centos" -Dmapreduce.reduce.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=centos" 4 10000
