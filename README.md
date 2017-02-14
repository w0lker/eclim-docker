# Eclim docker image
## Start service
docker run --name eclim_daemon -d -v /a_local_workspace_absolute_directory:/project w0lkertg/eclim-docker
## Using eclim
docker exec -it eclim_daemon eclim --help
