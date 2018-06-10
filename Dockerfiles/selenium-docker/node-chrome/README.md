# Selenium Grid Node Chrome

Esta imagen es el nodo para Chrome

## Dockerfile

Se toma como base la imagen [isortegah/node-base](https://hub.docker.com/r/isortegah/node-base/) en la cual se altero 
el archivo `entry-point.sh`.

El codigó base oficial se encuentra en la siguiente liga [`selenium/node-chrome`](https://github.com/SeleniumHQ/docker-selenium/tree/master/NodeChrome)

## Como se usa esta imagen

1. Construcción de la imagen
```cmd
docker build -t isortegah/node-chrome:latest
```
2. Login en Docker hub
```cmd
docker login
```
3. Push a Docker Hub
```cmd
docker push isortegah/node-base:latest
```