source env.sh
export DSHELL_JAR=$HADOOP_HOME/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-*.jar

su - hdpuser -c "yarn jar $DSHELL_JAR -shell_command 'sleep 60' -jar $DSHELL_JAR -num_containers 1"
