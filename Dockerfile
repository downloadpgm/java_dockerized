FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=US/Central

RUN apt-get update && apt-get install -y supervisor openssh-server openssh-client vim iputils-ping python

WORKDIR /usr/local

# git clone https://github.com/mkenjis/apache_binaries
ADD jre-8u181-linux-x64.tar.gz .

WORKDIR /root
RUN echo "" >>.bashrc \
 && echo 'export JAVA_HOME=/usr/local/jre1.8.0_181' >>.bashrc \
 && echo 'export CLASSPATH=$JAVA_HOME/lib' >>.bashrc \
 && echo 'export PATH=$PATH:.:$JAVA_HOME/bin' >>.bashrc \
 && echo "" >>.bashrc

# creates ssh private and public keys,
# and creates authorized_keys to enable containers connect to each other via passwordless ssh
RUN /usr/bin/bash -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y 2>&1 >/dev/null" \
 && cp .ssh/id_rsa.pub .ssh/authorized_keys


