FROM registry.docker-cn.com/library/centos:7

RUN yum -y install initscripts MAKEDEV

RUN yum check

RUN yum -y update && \
  yum -y install openssl && \
  yum -y install openssh-server && \
  yum -y install NetworkManager && \
  yum -y install net-tools

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

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
