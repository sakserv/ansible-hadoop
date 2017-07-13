source env.sh
export DSHELL_JAR=./share/hadoop/yarn/hadoop-yarn-applications-distributedshell-*.jar

yarn jar $DSHELL_JAR -shell_env YARN_CONTAINER_RUNTIME_TYPE=docker -shell_env YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=centos -shell_env YARN_CONTAINER_RUNTIME_DOCKER_MOUNTS='/tmp:/newtmp:rw,/etc/passwd:/tmp/passwd:ro' -shell_command "sleep 60" -jar $DSHELL_JAR -num_containers 1
