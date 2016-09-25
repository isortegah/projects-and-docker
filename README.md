# Docker #

## Índice
> **[Iniciar docker en Windows](#iniciar-docker-en-windows)**

## Iniciar docker en windows 
1. Iniciar machina de docker 
    <pre>docker-machine start default</pre>
2. `docker-machine env default`
3. `@FOR /f "tokens=*" %i IN ('docker-machine env default') DO @%i`

### Referencias
>>**[Docker Machine Overview](https://docs.docker.com/machine/overview/)**

## Despliegue en heroku
* Login en heroku
>> `heroku login`
* Crear app en heroku
>> `heroku create <nombre app>`
* Asignar app en la cual se realizara el Deploy
>> `heroku git:remote -a  <nombre app>`
* Iniciar login en el container a desplegar 
>>`heroku container:login`
* Push a heroku
>>`heroku container:push web --app <nombre app>`
* Push heroku forma normal
>>`git push heroku master --app <nombre app>`

>### Referencias
>> **[Container Registry and Runtime](https://devcenter.heroku.com/articles/container-registry-and-runtime)**

>> **[Heroku Node.js Docker Image](https://hub.docker.com/r/heroku/nodejs/)** 