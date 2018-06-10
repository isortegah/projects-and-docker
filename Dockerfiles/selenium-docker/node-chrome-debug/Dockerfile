FROM isortegah/node-chrome:latest
LABEL authors=ISORTEGAH

USER root

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
# Scripts to run Selenium Node
#==============================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chown seluser:seluser /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

USER seluser

#==============================
# Generating the VNC password as seluser
# So the service can be started with seluser
#==============================

RUN mkdir -p ~/.vnc \
  && x11vnc -storepasswd secret ~/.vnc/passwd



EXPOSE 5900