# 1 - Images and Containers
# --------------------------

# Image contains:
# A cut-down OS
# 1/3 party librairies
# Application files
# Env. variables

# a container:
# Provides an isolated running env.
# can be stopped & restarted
# is just a process! (a special one!)

# check running container

docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED      STATUS       PORTS     NAMES
a5cca4daea25   ubuntu    "/bin/bash"   2 days ago   Up 2 hours             compassionate_faraday


# from a new terminal, run a new container
docker run -it ubuntu

# check
docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS         PORTS     NAMES
f5061049d19d   ubuntu    "/bin/bash"   10 seconds ago   Up 9 seconds             eager_jackson
a5cca4daea25   ubuntu    "/bin/bash"   2 days ago       Up 2 hours               compassionate_faraday

# each Container is an isolated environment for executing an application


# 2 - Sample Web Application
# ---------------------------

# create a new React app using CRA: 
npx create-react-app ract-app 
 
# OR using vite

# To run the app : 
# a. : install node
# b. : npm install (install dependencies)
# c. : npm start (start the project)

# Next to do : 
# a. dockerise this app 
# b. package it into an Image 
# c. deploy it and use it anywhere


# 3 - DockerFile Instructions
# ---------------------------

# A DockerFile contains instructions for building a Docker Image

#  FROM 
#  WORKDIR
#  COPY
#  ADD
#  RUN
#  ENV
#  EXPOSE
#  USER
#  CMD
#  ENTRYPOINT


# 4 - Choosing the Right Base Image
# ----------------------------------

# see https://docs.docker.com/reference/samples/

# at the root of the application
touch DockerFile

# then the 1st line:
FROM node:22.11-alpine3.20

# next build an Image from this Dockerfile
docker build -t react-app-01-mosh .

# check images list 
docker image ls

# then create and run a container from the newly created image
docker run -it react-app-01-mosh

# check for newly created container infos
docker ps -a

# found : goofy_varahamihira @335a3829175a

# now start again the lastly created container in 'sh' env.
# NOTE: 'alpine' only have 'sh' env. not 'bash'

docker start -i 335a3829175a sh

Error: you cannot start and attach multiple containers at once

# so run the followinf command, that shold output a root shell
docker run -it react-app-01-mosh sh

ls
node --version
v22.11.0


# 5 - Copy the app files and directories
# ----------------------------------------

FROM node:22.11-alpine3.20
COPY package.json README.md  /app/
# or
COPY package*.json  /app/
# or
COPY .  /app/

# --------------------------------

FROM node:22.11-alpine3.20
WORKDIR /app
COPY ["hello world.txt", "."]
# or
COPY . .

# re-build the image 
docker build -t react-app-01-mosh .

# and notice the 2 lines: 
 => [internal] load build context                                                                                                    14.0s
 => => transferring context: 294.87MB 

# then create and run a container from the newly created image
# run shell so to be able to look the file system
docker run -it react-app-01-mosh sh

# output:
/app # 

# list all items:
ls -1

# output:
/app # ls -1
Dockerfile
README.md
node_modules
package-lock.json
package.json
public
src

# See everything that has been copy to the WORKDIR, even `node_modules`


# 6 - Excluding Files and Folders
# --------------------------------

# Exclude `node_modules` to make the `build context` 
# lighter and the build will be faster. The dependencies 
# located in the `package.json` will be restored in 
# the target image. 

# Create a `.dockerignore` at the root  of the project
# then add `node_modules`.

# re-build the image 
docker build -t react-app-01-mosh .

# then create and run a container from the newly created 
# image run shell so to be able to look the file system
docker run -it react-app-01-mosh sh

# output:
/app # 

# list all items:
ls -1

# output:
/app # ls -1
Dockerfile
README.md
package-lock.json
package.json
public
src

# confirm that `node_modules` is not present

# we need to install the dependencies to make our app works


# 7 - Running commands
# -------------------------

FROM node:22.11-alpine3.20
WORKDIR /app/
COPY . .
RUN npm install

# re-build the image 
docker build -t react-app-01-mosh .

# run again the shell so to be able to look the file system
docker run -it react-app-01-mosh sh

# output:
/app # 

# list all items:
ls -1

# output:
/app # ls -1
Dockerfile
README.md
node_modules # <-- PRESENT HERE, GOOD !
package-lock.json
package.json
public
src

# 8 - Setting Environment Variables
# ----------------------------------

# Dockerfile
FROM node:22.11-alpine3.20
WORKDIR /app/
COPY . .
RUN npm install
ENV API_URL=http://apu.myapp.com

