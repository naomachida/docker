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
  yum -y install java-1.7.0-openjdk-devel && \
  yum -y install subversion


RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# 鍵作成
RUN ls -la /etc/ssh
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN ls -la /etc/ssh

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
ENV CATALINA_OPTS="-Duser.language=ja -Duser.country=JP -Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m"

# tomcat環境変数
ENV CATALINA_HOME /var/lib/tomcat7

# svnよりwarをダウンロード、配備する
RUN mkdir /war
RUN svn co https://117.107.207.117/projects/standard_ilc/trunk/war/ --username nao_machida --password H6bdMeP4 --no-auth-cache /war/  <<<"t"
RUN ls -la /war
RUN cp /war/*.war /var/lib/tomcat7/webapps/
RUN ls -la /var/lib/tomcat7/webapps

# oracle instant client インストール
RUN svn co https://117.107.207.117/projects/standard_ilc/trunk/orc/ --username nao_machida --password H6bdMeP4 --no-auth-cache /tmp/  <<<"t"
RUN ls -la /tmp

RUN yum install -y libaio
RUN rpm -ivh /tmp/oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm && \
    rpm -ivh /tmp/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm

RUN mkdir -p ~/oracle/network/admin
ADD tnsnames.ora ~/oracle/network/admin/
ENV TNS_ADMIN=~/oracle/network/admin
ENV ORACLE_HOME=/usr/lib/oracle/11.2/client64
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/lib/oracle/11.2/client64/lib/
ENV NLS_LANG Japanese_Japan.AL32UTF8
ENV NLS_DATE_FORMAT 'YYYY/MM/DD HH24:MI:SS'

# sqlldr imp exp インストール
RUN cp /tmp/imp /usr/lib/oracle/11.2/client64/bin
RUN cp /tmp/exp /usr/lib/oracle/11.2/client64/bin
RUN cp /tmp/sqlldr /usr/lib/oracle/11.2/client64/bin
RUN mkdir -p /usr/lib/oracle/11.2/client64/rdbms
RUN cp -r /tmp/mesg /usr/lib/oracle/11.2/client64/rdbms/

RUN chmod +x /usr/lib/oracle/11.2/client64/bin/exp
RUN chmod +x /usr/lib/oracle/11.2/client64/bin/imp
RUN chmod +x /usr/lib/oracle/11.2/client64/bin/sqlldr

EXPOSE 22
EXPOSE 8080

CMD /var/lib/tomcat7/bin/catalina.sh run
