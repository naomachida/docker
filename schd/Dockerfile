FROM registry.docker-cn.com/library/centos:7

RUN yum -y install initscripts MAKEDEV

RUN yum check

RUN yum -y update && \
  yum -y install java-1.7.0-openjdk && \
  yum -y install java-1.7.0-openjdk-devel && \
  yum -y install subversion && \
  yum -y install crontabs && \
  yum -y install mailx && \
  yum -y install postfix

# タイムゾーンをCSTへ
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 
RUN sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond

# cron
RUN mkdir /app
ADD schd/test.sh /app/
ADD schd/test_Dat1.sql /app/
ADD schd/test_SP2.sql /app/
ADD schd/vendor.ctl /app/
RUN chmod 744 /app/test.sh
RUN chmod 744 /app/test_Dat1.sql
RUN chmod 744 /app/test_SP2.sql
RUN chmod 744 /app/vendor.ctl
RUN ls -la /app

RUN echo '*/1 * * * * /app/test.sh >> /tmp/cron.log 2>>/tmp/error.log' >> /var/spool/cron/root

# java環境変数
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.161-2.6.12.0.el7_4.x86_64
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH .:$JAVA_HOME/lib:$JRE_HOME/lib
ENV PATH $PATH:$JAVA_HOME/bin

# oracle instant client インストール
RUN svn co https://117.107.207.117/projects/standard_ilc/trunk/orc/ --username nao_machida --password H6bdMeP4 --no-auth-cache /tmp/  <<<"t"
#RUN svn co https://192.168.1.120/projects/standard_ilc/trunk/orc/ --username nao_machida --password H6bdMeP4 --no-auth-cache /tmp/  <<<"t"
RUN ls -la /tmp

RUN yum install -y libaio
RUN rpm -ivh /tmp/oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm && \
    rpm -ivh /tmp/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm

RUN mkdir -p /root/oracle/network/admin
ADD tnsnames.ora /root/oracle/network/admin/
RUN ls /root/oracle/network/admin/
ENV TNS_ADMIN=/root/oracle/network/admin
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

# MTAをpostfixへ変更
RUN alternatives --set mta /usr/sbin/sendmail.postfix

CMD /usr/sbin/postfix start && crond && tail -f /dev/null