# re-build the image 
docker build -t react-app-01-mosh .

# run again the shell so to be able to look the file system
docker run -it react-app-01-mosh sh


# output:
/app # 

# print the environment var and cofirm the API_URL env. var is present:
printenv

NODE_VERSION=22.11.0
HOSTNAME=4f532c81aa8b
YARN_VERSION=1.22.22
SHLVL=2
HOME=/root
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/app
API_URL=http://apu.myapp.com

# OR

printenv API_URL

# OR 
echo $API_URL


# 9 - Exposing Ports
# --------------------

# start the app locally
npm start

# the app start on port 3000

# next when running the app on the container, 
# the port will be the same on the container, NOT on the host 

# In real use, one can map port from the container to the host

# Dockerfile
FROM node:22.11-alpine3.20
WORKDIR /app/
COPY . .
RUN npm install
ENV API_URL=http://apu.myapp.com
EXPOSE 3000


# 10 - Setting the User
# ---------------------

# NOTICE: 
# -> by default Docker run our application with 
# the Root use, which has the highest privileges.

# -> this can expose to a security threat

# So to run this app, we should create a regular user 
# with limited privileges

# start interactively a new container in alpine
docker run -it alpine

# output
/#

# then type `adduser`
/# adduser
BusyBox v1.36.1 (2024-06-10 07:11:47 UTC) multi-call binary.

Usage: adduser [OPTIONS] USER [GROUP]

Create new user, or add USER to GROUP

	-h DIR		Home directory
	-g GECOS	GECOS field
	-s SHELL	Login shell
	-G GRP		Group  
	-S		Create a system user  # <--- Use this !
	-D		Don't assign a password
	-H		Don't create home directory
	-u UID		User id
	-k SKEL		Skeleton directory (/etc/skel)
/ # 


# before creating a system user, create a group

# 1 - create group and add use to the group
addgroup react-app
adduser -S -G react-app react-app

# check: OK
groups react-app


# 2 - using combine cmds: create another group and add a user to the group
addgroup mosh-react && adduser -S -G mosh-react mosh-react
groups mosh-react # check OK

# Dockerfile
FROM node:22.11-alpine3.20
WORKDIR /app/
COPY . .
RUN npm install
ENV API_URL=http://apu.myapp.com
EXPOSE  3000
RUN addgroup react-app && adduser -S -G react-app daniel
USER daniel

# re-build the image 
docker build -t react-app-01-mosh .

# run again the container and confirm that the 
# actual user is just a regular one, not the root !
docker run -it react-app-01-mosh sh

# output: 
/app $

# run:
/app $ whoami

# ouptut
daniel


# 11 - Defining entrypoints
# --------------------------


# NOTICE: 

# - react-app-01-mosh image has been deleted
# - react-app-mosh image has been created instead for speed and clarity

# now, how to start the application ?

# run
docker run react-app-mosh 

# the container starts and stoppes

# better run 
docker run react-app-mosh npm start

# output
> react-app@0.1.0 start
> react-scripts start

...
...
  
Failed to compile.

[eslint] EACCES: permission denied, mkdir '/app/node_modules/.cache'
ERROR in [eslint] EACCES: permission denied, mkdir '/app/node_modules/.cache'

webpack compiled with 1 error


# Dockerfile: before
#-----
FROM node:22.11-alpine3.20
WORKDIR /app/
COPY . .
RUN npm install
ENV API_URL=http://apu.myapp.com
EXPOSE  3000
RUN addgroup react-app && adduser -S -G react-app daniel
USER daniel


# Dockerfile: after
#-----
FROM node:22.11-alpine3.20
# Create a group and user early
RUN addgroup react-app && adduser -S -G react-app daniel
# Set working directory
WORKDIR /app
# Copy files and change ownership to the non-root user
COPY . .
RUN chown -R daniel:react-app /app
# Switch to the non-root user
USER daniel
# Install dependencies
RUN npm install
# Set environment variable
ENV API_URL=http://apu.myapp.com
# Expose application port
EXPOSE 3000

# then rebuild the image and start a new container 
docker build -t react-app-mosh .

#then run the app
docker run react-app-mosh npm start

#output:
...
...
Compiled successfully!

You can now view react-app in the browser.

  Local:            http://localhost:3000
  On Your Network:  http://172.17.0.2:3000

# this is port 3000 for the container, NOT local host

# speed the container start up, update the Dockerfile
# then rebuild the image

