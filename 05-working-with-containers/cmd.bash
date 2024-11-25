# 1 - Starting Containers 02h34:04
# ---------------------------------

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


# 2 - Viewing the logs 02h347:07
# ------------------------------

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


# 3 - Publishing Ports 02h39:15
# -------------------------------

# start a new container in detached mode and publish the port at the same time
docker run -d -p 82:3000 --name cont-1 react-app-mosh:v3

#check the running containers
docker ps

CONTAINER ID   IMAGE               COMMAND                  CREATED              STATUS              PORTS                  NAMES
34d33ea13c54   react-app-mosh:v3   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:82->3000/tcp   cont-1
03d04160cafc   react-app-mosh:v3   "docker-entrypoint.s…"   23 minutes ago       Up 23 minutes       3000/tcp               blue-sky
fbfcf539dc72   react-app-mosh:v3   "docker-entrypoint.s…"   28 minutes ago       Up 28 minutes       3000/tcp               dazzling_euclid

# 4 - Executing Cmds in Running Containers 02h41:21
# --------------------------------------------------

# show the file system for a running container

# print the working directory
docker exec cont-1 pwd
/app

# print the content of the woring directory
docker exec cont-1 ls
Dockerfile
README.md
node_modules
package-lock.json
package.json
public
src

# open a shell session in interactive mode in a running container 
docker exec -it cont-1 sh

# exit
exit

# 5 - Stopping & Starting Containers 02h43:19
# --------------------------------------------

# stop a running container
docker stop cont-1

#check 
docker ps

CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS         PORTS      NAMES
03d04160cafc   react-app-mosh:v3   "docker-entrypoint.s…"   40 minutes ago   Up 9 minutes   3000/tcp   blue-sky
fbfcf539dc72   react-app-mosh:v3   "docker-entrypoint.s…"   45 minutes ago   Up 9 minutes   3000/tcp   dazzling_euclid

# refresh the browser page at port 82, and CONFIRM the application is NOT RUNNING anymore

# start again the stopped container cont-1
docker start cont-1

# refresh the browser page at port 82, and CONFIRM the application is RUNNING effectively


# 6 - Removing Containers 02h44:15
# ----------------------------------

# 2 ways to remove a STOPPED container:

docker container rm cont-1
# OR 
docker rm cont-1

# 2 ways to remove a RUNNING container: using --force OR -f

docker container rm -f cont-1
# OR 
docker rm -f cont-1

#check 
docker ps -a

CONTAINER ID   IMAGE                                         COMMAND                  CREATED          STATUS                      PORTS      NAMES
03d04160cafc   react-app-mosh:v3                             "docker-entrypoint.s…"   49 minutes ago   Up 18 minutes               3000/tcp   blue-sky
fbfcf539dc72   react-app-mosh:v3                             "docker-entrypoint.s…"   54 minutes ago   Up 18 minutes               3000/tcp   dazzling_euclid
4f54d633f901   react-app-mosh:v3                             "docker-entrypoint.s…"   56 minutes ago   Exited (1) 55 minutes ago              condescending_newton
60ae76eef86a   alpine                                        "/bin/sh"                7 days ago       Exited (0) 7 days ago                  wonderful_newton
f5061049d19d   ubuntu                                        "/bin/bash"              10 days ago      Exited (255) 7 days ago                eager_jackson
a5cca4daea25   ubuntu                                        "/bin/bash"              13 days ago      Exited (255) 7 days ago                compassionate_faraday
890fd0c4be37   hello-docker-mosh                             "docker-entrypoint.s…"   13 days ago      Exited (0) 13 days ago                 focused_clarke
78bed91b07c3   hello-docker-mosh                             "docker-entrypoint.s…"   2 weeks ago      Exited (0) 13 days ago                 sad_pasteur

# a Linux cmd trick to find 'cont-1'
docker ps -a | grep cont-1
# nothing output

# remember; to delete all not running container (CAUTION)
docker container prune

# 7 - Container File System
# -------------------------

# 8 - Persisting Data using Volumes
# ---------------------------------

# 9 - Copying Files between the host and containers 
# -------------------------------------------------

# 10 - Sharing the source  code with a Container
# -----------------------------------------------