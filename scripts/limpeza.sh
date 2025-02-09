#!/bin/bash

source /scripts/setup-env.sh

echo "limpando Logs"

rm -rf $HADOOP_HOME/logs/*

echo "Limpando arquivos temporarios"
rm -rf /tmp/*

echo "limpesa concluida"
