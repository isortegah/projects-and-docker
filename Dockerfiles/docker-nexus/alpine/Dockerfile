FROM openjdk:alpine

RUN apk add --no-cache --update curl nmap tar ca-certificates wget nmap\                                                                                                                                                                                                      
    &&   update-ca-certificates     \
    && rm -rf /var/cache/apk/*

ENV NEXUS_VERSION=3.6.1-02

# configure nexus runtime
ENV NEXUS_DIR=/opt/nexus
ENV NEXUS_HOME=${NEXUS_DIR} \
    NEXUS_DATA=/home/nexus/nexus-data \
    NEXUS_CONTEXT='' \
    NEXUS_WORK=${NEXUS_DIR}/nexus-work \
    JAVA_MIN_MEM="256M" \
    JAVA_MAX_MEM="768M" 

RUN mkdir -p /opt \
  && wget \
    https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-$NEXUS_VERSION-unix.tar.gz && \
  mv nexus-$NEXUS_VERSION-unix.tar.gz /opt && \
  cd /opt && \
  tar -xzvf nexus-$NEXUS_VERSION-unix.tar.gz && \
  mv nexus-$NEXUS_VERSION nexus && \
  rm nexus-$NEXUS_VERSION-unix.tar.gz && \ 
  mkdir -p $NEXUS_DATA && \
  adduser -S -h $NEXUS_DATA nexus

RUN sed \
		-e "s|-Xms1200M|-Xms${JAVA_MIN_MEM}|g" \
        -e "s|-Xmx1200M|-Xmx${JAVA_MAX_MEM}|g" \
		-e "s|karaf.home=.|karaf.home=${NEXUS_HOME}|g" \
		-e "s|karaf.base=.|karaf.base=${NEXUS_HOME}|g" \
		-e "s|karaf.etc=etc|karaf.etc=${NEXUS_HOME}/etc|g" \
		-e "s|java.util.logging.config.file=etc|java.util.logging.config.file=${NEXUS_HOME}/etc|g" \
		-e "s|karaf.data=data|karaf.data=${NEXUS_DATA}|g" \
		-e "s|java.io.tmpdir=data/tmp|java.io.tmpdir=${NEXUS_DATA}/tmp|g" \
        -i "${NEXUS_HOME}/bin/nexus.vmoptions" 
RUN chown -R nexus "${NEXUS_DATA}" /opt/sonatype-work

VOLUME ${NEXUS_DATA}

EXPOSE 8081 5000

WORKDIR /$NEXUS_HOME

USER nexus

CMD ["bin/nexus", "run"]