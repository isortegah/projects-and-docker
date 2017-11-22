

Ejecución de imagen
```bash
docker run -dit --name scala isortegah/scala:1.0
```

docker rmi $(docker images -f dangling=true -q)

ejecución de imagen con bash

```bash
sudo docker run -it 2de64f3b3a1a /bin/ash
```

```bash
sudo docker run -it 2de64f3b3a1a /bin/sh
```

Borrar contenedores
```bash
sudo docker rm $(docker ps -a -q)
```

Borrar imagenes
```bash
docker rmi $(docker images -f dangling=true -q)
```