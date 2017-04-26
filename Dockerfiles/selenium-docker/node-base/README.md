# Selenium Grid Node Base

_Esta imagen no está destinada a ser ejecutada directamente!_ Sirve como imagen de base utilizada para los nodos de selenium.

## Dockerfile

Se altero el archivo `entry-point.sh`, agregando un `sleep` requerido para evitar error de conexión con el hub durante la ejecución de `docker-compose up` cuando hay mas contenedores involucrados.

El codigó base oficial se encuentra en la siguiente liga [`selenium/node-base`](https://github.com/SeleniumHQ/docker-selenium/blob/master/NodeBase)

## Como se usa esta imagen

1. Generación de `Dockerfile`
```cmd
./generate.sh 3.4.0-bismuth
```
2. Construcción de la imagen
```cmd
docker build -t isortegah/node-base:latest
```
3. Login en Docker hub
```cmd
docker login
```
4. Push a Docker Hub
```cmd
docker push isortegah/node-base:latest
```

