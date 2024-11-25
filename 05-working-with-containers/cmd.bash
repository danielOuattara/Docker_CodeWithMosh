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

# 3 - Publishin Ports 
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