#!/bin/bash

echo "Configurando variáveis de ambiente"

export NOME_ARQUIVO_HADOOP=hadoop-3.3.0.tar.gz
export URL_SITE_HADOOP=https://archive.apache.org/dist/hadoop/common/hadoop-3.3.0/
export URL_DOWNLOAD_HADOOP=${URL_SITE_HADOOP}${NOME_ARQUIVO_HADOOP}

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export HADOOP_HOME=/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

export HDFS_NAMENODE_USER=hadoop
export HDFS_DATANODE_USER=hadoop
export HDFS_SECONDARYNAMENODE_USER=hadoop
export YARN_RESOURCEMANAGER_USER=yarn
export YARN_NODEMANAGER_USER=yarn

echo "Variáveis de ambiente enviadas"