FROM node:22.11-alpine3.20
RUN addgroup react-app && adduser -S -G react-app daniel
WORKDIR /app
COPY . .
RUN chown -R daniel:react-app /app
USER daniel
RUN npm install
ENV API_URL=http://apu.myapp.com
EXPOSE 3000
CMD npm start

# after rebuilding the image, one can start the container 
# more quickly using the following:

docker build -t react-app-mosh .

docker run react-app-mosh 

# NOTICE: about RUN vs CMD

# -> RUN is a built-time instruction
# -> CMD is a run-time instruction


# NOTICE: about CMD

# -> shell form: Docker executes this cmd inside a separate shell
CMD npm start

# -> Exec form: Docker executes this cmd directly, no need for extra shell
# -> BETTER: easier and faster to clean up resource  when starting a container
CMD ["npm", "start"]

# So update the Dockerfile

FROM node:22.11-alpine3.20
RUN addgroup react-app && adduser -S -G react-app daniel
WORKDIR /app
COPY . .
RUN chown -R daniel:react-app /app
USER daniel
RUN npm install
ENV API_URL=http://apu.myapp.com
EXPOSE 3000
CMD ["npm", "start"]

# NOTICE: CMD vs ENTRYPOINT

# -> Both are for executing commands
# -> Both accept 'shell form' and 'execute form'

# -> CMD can be easily overwritten by another cmd
#  example: 
# 	 -	create a image using CMD , 
#    -  run `docker run react-app-mosh echo hello world`
#  Here `echo hello world` will overwrite the `docker run react-app-mosh`


# -> ENTRYPOINT can NOT be easily overwritten by another cmd
#  example: 
# 	 -	create a image using ENTRYPOINT , 
#    -  run `docker run react-app-mosh --entrypoint echo hello world`
#  Here `echo hello world` will NOW be able to overwrite the `docker run react-app-mosh`

# CONCLUSION: CMD offers more flexibility and is the preferable way



# 11 - Speeding Up the builds
# ----------------------------

# read the following from bottom to top

docker history react-app-mosh

IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
2952693e5467   17 minutes ago   CMD ["npm" "start"]                             0B        buildkit.dockerfile.v0
<missing>      17 minutes ago   EXPOSE map[3000/tcp:{}]                         0B        buildkit.dockerfile.v0
<missing>      17 minutes ago   ENV API_URL=http://apu.myapp.com                0B        buildkit.dockerfile.v0
<missing>      17 minutes ago   RUN /bin/sh -c npm install # buildkit           288MB     buildkit.dockerfile.v0
<missing>      17 minutes ago   USER daniel                                     0B        buildkit.dockerfile.v0
<missing>      18 minutes ago   RUN /bin/sh -c chown -R daniel:react-app /ap…   701kB     buildkit.dockerfile.v0
<missing>      18 minutes ago   COPY . . # buildkit                             701kB     buildkit.dockerfile.v0
<missing>      16 hours ago     WORKDIR /app                                    0B        buildkit.dockerfile.v0
<missing>      17 hours ago     RUN /bin/sh -c addgroup react-app && adduser…   3.26kB    buildkit.dockerfile.v0
<missing>      3 weeks ago      CMD ["node"]                                    0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      ENTRYPOINT ["docker-entrypoint.sh"]             0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      COPY docker-entrypoint.sh /usr/local/bin/ # …   388B      buildkit.dockerfile.v0
<missing>      3 weeks ago      RUN /bin/sh -c apk add --no-cache --virtual …   5.59MB    buildkit.dockerfile.v0
<missing>      3 weeks ago      ENV YARN_VERSION=1.22.22                        0B        buildkit.dockerfile.v0
<missing>      3 weeks ago      RUN /bin/sh -c addgroup -g 1000 node     && …   142MB     buildkit.dockerfile.v0
<missing>      3 weeks ago      ENV NODE_VERSION=22.11.0                        0B        buildkit.dockerfile.v0
<missing>      2 months ago     CMD ["/bin/sh"]                                 0B        buildkit.dockerfile.v0
<missing>      2 months ago     ADD alpine-minirootfs-3.20.3-x86_64.tar.gz /…   7.8MB     buildkit.dockerfile.v

# One solution to optmize the `build` process is 
# to separate the installation of third party dependancies
# from codebase copying

FROM node:22.11-alpine3.20
RUN addgroup react-app && adduser -S -G react-app daniel
WORKDIR /app
COPY package*.json .
RUN npm install
RUN chown -R daniel:react-app /app
USER daniel
COPY . .
ENV API_URL=http://apu.myapp.com
EXPOSE 3000
CMD ["npm", "start"]

