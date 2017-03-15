# Imagen Slim #

Esta imagen no contiene los paquetes comunes que figuran en la etiqueta predeterminada y sólo contiene los paquetes mínimos necesarios para ejecutar `node`. Si estamos trabajando en un ambiente donde se desplegará sólo la imagen Node.js y tenemos limitaciones de espacio, es muy recomendable el uso de la imagen por defecto de este repositorio.

**Dockerfile**  
Archivo  Docker que fue utlizado para generar imagen

## Comandos Ejecutados

1. Creación de la imagen agregando la configuración para Heroku.
 <pre>docker build -f Dockerfile --force-rm -t isortegah/nodejs7_7:v1 .</pre>