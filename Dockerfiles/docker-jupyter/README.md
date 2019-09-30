sudo docker run --user root -e GRANT_SUDO=yes  -v ~/:/home/jovyan/work -v /data:/data -it --rm -p 8888:8888 jupyter/all-spark-notebook:latest

docker run -it --rm -p 8888:8888 -p 4040:4040 -v /home/isortega/Workspace/Datio/PySpark:/home/jovyan/work jupyter