# 1. Running Linux
# ------------------
docker pull ubuntu

# shortcut to pull and run ubuntu in one go
docker run ubuntu

# docker show me processes started
docker ps  

# docker show me all processes 
docker ps -a  

# docker run a contenair in interactive mode
docker run -it ubuntu
# output of the above cmd that run ubuntu and set us on the shell: 
root@a5cca4daea25:/# 

# then 
echo hello world
whoami
echo $0
history
!#_in_history


# 2. Managing Packages
# ----------------------
apt
apt-get

# see the error when running
apt install nano

# update the package database
apt update

# run the install cmd again
apt install nano

# run nano editor
nano

# remove nano
apt remove nano

# exercice: install python

# 3. Linux file system
# -----------------------

# 4. Navigate Linux file system
# ------------------------------

pwd
ls
ls -1
ls -l
cd 
cd ..
cd ../..

ls /bin

cd ~

# 5. Manipulating Files and Directories
# --------------------------------------

mkdir test
ls
mv test docker

cd docker

touch hello.txt

touch file1.txt file2.txt file3.txt

ls -1

mv hello.txt hello-docker.txt

# ctrl + w : to remove one word backward

rm file*

rm -r docker


# 6. Editing and Viewing Files
# ------------------------------

apt install nano
nano file1.txt

# type in some text

# see content of a file

cat file1.txt # for short content

apt install adduser

cat /etc/adduser.conf

# more cmd is better for large content + scrolls down ONLY
more /etc/adduser.conf 

# less cmd is better for large content + scrolls up & down
less /etc/adduser.conf 

head -n 5 filename
tail -n 5 filename


# 7. Redirection, operator >
# ----------------------------

cat file1.txt

#redirect the output of `cat` to file2.txt
cat file1.txt > file2.txt

# output the content of file1.txt & file2.txt
cat file1.txt file2.txt

# redirect the content of file1.txt & file2.txt to combined.txt
cat file1.txt file2.txt > combined.txt

echo hello
echo hello > hello.txt

cat hello.txt

ls -l /etc > etc.txt

# 8. Searching for text in a file
# --------------------------------

# grep := global regular expression print

# search for `hello` in file1.txt
grep hello file1.txt
grep -i hello file1.txt

# search for `root` in `/etc/password` file
grep -i root /etc/passwd

# search for `hello` in any named `file` file
grep -i hello file*

# search for `hello` in a directory
grep -i -r hello .
# OR
grep -ir hello .


# 9. Finding Files and Directories
# ----------------------------------

# list files & folders in local position
ls
ls -a

# list files & folders and their inheritance in local position
find

find /etc

# find only directory
find -type d

# find only file
find -type f

# find file with name starting with `f`
find -type f -name "f*"

# find file with name starting insensitively with `f`
find -type f -iname "f*"

# find all python file in this image, then write the result in a file called 'python-files.txt'

find / -type f -name "*.py" > python-files.txt


# 10. Chaining commands
# -----------------------

# all chaining commands below get executed even if one of them fail
mkdir test; cd test; echo done

# in the below chaining commands, if one fail then the ones after it won't be executed
mkdir test && cd test && echo done

# in the below chaining commands, if the first one fails then second one is executed
mkdir test || echo "directory exists"

# piping a fisrt command into another

ls /bin | less
ls /bin | head
ls /bin | head -n 5
ls /bin | less > root-bin-file.txt

# splitting a long command into mutliples lines using backslashes
mkdir hello; \
cd hello; \
echo "done"


# 10. Environment variables
# -------------------------

# print all the env. var. in the system
printenv

HOSTNAME=a5cca4daea25
PWD=/root
HOME=/root
LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:
LESSCLOSE=/usr/bin/lesspipe %s %s
TERM=xterm
LESSOPEN=| /usr/bin/lesspipe %s
SHLVL=1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
_=/usr/bin/printenv
OLDPWD=/root/hello


# print the value of a special env. variable
printenv PATH

# OR

echo $PATH

# set an env. variable, only available for the current terminal session
export DB_USER=daniel
echo $DB_USER 
printenv DB_USER

#  stop & start a container again
docker start -i <container_id>

# after restartig one can confirm that the DB_USER varaible is no longeur present

# to make a environment variable persistant for a user n=, one must head to the home directory
# and append the new environment variable to the '.bashrc' file

# quick way: append var. to .bashrc + source(relaod) the .bashrc file
echo DB_USER=daniel >> .bashrc
source .bashrc

# STOP: 01h:13:03