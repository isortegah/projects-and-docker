

Ejecución de imagen
```bash
docker run -dit --name scala isortegah/scala:1.0
```

docker rmi $(docker images -f dangling=true -q)