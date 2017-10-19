#!/usr/bin/env bash
java -jar -Xmx512m -Xss512k jenkins.war --httpPort=8080 --ajp13Port=-1 --httpsPort=-1 