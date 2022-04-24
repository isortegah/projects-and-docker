sudo docker run --user root -e GRANT_SUDO=yes  -v ~/:/home/jovyan/work -v /data:/data -it --rm -p 8888:8888 jupyter/all-spark-notebook:latest

docker run -it --rm -p 8888:8888 -p 4040:4040 -v /home/isortega/Workspace/Datio/PySpark:/home/jovyan/work jupyter

Instalar kernel de scala en jupyter
https://medium.com/@bogdan.cojocar/how-to-run-scala-and-spark-in-the-jupyter-notebook-328a80090b3b


docker run -d -p 8888:8888 -v /home/cgsilverio/RunLocal:/home/jovyan/work jupyter/all-spark-notebook start-notebook.sh --NotebookApp.token=''