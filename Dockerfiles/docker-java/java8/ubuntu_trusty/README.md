

## Comandos Ejecutados

1. Creación de la imagen con Java8.
 <pre>docker build -t isortegah/java8:v1 .</pre>

2. Ejecución de imagen con consola bash
<pre>docker run -it isortegah/java8:v1 /bin/bash</pre>

3. Se inicia sesión en dockerhub
<pre>docker login</pre>

4. Se publica imagen en dockerhub
<pre>docker push isortegah/java8:v1</pre>