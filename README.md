# Eclim daemon docker image
## Start service
docker run --name eclimd -d w0lkertg/eclim-docker
## Client usage
### using eclim
docker run -it  -link eclimd w0lkertg/eclim-docker bash /home/eclim/eclipse/eclim
###  Public daemon port
docker run --name eclimd -p 9091:9091 -d w0lkertg/eclim-docker
