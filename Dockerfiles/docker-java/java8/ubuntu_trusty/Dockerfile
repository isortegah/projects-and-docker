FROM ubuntu:trusty

# maintainer details
MAINTAINER ISORTEGAH "isortegah@gmail.com"

RUN \
  apt-get update && \
  apt-get install -y software-properties-common python3-software-properties && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

RUN \
  apt-get purge -y

RUN \
  apt-get clean -y

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA_JRE /usr/lib/jvm/java-8-oracle/jre