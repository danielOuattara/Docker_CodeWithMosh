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


# 7 - Container File 02h46:03
# -----------------------------

#check for running containers
docker ps 

CONTAINER ID   IMAGE               COMMAND                  CREATED             STATUS          PORTS      NAMES
03d04160cafc   react-app-mosh:v3   "docker-entrypoint.s…"   58 minutes ago      Up 27 minutes   3000/tcp   blue-sky
fbfcf539dc72   react-app-mosh:v3   "docker-entrypoint.s…"   About an hour ago   Up 27 minutes   3000/tcp   dazzling_euclid

# start a shell session in the container 03d0
docker exec -it 03d sh

/app $ 

# create something in the file system
touch UPDATE.txt

# exit the interactive shell
exit 

# next, start another shell session in the container fbfc
docker exec -it fbfc sh

# CONFIRM that the file UPDATE.txt is not visible in this second running container: CONFIRMED !!!

# CONCLUSION: 
# 1- each container running or not has his own file system 
#    that is invisible to others containers
#
# 2- Never store data in the file system of a container; 
#    in case of the container is to be deleted, all the 
#    data will also be lost; prefer docker Volume instead


# 8 - Persisting Data using Volumes 02h47:37
# -------------------------------------------

# A volume is a storage outside of container

# show info about volume

docker volume

Usage:  docker volume COMMAND

Manage volumes

Commands:
  create      Create a volume
  inspect     Display detailed information on one or more volumes
  ls          List volumes
  prune       Remove unused local volumes
  rm          Remove one or more volumes

Run 'docker volume COMMAND --help' for more information on a command.

# create a volume
docker volume create vol-app-data

# inspect volume
docker volume inspect vol-app-data

[
    {
        "CreatedAt": "2024-11-26T20:19:43Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/vol-app-data/_data",
        "Name": "vol-app-data",
        "Options": null,
        "Scope": "local"
    }
]

# start a container and give this container for persisting data
docker run -d -p 8000:3000 -v vol-app-data:/app/data react-app-mosh:v3

# output
818bd35c09d615ced306124c1baa271e4006c00f717abd89291ce3b494c23108

# start an interactive shell session  on this newly created container
docker exec -it 818bd sh

# got the 'data' directory and create smthg
cd /data
echo a new info > data.txt

/app/data  echo a new info > data.txt
# sh: can't create data.txt: Permission denied

# cd .. and run ls -l

/app $ ls -l
total 688
-rw-r--r--    1 root     root          1484 Nov 20 13:16 Dockerfile
-rw-r--r--    1 root     root          3465 Nov 20 19:53 README.md
drwxr-xr-x    2 root     root          4096 Nov 26 20:19 data  # <--- This directory is owned by 'root' user
drwxr-xr-x    1 daniel   react-ap      4096 Nov 26 20:35 node_modules
-rw-r--r--    1 root     root        669052 Nov 15 16:07 package-lock.json
-rw-r--r--    1 root     root           812 Nov 15 16:07 package.json
drwxr-xr-x    2 root     root          4096 Nov 15 07:50 public
drwxr-xr-x    2 root     root          4096 Nov 25 12:11 src

# Note that user 'daniel' has no right to write on the 'data/' directory

# In Our cmd above, we let docker itself create and own this directory 

# To prevent such a thing to happen, let's update the Dockerfile

FROM node:22.11-alpine3.20
RUN addgroup react-app && adduser -S -G react-app daniel
WORKDIR /app
COPY package*.json .
RUN npm install
RUN chown -R daniel:react-app /app
USER daniel
RUN mkdir data  # <-- NEW !
COPY . .
ENV API_URL=http://apu.myapp.com
EXPOSE 3000
CMD ["npm", "start"]

# try to rebuild the image because of the Dockerfile update
docker build -t react-app-mosh:v4 ./

# start again a container and give this container for persisting data
docker run -d -p 8000:3000 -v vol-app-data:/app/data react-app-mosh:v4

# output
616e8b29691a3c2bd2aa09ea7837171475100af073f6f16724e2db868fa88c26

# start again an interactive shell session on this newly created container
docker exec -it 616e8 sh


# 9 - Copying Files between the host and containers 
# -------------------------------------------------

# 10 - Sharing the source  code with a Container
# -----------------------------------------------