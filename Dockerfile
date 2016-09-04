FROM centos:6.6
MAINTAINER Hans Chan <icsbun@gmail.com>
LABEL Description="CentOS6.6 with gcc4.7.2, java7 and git, " Version="1.0"

# yum install dependences, -y for YES
# RUN yum groupinstall -y 'Development Tools'
RUN yum install -y tar \
                   wget \
                   git \
                   gcc-c++ \
                   java-1.7.0-openjdk \
                   java-1.7.0-openjdk-devel

# Update gcc to 4.7.2
# http://www.wengweitao.com/centos-sheng-ji-gcc-he-g-de-fang-fa.html
# docker 每次 RUN 完不会记住当前状态，所以 cd 和 wget 要在同一条 RUN 中运行
RUN cd /etc/yum.repos.d && \
    wget https://people.centos.org/tru/devtools-1.1/devtools-1.1.repo
RUN yum --enablerepo=testing-1.1-devtools-6 install -y devtoolset-1.1-gcc devtoolset-1.1-gcc-c++
RUN ln -s /opt/centos/devtoolset-1.1/root/usr/bin/* /usr/local/bin/
RUN hash -r

# # Update gcc to 4.8.2
# # http://www.51bbo.com/archives/2228
# RUN cd /etc/yum.repos.d && \
#     wget http://people.centos.org/tru/devtools-2/devtools-2.repo
# RUN yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++
# RUN mv /usr/bin/gcc /usr/bin/gcc-4.4.7
# RUN mv /usr/bin/g++ /usr/bin/g++-4.4.7
# RUN mv /usr/bin/c++ /usr/bin/c++-4.4.7
# RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/gcc /usr/bin/gcc
# RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/c++ /usr/bin/c++
# RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/g++ /usr/bin/g++

# install nvm
# RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.6/install.sh | bash
