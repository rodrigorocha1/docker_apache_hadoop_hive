#!/bin/bash

echo "Checando status serviços hadoop"
jps

echo "YARN ResourceManager status:"
curl -s http://localhost:8088/cluster

echo "HDFS NameNode status:"
curl -s http://localhost:50070/

echo "Checando HDFS file system..."
hdfs dfsadmin -report
