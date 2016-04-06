source env.sh
export DSHELL_JAR=./share/hadoop/yarn/hadoop-yarn-applications-distributedshell-*.jar

yarn jar $DSHELL_JAR -shell_command "uptime" -jar $DSHELL_JAR -num_containers 1
