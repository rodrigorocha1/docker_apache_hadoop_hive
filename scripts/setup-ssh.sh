#!/bin/bash

source /scripts/setup-env.sh

echo "Configurando SSH ...."

ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa &&
    cat /root/.ssh/id_rsa.pub >>/root/.ssh/authorized_keys &&
    chmod 0600 /root/.ssh/authorized_keys

service ssh start
