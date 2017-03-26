FROM ubuntu:latest
RUN \
  apt-get update && apt-get install -y  git curl wget vim mysql-client && \
  apt-get install -y --no-install-recommends apt-utils && \
  apt-get install -y python python-pip  python-virtualenv python-lxml python-crypto && \
  apt-get install -y python-cssselect python-openssl python-w3lib python-twisted python-dev libxml2-dev  && \
  apt-get install -y libxslt1-dev zlib1g-dev libffi-dev libssl-dev git && \
  apt-get install -y libmysqlclient-dev && \
  rm -rf /var/lib/apt/lists/*


# Python基本環境セットアップ

RUN apt-get install -y python-setuptools
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python

# 言語設定

# RUN apt-get install language-pack-ja
RUN apt-get install locales
RUN locale-gen ja_JP.UTF-8  
ENV LANG=ja_JP.UTF-8  
ENV LANGUAGE=ja_JP:ja  
ENV LC_ALL=ja_JP.UTF-8

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD requirements.txt $APP_HOME/
# pipインストール

RUN pip install -r "requirements.txt"


# - - -
USER root 
RUN apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*


