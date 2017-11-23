FROM ubuntu:xenial

MAINTAINER ISORTEGA <iortegah@gmail.com>

RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
RUN export JAVA_HOME
RUN export PATH