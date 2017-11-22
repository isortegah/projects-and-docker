FROM openjdk:alpine

ENV SBT_VERSION 0.13.15
ENV SCALA_VERSION 2.12.0
ENV SCALA_HOME /usr/local/scala
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:$SCALA_HOME/bin:${SBT_HOME}/bin

RUN apk add --no-cache --update bash wget tar && rm -rf /var/cache/apk/*

# Install sbt
RUN mkdir -p "$SBT_HOME" && \
    wget -qO - --no-check-certificate "https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar xz -C $SBT_HOME --strip-components=1 && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

# Install Scala
RUN mkdir -p "$SCALA_HOME" && \
    wget -qO - "http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.tgz" | tar xz -C $SCALA_HOME --strip-components=1

WORKDIR /

RUN sbt sbtVersion
RUN scala -version