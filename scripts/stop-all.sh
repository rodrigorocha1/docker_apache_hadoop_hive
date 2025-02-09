#!/bin/bash
set -e
source /scripts/setup-env.sh

echo "Parando YARN daemons..."
"$HADOOP_HOME/sbin/stop-yarn.sh"

echo "Parando HDFS daemons..."
"$HADOOP_HOME/sbin/stop-dfs.sh"

echo "Verificando se todos os serviços do Hadoop foram encerrados..."
jps

echo "Hadoop e Hive foram parados com sucesso."
