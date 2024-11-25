# 1 - Starting Containers
# -------------------------

# check images
docker  images

#see running container(s)
docker ps

# run a new container, 
# notice the cursor is no more available in the terminal
docker run react-app-mosh:v3

# run a new container in detached mode
docker run -d react-app-mosh:v3

# check running container
docker ps

# run a new container using a self name attribute
docker run -d --name blue-sky react-app-mosh:v3 


# 2 - Viewing the logs
# ---------------------

# print the log of a container that is running in detached mode

# show the logs for a running container
docker logs 03d0

# additional info about logs cmd
docker logs --help

Usage:  docker logs [OPTIONS] CONTAINER

Fetch the logs of a container

Aliases:
  docker container logs, docker logs

Options:
      --details        Show extra details provided to logs
  -f, --follow         Follow log output
      --since string   Show logs since timestamp (e.g. "2013-01-02T13:23:37Z") or relative (e.g. "42m" for 42 minutes)
  -n, --tail string    Number of lines to show from the end of the logs (default "all")
  -t, --timestamps     Show timestamps
      --until string   Show logs before a timestamp (e.g. "2013-01-02T13:23:37Z") or relative (e.g. "42m" for 42 minutes)

# print logs using option 'follow' mode = watching output constantly
docker logs -f 03d0

# print logs using option 'timestamp' mode
docker logs -t 03d0

# print logs using options 'timestamp' and 'follow'
docker logs -tf 03d0


# 3 - Publishing Ports 
# -------------------------

# 4 - Executing Cmds in Running Containers 
# -----------------------------------------

# 5 - Stopping & Starting Containers
# -----------------------------------

# 6 - Removing Containers
# -------------------------

# 7 - Container File System
# -------------------------

# 8 - Persisting Data using Volumes
# ---------------------------------

# 9 - Copying Files between the host and containers 
# -------------------------------------------------

# 10 - Sharing the source  code with a Container
# -----------------------------------------------