# run a build
docker build -t react-app-mosh .

# modify the application codebase a little bit
# and build again the image, and analyze the build process

# Conclusion: Dockerfil structure:
#     | stable instructions
#     | stable instructions
#     |
#     |
#     |
#     | changing instructions
#     v changing instructions


# 12 - Removing Images 02h17:20
# ------------------------------

# run 
docker images

# see all dangling images
docker images
REPOSITORY                                    TAG       IMAGE ID       CREATED        SIZE
react-app-mosh                                latest    f8b1c5a1f044   4 hours ago    685MB
<none>                                        <none>    ef30cd37f3a1   4 hours ago    685MB # <-- this !
<none>                                        <none>    2952693e5467   6 hours ago    444MB # <-- this !
<none>                                        <none>    1bae1a887fc3   6 hours ago    444MB # <-- this !
<none>                                        <none>    1ea19203af7a   22 hours ago   444MB # <-- this !
...

# remove those dangling images
docker image prune


# remove all stopped containers
docker container prune 

# run the following to get all infos about image cmd option
$ docker image

Usage:  docker image COMMAND

Manage images

Commands:
  build       Build an image from a Dockerfile
  history     Show the history of an image
  import      Import the contents from a tarball to create a filesystem image
  inspect     Display detailed information on one or more images
  load        Load an image from a tar archive or STDIN
  ls          List images
  prune       Remove unused images
  pull        Download an image from a registry
  push        Upload an image to a registry
  rm          Remove one or more images
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE

Run 'docker image COMMAND --help' for more information on a command.


# run the following cmd:

docker image rm --help

Usage:  docker image rm [OPTIONS] IMAGE [IMAGE...]

Remove one or more images

Aliases:
  docker image rm, docker image remove, docker rmi

Options:
  -f, --force      Force removal of the image
      --no-prune   Do not delete untagged parents


$ docker images
REPOSITORY                                    TAG       IMAGE ID       CREATED        SIZE
react-app-mosh                                latest    f8b1c5a1f044   4 hours ago    685MB
...


docker image rm hello-docker

#check: 
docker images

# confirm the targetted image is not listed


# also run the cmd:

docker container

Usage:  docker container COMMAND

Manage containers

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  exec        Execute a command in a running container
# export      Export a container's filesystem as a tar archive
  inspect     Display detailed information on one or more containers
  kill        Kill one or more running containers
  logs        Fetch the logs of a container
  ls          List containers
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  prune       Remove all stopped containers
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  run         Create and run a new container from an image
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  wait        Block until one or more containers stop, then print their exit codes

Run 'docker container COMMAND --help' for more information on a command.


# 13 - Tagging Images 02h20:06
# ------------------------------

docker images
REPOSITORY                                    TAG       IMAGE ID       CREATED        SIZE
react-app-mosh                                latest    f8b1c5a1f044   6 hours ago    685MB
...

# You should always use correct/explicit tag to identify 
# what version your are running in each environment (test, staging, production)

# let's first make a clean build image
docker build -t react-app-mosh .

# 1 - tag an image while building it with:

# name tag
docker build -t react-app-mosh:buster .

# OR semantic versioning
docker build -t react-app-mosh:3.1.1 .

# OR using building number
docker build -t react-app-mosh:75 .

# let's try 
docker build -t react-app-mosh:v1 .

# then check
docker images

REPOSITORY                                    TAG       IMAGE ID       CREATED        SIZE
react-app-mosh                                latest    f8b1c5a1f044   6 hours ago    685MB
react-app-mosh                                v1        f8b1c5a1f044   6 hours ago    685MB
...

#  Notice 2 images with the same imageID

# one can remove any of them without issue
docker images rm react-app-mosh:v1

# check
$ docker images
REPOSITORY                                    TAG       IMAGE ID       CREATED        SIZE
react-app-mosh                                latest    f8b1c5a1f044   6 hours ago    685MB
...


# 2 - tag an image after built it
docker image tag react-app-mosh:latest react-app-mosh:v2

#check
docker images

REPOSITORY                                    TAG       IMAGE ID       CREATED        SIZE
react-app-mosh                                latest    f8b1c5a1f044   6 hours ago    685MB
react-app-mosh                                v2        f8b1c5a1f044   6 hours ago    685MB
...

# let's show that the label `latest` is just a 
# tag by default and does not really mean 'latest'

