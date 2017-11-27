source env.sh
export YARN_EXAMPLES_JAR=./share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-*-tests.jar
bin/yarn jar $YARN_EXAMPLES_JAR sleep -m 1 -r 0 -mt 60000
