# Docker #

## Índice
[**Iniciar docker en Windows**](#iniciar-docker-en-windows)
[**Comandos mas usados Docker**](#comandos-mas-usados-docker)

## Iniciar docker en windows 
1. Iniciar machina de docker 
    <pre>docker-machine start default</pre>
2. `docker-machine env default`
3. `@FOR /f "tokens=*" %i IN ('docker-machine env default') DO @%i`

### Referencias
>>**[Docker Machine Overview](https://docs.docker.com/machine/overview/)**

## Despliegue en heroku
* Login en heroku
    <pre> heroku login</pre>
* Crear app en heroku
    <pre> heroku create <nombre app></pre>
* Asignar app en la cual se realizara el Deploy
    <pre> heroku git:remote -a  <nombre app></pre>
* Iniciar login en el container a desplegar 
    <pre>heroku container:login</pre>
* Push a heroku
    <pre>heroku container:push web --app <nombre app></pre>
* Push heroku forma normal
    <pre>git push heroku master --app <nombre app></pre>

>### Referencias
>> **[Container Registry and Runtime](https://devcenter.heroku.com/articles/container-registry-and-runtime)**

>> **[Heroku Node.js Docker Image](https://hub.docker.com/r/heroku/nodejs/)** 

## Comandos mas usados Docker