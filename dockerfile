# Use uma imagem base do Ubuntu
FROM ubuntu:20.04

# Defina as variáveis de ambiente
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/root/hadoop/hadoop-3.3.0
ENV PATH=$PATH:$HADOOP_HOME/bin
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# Atualize o índice de pacotes e instale dependências essenciais
RUN apt update && apt install -y \
    wget \
    curl \
    ssh \
    openjdk-8-jdk \
    openssh-server \
    vim \
    bash-completion \
    && apt clean

# Verifique a versão do Java
RUN java -version

# Baixe o Hadoop 3.3.0
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz \
    && mkdir -p /root/hadoop \
    && tar -xvzf hadoop-3.3.0.tar.gz -C /root/hadoop \
    && rm hadoop-3.3.0.tar.gz

# Configure SSH para executar sem senha
RUN ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 0600 /root/.ssh/authorized_keys

# Instalar e iniciar o serviço SSH
RUN service ssh start

# Configure o Hadoop para a operação pseudo-distribuída
RUN echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc \
    && echo "export HADOOP_HOME=$HADOOP_HOME" >> ~/.bashrc \
    && echo "export PATH=\$PATH:\$HADOOP_HOME/bin" >> ~/.bashrc \
    && echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> ~/.bashrc \
    && source ~/.bashrc

# Configure os arquivos do Hadoop
RUN echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
    <configuration>\n\
    <property>\n\
    <name>fs.defaultFS</name>\n\
    <value>hdfs://localhost:9000</value>\n\
    </property>\n\
    </configuration>" > $HADOOP_HOME/etc/hadoop/core-site.xml

RUN echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
    <configuration>\n\
    <property>\n\
    <name>dfs.replication</name>\n\
    <value>1</value>\n\
    </property>\n\
    </configuration>" > $HADOOP_HOME/etc/hadoop/hdfs-site.xml

RUN echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
    <configuration>\n\
    <property>\n\
    <name>mapreduce.framework.name</name>\n\
    <value>yarn</value>\n\
    </property>\n\
    <property>\n\
    <name>mapreduce.application.classpath</name>\n\
    <value>\$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:\$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>\n\
    </property>\n\
    </configuration>" > $HADOOP_HOME/etc/hadoop/mapred-site.xml

RUN echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
    <configuration>\n\
    <property>\n\
    <name>yarn.nodemanager.aux-services</name>\n\
    <value>mapreduce_shuffle</value>\n\
    </property>\n\
    <property>\n\
    <name>yarn.nodemanager.env-whitelist</name>\n\
    <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>\n\
    </property>\n\
    </configuration>" > $HADOOP_HOME/etc/hadoop/yarn-site.xml

# Formatar o NameNode
RUN $HADOOP_HOME/bin/hdfs namenode -format

# Iniciar o Hadoop DFS
RUN $HADOOP_HOME/sbin/start-dfs.sh

# Iniciar o YARN
RUN $HADOOP_HOME/sbin/start-yarn.sh

# Verifique os processos em execução
RUN jps

# Exponha a porta para o portal YARN
EXPOSE 8088

# Comando padrão para manter o contêiner em execução
CMD tail -f /dev/null