# update source code a little bit (like add text to README.md)
# then build a new image with a tag

docker build -t react-app-mosh:v2 .

# the check

docker images

docker images
REPOSITORY                                    TAG       IMAGE ID       CREATED          SIZE
react-app-mosh                                v2        61612e27481b   46 seconds ago   685MB # <-- most recent !!
react-app-mosh                                latest    f8b1c5a1f044   7 hours ago      685MB


# 13 - Sharing Images 02h25:40
# ------------------------------

# 1. head to hub.docker.com
# 2. loggin
# 3. create a repository 

# Good To Know: In one remote repository, one can have multiple images with different tags

# How to push an image to the remote repo ??

# tag a new image from 
docker image tag 61612e27481b danielouattara/react-app-mosh:v2

# check
docker imagesdocker images
REPOSITORY                                    TAG       IMAGE ID       CREATED        SIZE
react-app-mosh                                v2        61612e27481b   4 days ago     685MB
danielouattara/react-app-mosh                 v2        61612e27481b   4 days ago     685MB
react-app-mosh                                latest    f8b1c5a1f044   4 days ago     685MB
...

# login to docker from terminal if required
docker login 

# push an image to a remote repository 
docker push danielouattara/react-app-mosh:v2

# wait until completed: done

# make an update on the code: done

# then create a new image
docker build -t react-app-mosh:v3 ./

# check images
docker images

# tag the newly created image  
docker image tag ffec41aa745d danielouattara/react-app-mosh:v3

# check images
docker images

 docker images
REPOSITORY                                    TAG       IMAGE ID       CREATED         SIZE
react-app-mosh                                v3        ffec41aa745d   2 minutes ago   685MB
danielouattara/react-app-mosh                 v3        ffec41aa745d   2 minutes ago   685MB
danielouattara/react-app-mosh                 v2        61612e27481b   4 days ago      685MB
react-app-mosh                                v2        61612e27481b   4 days ago      685MB
react-app-mosh                                latest    f8b1c5a1f044   4 days ago      685MB


# push the newly tagged image to repo
docker push danielouattara/react-app-mosh:v3



# Saving and Loading Images 02h30:00
# -----------------------------------

# In this section: how to share an image to another computer without going through dockerhub ?

# Solution: 

# 1 - save the image as a compressed file

docker image save --help

Usage:  docker image save [OPTIONS] IMAGE [IMAGE...]

Save one or more images to a tar archive (streamed to STDOUT by default)

Aliases:
  docker image save, docker save

Options:
  -o, --output string   Write to a file, instead of STDOUT

# ---
docker save -o react-app-mosh-v3.tar  react-app-mosh:v3


# 2 - load it on the other machine

docker image load --help

Usage:  docker image load [OPTIONS]

Load an image from a tar archive or STDIN

Aliases:
  docker image load, docker load

Options:
  -i, --input string   Read from tar archive file, instead of STDIN
  -q, --quiet          Suppress the load output


# to test it, first remove  all the react-app-mosh:v3 
docker image rm react-app-mosh:v3

# check
docker images

REPOSITORY                                    TAG       IMAGE ID       CREATED          SIZE
danielouattara/react-app-mosh                 v3        ffec41aa745d   18 minutes ago   685MB
danielouattara/react-app-mosh                 v2        61612e27481b   4 days ago       685MB
react-app-mosh                                v2        61612e27481b   4 days ago       685MB
react-app-mosh                                latest    f8b1c5a1f044   4 days ago       685MB

# also remvove all tag linked to react-app-mosh:v3
docker image rm ffec41

# check
docker images

REPOSITORY                                    TAG       IMAGE ID       CREATED          SIZE
danielouattara/react-app-mosh                 v3        ffec41aa745d   18 minutes ago   685MB
danielouattara/react-app-mosh                 v2        61612e27481b   4 days ago       685MB
react-app-mosh                                v2        61612e27481b   4 days ago       685MB
react-app-mosh                                latest    f8b1c5a1f044   4 days ago       685MB

# now, load the compressed images
docker image load -i react-app-mosh-v3.tar

#check
docker images
REPOSITORY                                    TAG       IMAGE ID       CREATED          SIZE
react-app-mosh                                v3        ffec41aa745d   24 minutes ago   685MB
danielouattara/react-app-mosh                 v2        61612e27481b   4 days ago       685MB
react-app-mosh                                v2        61612e27481b   4 days ago       685MB
react-app-mosh                                latest    f8b1c5a1f044   4 days ago       685MB
