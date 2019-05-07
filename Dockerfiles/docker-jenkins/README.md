docker run -p 8080:8080 -v //c/Users/iseor/.jenkins/://root/.jenkins jenkins



Ejecución de Jenkins con opción de ejecutar un docker dentro del contenedor.
Verificar instalar docker en la version jenkins/jenkins:lts
  
docker run  -p 8080:8080 -p 50000:50000 -v /home/isortega/Jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --user root jenkinsci/blueocean