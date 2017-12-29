FROM registry.docker-cn.com/library/centos:7

RUN yum -y install initscripts MAKEDEV

RUN yum check

RUN yum -y update && \
  yum -y install openssl && \
  yum -y install openssh-server && \
  yum -y install NetworkManager && \
  yum -y install net-tools && \
  yum -y install wget && \
  yum -y install java-1.7.0-openjdk && \
  yum -y install java-1.7.0-openjdk-devel


# 空パスワードの場合は以下をコメントアウト
#RUN sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config

RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# 鍵作成
RUN ls -la /etc/ssh
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN ls -la /etc/ssh

# 空パスワードの場合は以下をコメントアウト
#RUN passwd -d root

# 任意のパスワードの場合は以下をコメントアウト & パスワードを書き換える
RUN echo 'root:123456' | chpasswd

# java環境変数
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.161-2.6.12.0.el7_4.x86_64
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH .:$JAVA_HOME/lib:$JRE_HOME/lib
ENV PATH $PATH:$JAVA_HOME/bin

# tomcatインストール
RUN wget -P /tmp http://mirror.bit.edu.cn/apache/tomcat/tomcat-7/v7.0.82/bin/apache-tomcat-7.0.82.tar.gz
RUN tar xzf /tmp/apache-tomcat-7.0.82.tar.gz -C /var/lib
RUN mv /var/lib/apache-tomcat-7.0.82 /var/lib/tomcat7
RUN rm -rf /tmp/apache-tomcat-7.0.82.tar.gz

# tomcatメモリ設定
RUN sed -i '2iexport CATALINA_OPTS="-Duser.language=ja -Duser.country=JP -Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m"' /var/lib/tomcat7/bin/startup.sh

# tomcat環境変数
ENV CATALINA_HOME /var/lib/tomcat7

EXPOSE 22
EXPOSE 8080

CMD /var/lib/tomcat7/bin/catalina.sh run
