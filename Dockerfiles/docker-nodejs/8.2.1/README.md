Imagen Docker de Nodejs versión 8.2.1
===

En esta imagen utilizare alpine:3.6 como base.

## Proceso

* Creación de imagen:
<pre>
docker build -it --force-rm isortegah/nodejs_8_2_1:v1 .
</pre>

* Correr imagen:
<pre>
docker run -it < id contenedor >
</pre>

* Login en DockerHub:
<pre>
docker login
</pre>
* Push imagen a docker hub
<pre>
docker push isortegah/nodejs_8_2_1:v1
</pre>
* Borrar contenedores:
<pre>
docker ps -a | egrep Exited | cut -d ' ' -f 1|xargs docker rm
</pre>