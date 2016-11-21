#!/bin/bash

HDFS_BIN=/usr/local/src/hadoop_install/hadoop/bin/hdfs

#
# Checks
#
if [ $# -ne 1 ]; then
  echo "ERROR: Must supply absolute path to hdfs destination"
  exit 1
fi
HDFS_DEST="$1"

if ! echo $HDFS_DEST | grep -q 'config.json'; then
  echo "ERROR: Must supply absolute path to hdfs destination"
  exit 1
fi

#
# Main
#

echo "Running docker login, enter credentials"
docker login

echo "Creating HDFS directory"
sudo -E -u hdfs $HDFS_BIN dfs -mkdir $(dirname $HDFS_DEST)
sudo -E -u hdfs $HDFS_BIN dfs -chmod 777 $(dirname $HDFS_DEST)

echo "Copying the docker config to $HDFS_DEST"
hdfs dfs -put $HOME/.docker/config.json $HDFS_DEST

exit 0
