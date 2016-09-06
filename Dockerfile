FROM centos:6.6
MAINTAINER Hans Chan <icsbun@gmail.com>
LABEL Description="CentOS6.6 with gcc4.7.2, java7 and git" Version="1.0"

# yum install dependences, -y for YES
RUN yum -y upgrade
# RUN yum groupinstall -y 'Development Tools'
RUN yum install -y tar \
                   wget \
                   git \
                   gcc-c++

####
# Install java
# https://github.com/Mashape/docker-java8/blob/master/Dockerfile
####
# latest java-1.7.0_111
# RUN  yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel

ENV JAVA_VERSION 7u45
ENV BUILD_VERSION b18

# Download
RUN wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" \
    -O /tmp/jdk.rpm

# Install
RUN yum -y install /tmp/jdk.rpm
RUN alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000

ENV JAVA_HOME /usr/java/latest
RUN rm /tmp/jdk.rpm


####
# Update gcc to 4.7.2
# http://www.wengweitao.com/centos-sheng-ji-gcc-he-g-de-fang-fa.html
####
# docker 每次 RUN 完不会记住当前状态，所以 cd 和 wget 要在同一条 RUN 中运行
RUN cd /etc/yum.repos.d && \
    wget https://people.centos.org/tru/devtools-1.1/devtools-1.1.repo
RUN yum --enablerepo=testing-1.1-devtools-6 install -y devtoolset-1.1-gcc devtoolset-1.1-gcc-c++
RUN ln -s /opt/centos/devtoolset-1.1/root/usr/bin/* /usr/local/bin/
RUN hash -r

# ####
# # Update gcc to 4.8.2
# # http://www.51bbo.com/archives/2228
# ####
# RUN cd /etc/yum.repos.d && \
#     wget http://people.centos.org/tru/devtools-2/devtools-2.repo
# RUN yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++
# RUN mv /usr/bin/gcc /usr/bin/gcc-4.4.7
# RUN mv /usr/bin/g++ /usr/bin/g++-4.4.7
# RUN mv /usr/bin/c++ /usr/bin/c++-4.4.7
# RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/gcc /usr/bin/gcc
# RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/c++ /usr/bin/c++
# RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/g++ /usr/bin/g++

####
# install nvm
####
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash
RUN source $HOME/.bashrc
