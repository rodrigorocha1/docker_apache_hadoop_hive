#!/bin/bash

source /scripts/setup-env.sh

echo "Baixando Hadoop ..."

# wget $URL_DOWNLOAD_HADOOP -P /opt

# if [$? -ne 0 ]; then
#     echo "Falha ao baixar arquivo do site do hadoop."
#     exit 1
# fi
# echo "Download feito com sucesso"
# echo "Configuração caminho Hadoop"

tar -xvzf /opt/$NOME_ARQUIVO_HADOOP -C /
mv /hadoop-3.3.0/* /hadoop/

VERSAO_HADOOP=$(echo "$NOME_ARQUIVO_HADOOP" | sed 's/.tar.gz//')

mv /$VERSAO_HADOOP /hadoop

mkdir -p /hadoop/{datanode,namenode}

echo "Hadoop instalado com sucesso"
