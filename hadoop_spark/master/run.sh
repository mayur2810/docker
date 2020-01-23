#!/bin/bash

service ssh start
sleep 2
ssh -C2qTnNf -o StrictHostKeyChecking=no -D 0.0.0.0:9999 localhost
echo "started ssh server and invoked ssh tunnel daemon"

namedir=`echo $HDFS_CONF_dfs_namenode_name_dir | perl -pe 's#file://##'`
if [ ! -d $namedir ]; then
  echo "Namenode name directory not found: $namedir"
  exit 2
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit 2
fi

if [ "`ls -A $namedir`" == "" ]; then
  echo "Formatting namenode name directory: $namedir"
  $HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME 
fi

$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR namenode &
$HADOOP_PREFIX/bin/yarn --config $HADOOP_CONF_DIR resourcemanager &
$HADOOP_PREFIX/bin/yarn --config $HADOOP_CONF_DIR historyserver

