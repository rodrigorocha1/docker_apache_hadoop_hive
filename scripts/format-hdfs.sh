#!/bin/bash

set -e

source /scripts/setup-env.sh

echo "Formatando HDFS..."
"$HADOOP_HOME/bin/hdfs" namenode -format

echo "Formatação do HDFS concluída."
sleep 5
