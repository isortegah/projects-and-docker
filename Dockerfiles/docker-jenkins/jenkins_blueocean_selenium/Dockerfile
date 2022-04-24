FROM jenkinsci/blueocean

USER root

RUN rm /usr/share/jenkins/jenkins.war \
    && wget https://updates.jenkins-ci.org/download/war/2.284/jenkins.war -P /usr/share/jenkins 

USER jenkins