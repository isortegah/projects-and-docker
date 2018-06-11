FROM ubuntu:16.04
LABEL authors="isortegah <isortegah@gmail.com>"

USER root

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe\n" >> /etc/apt/sources.list

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jdk-headless \
    tzdata \
    sudo \
    unzip \
    wget \
    curl \
    libopencv-core2.4v5 \
    libopencv-highgui2.4v5 \
    libtesseract3 \
    wmctrl \
    xdotool \
    xvfb \
    xauth \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "MX"
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

#========================================
# Add normal user with passwordless sudo
#========================================
RUN useradd sikuser \
         --shell /bin/bash  \
         --create-home \
  && usermod -a -G sudo sikuser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'sikuser:secret' | chpasswd

#==========
# Sikulix
#==========
ENV SIKULIX_HOME /opt/sikulix

RUN mkdir ${SIKULIX_HOME} \
    && chmod ugo+rwx ${SIKULIX_HOME}

USER sikuser

RUN echo "Download and install SikuliX:" \
 && curl -L $(curl -L https://launchpad.net/sikuli/sikulix/ | grep -Po '(?<=href=")https://launchpad.net/sikuli/sikulix/[^"]+download[^"]+') \
    -o ${SIKULIX_HOME}/sikulix-setup.jar \
 && xvfb-run java -jar ${SIKULIX_HOME}/sikulix-setup.jar options 1.1 \
 && echo "Make SikuliX binaries available for everyone:" \
 && chmod +x ${SIKULIX_HOME}/sikulix.jar ${SIKULIX_HOME}/runsikulix \
 && echo "Create default home directory:" \
 && chmod ugo+rwx /home/sikuser

USER root

RUN ln -s ${SIKULIX_HOME}/runsikulix /usr/local/bin/ \
 && ln -s ${SIKULIX_HOME}/sikulix.jar /usr/local/bin/ \
 && echo "Clean-up:" \
 && rm -rf /var/lib/apt/lists/* /tmp/* ${SIKULIX_HOME}/sikulix-setup.jar ${SIKULIX_HOME}/*-SetupLog.txt ${SIKULIX_HOME}/SetupStuff

#==============================
# Locale and encoding settings
#==============================
ENV LANG_WHICH es
ENV LANG_WHERE MX
ENV ENCODING UTF-8
ENV LANGUAGE ${LANG_WHICH}_${LANG_WHERE}.${ENCODING}
ENV LANG ${LANGUAGE}
# Layer size: small: ~9 MB
# Layer size: small: ~9 MB MB (with --no-install-recommends)
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    language-pack-es \
    tzdata \
    locales \
  && locale-gen ${LANGUAGE} \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get -qyy autoremove \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get -qyy clean

#================
# Font libraries
#================
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    libfontconfig \
    libfreetype6 \
    xfonts-cyrillic \
    xfonts-scalable \
    fonts-liberation \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-tlwg-loma-otf \
    ttf-ubuntu-font-family \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get -qyy clean

#=====
# VNC
#=====
RUN apt-get update -qqy \
  && apt-get -qqy install \
  x11vnc \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#=========
# fluxbox
# A fast, lightweight and responsive window manager
#=========
RUN apt-get update -qqy \
  && apt-get -qqy install \
    fluxbox \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#==============================
# Scripts to run
#==============================
COPY entry_point.sh \
functions.sh \
  /opt/bin/

RUN chown sikuser:sikuser /opt/bin/entry_point.sh \
    && chmod 500 /opt/bin/entry_point.sh
#===================================================
# Run the following commands as non-privileged user
#===================================================

USER sikuser

#==============================
# Generating the VNC password as sikuser
# So the service can be started with sikuser
#==============================

RUN mkdir -p ~/.vnc \
  && x11vnc -storepasswd secret ~/.vnc/passwd

#============================
# Some configuration options
#============================
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

CMD ["/opt/bin/entry_point.sh"]

EXPOSE 5900