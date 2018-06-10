FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		bzip2 unzip xz-utils curl \
	&& rm -rf /var/lib/apt/lists/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

# do some fancy footwork to create a JAVA_HOME that's cross-architecture-safe
RUN ln -svT "/usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)" /docker-java-home
ENV JAVA_HOME /docker-java-home
ENV JAVA_VERSION 8u171
ENV JAVA_DEBIAN_VERSION 8u171-b11-1~deb9u1

# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20170531+nmu1

RUN set -ex; \
	\
# deal with slim variants not having man page directories (which causes "update-alternatives" to fail)
	if [ ! -d /usr/share/man/man1 ]; then \
		mkdir -p /usr/share/man/man1; \
	fi; \
	\
	apt-get update; \
	apt-get install -y \
		openjdk-8-jdk-headless="$JAVA_DEBIAN_VERSION" \
		ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
# verify that "docker-java-home" returns what we expect
	[ "$(readlink -f "$JAVA_HOME")" = "$(docker-java-home)" ]; \
	\
# update-alternatives so that future installs of other OpenJDK versions don't change /usr/bin/java
	update-alternatives --get-selections | awk -v home="$(readlink -f "$JAVA_HOME")" 'index($3, home) == 1 { $2 = "manual"; print | "update-alternatives --set-selections" }'; \
# ... and verify that it actually worked for one of the alternatives we care about
	update-alternatives --query java | grep -q 'Status: manual'

# see CA_CERTIFICATES_JAVA_VERSION notes above
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

#################
### Maven install
#################

ARG MAVEN_VERSION=3.5.3
ARG USER_HOME_DIR="/root"
ARG SHA=b52956373fab1dd4277926507ab189fb797b3bc51a2a267a193c931fffad8408
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

################
### Sikuli install
################

RUN echo "Install requirements:" \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        libopencv-core2.4v5 \
        libopencv-highgui2.4-deb0 \
        libtesseract3 \
        wmctrl \
        xdotool \
        xvfb \
        xauth \
 && apt-get clean

RUN echo "Workaround lsb_release showing errors when missing:" \
 && printf "#/bin/sh\nuname -a\n" >/usr/bin/lsb_release \
 && chmod +x /usr/bin/lsb_release

RUN apt-get install -y sikulix

ENV SIKULIX_HOME /opt/sikulix

RUN echo "Download and install SikuliX:" \
 && mkdir ${SIKULIX_HOME} \
 && curl -L $(curl -L https://launchpad.net/sikuli/sikulix/ | grep -Po '(?<=href=")https://launchpad.net/sikuli/sikulix/[^"]+download[^"]+') \
    -o ${SIKULIX_HOME}/sikulix-setup.jar \
 && xvfb-run java -jar ${SIKULIX_HOME}/sikulix-setup.jar options 1.1 \
 && echo "Make SikuliX binaries available for everyone:" \
 && chmod +x ${SIKULIX_HOME}/sikulix.jar ${SIKULIX_HOME}/runsikulix \
 && ln -s ${SIKULIX_HOME}/runsikulix /usr/local/bin/ \
 && ln -s ${SIKULIX_HOME}/sikulix.jar /usr/local/bin/ \
 && echo "Create default home directory:" \
 && mkdir /home/sikulix \
 && chmod ugo+rwx /home/sikulix \
 && echo "Clean-up:" \
 && rm -rf /var/lib/apt/lists/* /tmp/* ${SIKULIX_HOME}/sikulix-setup.jar ${SIKULIX_HOME}/*-SetupLog.txt ${SIKULIX_HOME}/SetupStuff


######################
### Chrome Install
######################

RUN apt-get update && apt-get install -y wget gnupg

ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    ${CHROME_VERSION:-google-chrome-stable} \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY wrap_chrome_binary /opt/bin/wrap_chrome_binary
RUN chmod +x /opt/bin/wrap_chrome_binary
RUN /opt/bin/wrap_chrome_binary

#============================================
# Chrome webdriver
#============================================
# can specify versions by CHROME_DRIVER_VERSION
# Latest released version will be used by default
#============================================
ARG CHROME_DRIVER_VERSION="latest"
RUN CD_VERSION=$(if [ ${CHROME_DRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE); else echo $CHROME_DRIVER_VERSION; fi) \
  && echo "Using chromedriver version: "$CD_VERSION \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CD_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/drivers/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/drivers \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/drivers/chromedriver /opt/drivers/chromedriver-$CD_VERSION \
  && chmod 755 /opt/drivers/chromedriver-$CD_VERSION \
  && ln -fs /opt/drivers/chromedriver-$CD_VERSION /usr/bin/chromedriver


#=====
# VNC
#=====
RUN apt-get update -qqy \
  && apt-get -qqy install \
  x11vnc \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#============================
# Some configuration options
#============================
ENV SCREEN_WIDTH 1366
ENV SCREEN_HEIGHT 768
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

#=======
# Fonts
#=======
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable \
    nmap \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#=========
# fluxbox
# A fast, lightweight and responsive window manager
#=========
RUN apt-get update -qqy \
  && apt-get -qqy install \
    fluxbox vim \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN mkdir -p ~/.vnc \
  && x11vnc -storepasswd secret ~/.vnc/passwd

COPY entry_point.sh /opt/bin/entry_point.sh
COPY functions.sh /opt/bin/functions.sh

RUN chmod +x /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/functions.sh

ADD entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh


ENTRYPOINT ["/opt/bin/entry_point.sh"]
EXPOSE 5900