# Selenium Grid Node Chrome Debug

Esta imagen es el nodo para Chrome-Debug

## Dockerfile

Se toma como base la imagen [isortegah/node-chrome-debug](https://hub.docker.com/r/isortegah/node-base/) en la cual se altero 
el archivo `entry-point.sh`.

El codigó base oficial se encuentra en la siguiente liga [`selenium/node-chrome-debug`](https://github.com/SeleniumHQ/docker-selenium/tree/master/NodeChromeDebug)

## Como se usa esta imagen

1. Construcción de la imagen
```cmd
docker build -t isortegah/node-chrome-debug:latest
```
2. Login en Docker hub
```cmd
docker login
```
3. Push a Docker Hub
```cmd
docker push isortegah/node-chrome-debug:latest
```