#!/bin/bash

/opt/oozie/bin/oozie-setup.sh db create -run
/opt/oozie/bin/oozied.sh start
/opt/oozie/bin/oozie-setup.sh sharelib create -fs hdfs://namenode oozie-sharelib-5.2.1.tar.gz
/opt/hadoop/bin/hdfs dfs -mkdir  hdfs://namenode/user/hadoop
/opt/hadoop/bin/hdfs dfs -put examples  hdfs://namenode/user/hadoop/

echo "OOZIE initialized"
tail -f /opt/oozie/logs/oozie.log