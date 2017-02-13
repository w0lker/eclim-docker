# Eclim daemon docker image
## Start service
docker run --name eclim_daemon -d -v xxx:/project w0lkertg/eclim-docker
## Using eclim
docker exec -it eclim_daemon eclim xxx
