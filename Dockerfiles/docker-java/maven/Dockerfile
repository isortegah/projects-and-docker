FROM openjdk:alpine

MAINTAINER ISORTEGAH <isortegah@gmail.com>

RUN apk add --no-cache --update curl nmap tar ca-certificates wget maven bash \                                                                                                                                                                                                      
    &&   update-ca-certificates     \
    && rm -rf /var/cache/apk/*

ENV MAVEN_VERSION=3.5.2

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

ENV MAVEN_HOME /usr/lib/mvn
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $MAVEN_HOME/bin:$PATH

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh"]