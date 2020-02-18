docker run -p 8080:8080 -v //c/Users/iseor/.jenkins/://root/.jenkins jenkins



Ejecución de Jenkins con opción de ejecutar un docker dentro del contenedor.
Verificar instalar docker en la version jenkins/jenkins:lts
  
docker run  -p 8080:8080 -p 50000:50000 -v /home/isortega/Jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --user root jenkinsci/blueocean


## Conexion de agentes
ssh-keygen -t rsa -f for_jenkins_key
cat for_jenkins_key.pub > /home/isortegah/.ssh/authorized_keys
cat for_jenkins_key.pub > /home/isortegah/jenkins/.ssh/authorized_keys
known_hosts



https://linuxtechlab.com/how-to-easily-add-ssh-credentials-on-jenkins-server/
https://support.cloudbees.com/hc/en-us/articles/222978868-How-to-Connect-to-Remote-SSH-Slaves-
https://stackoverflow.com/questions/41734737/why-jenkins-says-server-rejected-the-1-private-keys-while-launching-the-agen

## Pipeline

Ejecución en paralelo https://jenkins.io/blog/2017/09/25/declarative-1/
https://jenkins.io/pipeline/getting-started-pipelines/
https://jenkins.io/doc/pipeline/tour/running-multiple-steps/
Instalar interface Blue ocean https://jenkins.io/doc/book/blueocean/getting-started/#on-an-existing-jenkins-instance