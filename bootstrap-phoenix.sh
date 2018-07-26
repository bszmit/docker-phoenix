#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}
: ${ZOO_HOME:=/usr/local/zookeeper}
: ${HBASE_HOME:=/usr/local/hbase}

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

service sshd start
$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh
$ZOO_HOME/bin/zkServer.sh start
$HBASE_HOME/bin/start-hbase.sh

INIT_FILE=/etc/listtables.sql
if [[ $1 == "-init" ]]; then
    INIT_FILE=$2
fi

/usr/local/phoenix/bin/sqlline.py 127.0.0.1:2181 $INIT_FILE
echo "Container started..."
while true; do sleep 1000; done 

