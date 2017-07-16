#!/bin/bash

BUILD_DIR=/tmp/$(basename $0).$(date +%s)
HADOOP_INST_PATH=/usr/local/src/hadoop_install
DOCKER_IMAGE_NAME="hadoop-build:latest"

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
wget -N http://apache.cs.utah.edu/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
tar -xzvf apache-maven-3.5.0-bin.tar.gz -C /usr/local/bin
export M2_HOME=/usr/local/bin/apache-maven-3.5.0/
export M2=$M2_HOME/bin
export JAVA_HOME=$JAVA_HOME
export PATH=$PATH:$M2:$JAVA_HOME/bin
echo "export PATH=$PATH:$M2:$JAVA_HOME/bin" >>/etc/profile
. /etc/profile
mvn --version
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
ENV MVN_BIN_PATH=/usr/local/bin/apache-maven-3.5.0/bin
ADD install_maven.sh /
RUN /install_maven.sh

# Protobuf
RUN curl -L https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz | tar -zxv -C /tmp
RUN cd /tmp/protobuf-2.5.0 && ./configure
RUN cd /tmp/protobuf-2.5.0 && make && make install
ENV LD_LIBRARY_PATH /usr/local/lib
ENV export LD_RUN_PATH /usr/local/lib

# Add Hadoop
ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ADD hadoop /usr/src
EOF

#
# Build the image
#
cd $BUILD_DIR && docker build -t $DOCKER_IMAGE_NAME .
