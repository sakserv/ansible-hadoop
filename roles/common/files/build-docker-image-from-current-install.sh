#!/bin/bash

BUILD_DIR=/tmp/$(basename $0).$(date +%s)
HADOOP_INST_PATH=/usr/local/src/hadoop_install
DOCKER_IMAGE_NAME="hadoop-build:latest"

M2_TGZ="apache-maven-3.5.2-bin.tar.gz"
M2_DL="http://mirror.stjschools.org/public/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz"
M2_HOME=/usr/local/bin/apache-maven-3.5.2/
M2=$M2_HOME/bin

#if [ -d $BUILD_DIR ]; then
#  rm -rf $BUILD_DIR
#fi

#
# Copy the hadoop install
#
cp -Rp $HADOOP_INST_PATH/ $BUILD_DIR/

#
# Create mvn install script
#
cat << EOF > $BUILD_DIR/install_maven.sh
echo -e "\n#### Installing Maven"
cd /tmp
wget -N $M2_DL
tar -xzvf $M2_TGZ -C /usr/local/bin
export JAVA_HOME=$JAVA_HOME
$M2/mvn --version
EOF
chmod 755 $BUILD_DIR/install_maven.sh

#
# Create the Dockerfile
#
cat << EOF > $BUILD_DIR/Dockerfile
FROM centos:7

# User
USER root

# Update and install packages
RUN yum update -y && yum clean all
RUN yum install -y tar bzip2 yum-utils rpm-build java-1.8.0-openjdk-devel curl which tar sudo rsync bunzip2 wget gcc gcc-c++ autoconf automake libtool cmake zlib-devel openssl-devel && yum clean all

# Devel tools
RUN yum groupinstall "Development Tools" -y && yum clean all

# Update libselinux
RUN yum update -y libselinux && yum clean all

# Install maven
ENV MVN_BIN_PATH=$M2
ADD install_maven.sh /
RUN /install_maven.sh

# Protobuf
RUN curl -L https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz | tar -zxv -C /tmp
RUN cd /tmp/protobuf-2.5.0 && ./configure
RUN cd /tmp/protobuf-2.5.0 && make && make install
ENV LD_LIBRARY_PATH /usr/local/lib
ENV export LD_RUN_PATH /usr/local/lib

# Add Hadoop
ENV HADOOP_INST_PATH /usr/local/src/hadoop_install
ENV HADOOP_PREFIX $HADOOP_INST_PATH/hadoop
ENV HADOOP_COMMON_HOME $HADOOP_INST_PATH/hadoop
ENV HADOOP_HDFS_HOME $HADOOP_INST_PATH/hadoop
ENV HADOOP_MAPRED_HOME $HADOOP_INST_PATH/hadoop
ENV HADOOP_YARN_HOME $HADOOP_INST_PATH/hadoop
ENV HADOOP_CONF_DIR $HADOOP_INST_PATH/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_INST_PATH/etc/hadoop
ENV PATH $PATH:$HADOOP_INST_PATH:$HADOOP_INST_PATH/bin
ADD hadoop $HADOOP_INST_PATH/hadoop
EOF

#
# Build the image
#
cd $BUILD_DIR && docker build -t $DOCKER_IMAGE_NAME .
