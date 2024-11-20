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