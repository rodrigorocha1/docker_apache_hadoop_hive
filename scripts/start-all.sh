#!/bin/bash

source /scripts/setup-env.sh

echo "Iniciando daemons do HDFS..."
"$HADOOP_HOME/sbin/start-dfs.sh"

echo "Iniciando YARN..."
"$HADOOP_HOME/sbin/start-yarn.sh"

echo "Verificando serviços do Hadoop..."
jps

echo "Serviços do Hadoop iniciados com sucesso."
