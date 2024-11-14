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


# 12. Managing Processes
# -------------------------

# definition: a process is an instance of a running program.

# to see all processes
ps  # outputs

PID TTY          TIME CMD
1   pts/0    00:00:00 bash
16  pts/0    00:00:00 ps

# how to kill longue consuming CPU time process ?

# create a slow process
sleep 100 &

# check for all process to get the slow process PID
ps

  PID TTY          TIME CMD
    1 pts/0    00:00:00 bash
   17 pts/0    00:00:00 sleep
   18 pts/0    00:00:00 ps


# kill the slow process
kill 17

# confirm
ps
  PID TTY          TIME CMD
    1 pts/0    00:00:00 bash
   18 pts/0    00:00:00 ps


# 13. Managing Users
# --------------------

root@a5cca4daea25:~# useradd
Usage: useradd [options] LOGIN
       useradd -D
       useradd -D [options]

Options:
      --badname                 do not check for bad names
  -b, --base-dir BASE_DIR       base directory for the home directory of the
                                new account
      --btrfs-subvolume-home    use BTRFS subvolume for home directory
  -c, --comment COMMENT         GECOS field of the new account
  -d, --home-dir HOME_DIR       home directory of the new account
  -D, --defaults                print or change default useradd configuration
  -e, --expiredate EXPIRE_DATE  expiration date of the new account
  -f, --inactive INACTIVE       password inactivity period of the new account
  -F, --add-subids-for-system   add entries to sub[ud]id even when adding a system user
  -g, --gid GROUP               name or ID of the primary group of the new
                                account
  -G, --groups GROUPS           list of supplementary groups of the new
                                account
  -h, --help                    display this help message and exit
  -k, --skel SKEL_DIR           use this alternative skeleton directory
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -l, --no-log-init             do not add the user to the lastlog and
                                faillog databases
  -m, --create-home             create the user's home directory
  -M, --no-create-home          do not create the user's home directory
  -N, --no-user-group           do not create a group with the same name as
                                the user
  -o, --non-unique              allow to create users with duplicate
                                (non-unique) UID
  -p, --password PASSWORD       encrypted password of the new account
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -s, --shell SHELL             login shell of the new account
  -u, --uid UID                 user ID of the new account
  -U, --user-group              create a group with the same name as the user
  -Z, --selinux-user SEUSER     use a specific SEUSER for the SELinux user mapping
      --extrausers              Use the extra users database


#-------------------------------------------------

root@a5cca4daea25:~# usermod
Usage: usermod [options] LOGIN

Options:
  -a, --append                  append the user to the supplemental GROUPS
                                mentioned by the -G option without removing
                                the user from other groups
  -b, --badname                 allow bad names
  -c, --comment COMMENT         new value of the GECOS field
  -d, --home HOME_DIR           new home directory for the user account
  -e, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -f, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -g, --gid GROUP               force use GROUP as new primary group
  -G, --groups GROUPS           new list of supplementary GROUPS
  -h, --help                    display this help message and exit
  -l, --login NEW_LOGIN         new value of the login name
  -L, --lock                    lock the user account
  -m, --move-home               move contents of the home directory to the
                                new location (use only with -d)
  -o, --non-unique              allow using duplicate (non-unique) UID
  -p, --password PASSWORD       use encrypted password for the new password
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -r, --remove                  remove the user from only the supplemental GROUPS
                                mentioned by the -G option without removing
                                the user from other groups
  -R, --root CHROOT_DIR         directory to chroot into
  -s, --shell SHELL             new login shell for the user account
  -u, --uid UID                 new UID for the user account
  -U, --unlock                  unlock the user account
  -v, --add-subuids FIRST-LAST  add range of subordinate uids
  -V, --del-subuids FIRST-LAST  remove range of subordinate uids
  -w, --add-subgids FIRST-LAST  add range of subordinate gids
  -W, --del-subgids FIRST-LAST  remove range of subordinate gids
  -Z, --selinux-user SEUSER     new SELinux user mapping for the user account


#-------------------------------------------------

root@a5cca4daea25:~# userdel
Usage: userdel [options] LOGIN

Options:
  -f, --force                   force some actions that would fail otherwise
                                e.g. removal of user still logged in
                                or files, even if not owned by the user
  -h, --help                    display this help message and exit
  -r, --remove                  remove home directory and mail spool
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
      --extrausers              Use the extra users database
  -Z, --selinux-user            remove any SELinux user mapping for the user




# ---------------------------------------------------

# add a ne user
useradd -m john

# check new user account infos
cat /etc/passwd

# outputs:
john:x:1001:1001::/home/john:/bin/sh

# modify user props so that when he logs in he uses 'bash' instead of 'sh'
usermod  -s /bin/bash john

# check new user account infos again
cat /etc/passwd

# outputs
john:x:1001:1001::/home/john:/bin/bash

# check for password
root@a5cca4daea25:~# cat /etc/shadow
root:*:20007:0:99999:7:::
daemon:*:20007:0:99999:7:::
bin:*:20007:0:99999:7:::
sys:*:20007:0:99999:7:::
sync:*:20007:0:99999:7:::
games:*:20007:0:99999:7:::
man:*:20007:0:99999:7:::
lp:*:20007:0:99999:7:::
mail:*:20007:0:99999:7:::
news:*:20007:0:99999:7:::
uucp:*:20007:0:99999:7:::
proxy:*:20007:0:99999:7:::
www-data:*:20007:0:99999:7:::
backup:*:20007:0:99999:7:::
list:*:20007:0:99999:7:::
irc:*:20007:0:99999:7:::
_apt:*:20007:0:99999:7:::
nobody:*:20007:0:99999:7:::
ubuntu:!:20007:0:99999:7:::
john:!:20041:0:99999:7:::


# loging as root with bash: on a new terminal run:
docker exec -it <container_id> bash
docker exec -it a5cca4daea25 bash

# outputs:
root@a5cca4daea25:/#
# ^-- root         ^-- root user prompt

# loging as 'john' with bash: on a new terminal run:

docker exec -it -u <user_name> <container_id> bash
docker exec -it -u john a5cca4daea25 bash

# outputs:
john@a5cca4daea25:/$
# ^-- john         ^-- regular user prompt

# try to access 'shadow' file as a regular user
cat /etc/shadow
cat: /etc/shadow: Permission denied

# user 'john' home direcetory
john@a5cca4daea25:/$ cd ~
john@a5cca4daea25:~$ pwd
/home/john

# if needed remove user 'john' ( don't run it for now !)
userdel john

# NOTE: about different way of adding a user

# used above
useradd 

# a command from 'perl'; kind of update of 'useradd'; adding interactivity
adduser: 

root@a5cca4daea25:~# adduser --help

adduser [--uid id] [--firstuid id] [--lastuid id]
        [--gid id] [--firstgid id] [--lastgid id] [--ingroup group]
        [--add-extra-groups] [--encrypt-home] [--shell shell]
        [--comment comment] [--home dir] [--no-create-home]
        [--allow-all-names] [--allow-bad-names]
        [--disabled-password] [--disabled-login]
        [--conf file] [--extrausers] [--quiet] [--verbose] [--debug]
        user
    Add a normal user

adduser --system
        [--uid id] [--group] [--ingroup group] [--gid id]
        [--shell shell] [--comment comment] [--home dir] [--no-create-home]
        [--conf file] [--extrausers] [--quiet] [--verbose] [--debug]
        user
   Add a system user

adduser --group
        [--gid ID] [--firstgid id] [--lastgid id]
        [--conf file] [--extrausers] [--quiet] [--verbose] [--debug]
        group
addgroup
        [--gid ID] [--firstgid id] [--lastgid id]
        [--conf file] [--extrausers] [--quiet] [--verbose] [--debug]
        group
   Add a user group

addgroup --system
        [--gid id]
        [--conf file] [--extrausers] [--quiet] [--verbose] [--debug]
        group
   Add a system group

adduser [--extrausers] USER GROUP
   Add an existing user to an existing group


# ----

john@a5cca4daea25:~$ adduser bob   
fatal: Only root may add a user or group to the system.

# ----

root@a5cca4daea25:~# adduser bob   
info: Adding user `bob' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `bob' (1002) ...
info: Adding new user `bob' (1002) with group `bob (1002)' ...
info: Creating home directory `/home/bob' ...
info: Copying files from `/etc/skel' ...
New password: 
Retype new password: 
passwd: password updated successfully
Changing the user information for bob
Enter the new value, or press ENTER for the default
	Full Name []: Bob Smith
	Room Number []: 1001
	Work Phone []: +33148421292
	Home Phone []: +33177122334
	Other []: bob.smith@gmail.com
Is the information correct? [Y/n] y
info: Adding new user `bob' to supplemental / extra groups `users' ...
info: Adding user `bob' to group `users' ...
root@a5cca4daea25:~# 


# check inputs for bob:

cat /etc/passwd # check the last line
bob:x:1002:1002:Bob Smith,1001,+33148421292,+33177122334,bob.smith@gmail.com:/home/bob:/bin/bash


# 14. Managing Group
# --------------------

groupadd
Usage: groupadd [options] GROUP

Options:
  -f, --force                   exit successfully if the group already exists,
                                and cancel -g if the GID is already used
  -g, --gid GID                 use GID for the new group
  -h, --help                    display this help message and exit
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -o, --non-unique              allow to create groups with duplicate
                                (non-unique) GID
  -p, --password PASSWORD       use this encrypted password for the new group
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DI        directory prefix
  -U, --users USERS             list of user members of this group
      --extrausers              Use the extra users database

# --------------------

groupmod
Usage: groupmod [options] GROUP

Options:
  -a, --append                  append the users mentioned by -U option to the group 
                                without removing existing user members
  -g, --gid GID                 change the group ID to GID
  -h, --help                    display this help message and exit
  -n, --new-name NEW_GROUP      change the name to NEW_GROUP
  -o, --non-unique              allow to use a duplicate (non-unique) GID
  -p, --password PASSWORD       change the password to this (encrypted)
                                PASSWORD
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -U, --users USERS             list of user members of this group

# --------------------

groupdel
Usage: groupdel [options] GROUP

Options:
  -h, --help                    display this help message and exit
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -f, --force                   delete group even if it is the primary group of a user
      --extrausers              Use the extra users database


# ---------

# let's add a new group

groupadd developers

# check group added
cat /etc/group

# outputs
...
...
users:x:100:bob
nogroup:x:65534:
ubuntu:x:1000:
john:x:1001:
bob:x:1002:
developers:x:1003:


# now let's add the user 'john' to the supplementary 'developers' group 

usermod 
Usage: usermod [options] LOGIN

Options:
  -a, --append                  append the user to the supplemental GROUPS
                                mentioned by the -G option without removing
                                the user from other groups
  -b, --badname                 allow bad names
  -c, --comment COMMENT         new value of the GECOS field
  -d, --home HOME_DIR           new home directory for the user account
  -e, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -f, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -g, --gid GROUP               force use GROUP as new primary group
  -G, --groups GROUPS           new list of supplementary GROUPS
  -h, --help                    display this help message and exit
  -l, --login NEW_LOGIN         new value of the login name
  -L, --lock                    lock the user account
  -m, --move-home               move contents of the home directory to the
                                new location (use only with -d)
  -o, --non-unique              allow using duplicate (non-unique) UID
  -p, --password PASSWORD       use encrypted password for the new password
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -r, --remove                  remove the user from only the supplemental GROUPS
                                mentioned by the -G option without removing
                                the user from other groups
  -R, --root CHROOT_DIR         directory to chroot into
  -s, --shell SHELL             new login shell for the user account
  -u, --uid UID                 new UID for the user account
  -U, --unlock                  unlock the user account
  -v, --add-subuids FIRST-LAST  add range of subordinate uids
  -V, --del-subuids FIRST-LAST  remove range of subordinate uids
  -w, --add-subgids FIRST-LAST  add range of subordinate gids
  -W, --del-subgids FIRST-LAST  remove range of subordinate gids
  -Z, --selinux-user SEUSER     new SELinux user mapping for the user account


usermod -G developers john

# check the /etc/passwd
cat /etc/passwd | grep john

# OR
grep john /etc/passwd

# also to see all group run:
cat /etc/group


# add a new user and add he in the supplementary 'developers' group too

adduser mike
info: Adding user `mike' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `mike' (1004) ...
info: Adding new user `mike' (1004) with group `mike (1004)' ...
info: Creating home directory `/home/mike' ...
info: Copying files from `/etc/skel' ...
New password: 
Retype new password: 
passwd: password updated successfully
Changing the user information for mike
Enter the new value, or press ENTER for the default
	Full Name []: Mike Tyson
	Room Number []: 102
	Work Phone []: +33132435465
	Home Phone []: +31876545432
	Other []: mike-tyson@gamil.com
Is the information correct? [Y/n] y
info: Adding new user `mike' to supplemental / extra groups `users' ...
info: Adding user `mike' to group `users' ...

# add user 'mike' to 'developers' group
usermod -G developers mike

# check group list

cat /etc/group

# outputs
...
...
users:x:100:bob
nogroup:x:65534:
ubuntu:x:1000:
john:x:1001:
bob:x:1002:
developers:x:1003:john,mike
mike:x:1004:

# another way to check user in a group

groups john
john : john developers
#       ^--1    ^-- 2
# 1 : for primary group
# 2 : for supplementery group 

# add 'john' to a new 'artist' group

groupadd artist



# 15. File permission
# ---------------------

# append to a new file:
echo echo hello > deploy.sh

# check
cat echo.sh

# check permission for this file, from the home dir.
ls -l
total 16
drwxr-x--- 2 bob  bob  4096 Nov 14 21:44 bob
-rw-r--r-- 1 root root   11 Nov 14 22:23 deploy.sh
drwxr-x--- 2 john john 4096 Nov 14 21:20 john
drwxr-x--- 2 mike mike 4096 Nov 14 22:07 mike

# try to execute 'deploy.sh'
./deploy.sh

# outputs 
bash: ./deploy.sh: Permission denied

# update permissions for user
chmod u+x deploy.sh

# check again
ls -l
total 16
drwxr-x--- 2 bob  bob  4096 Nov 14 21:44 bob
-rwxr--r-- 1 root root   11 Nov 14 22:23 deploy.sh
drwxr-x--- 2 john john 4096 Nov 14 21:20 john
drwxr-x--- 2 mike mike 4096 Nov 14 22:07 mike


# then execute 'deploy.sh'
./deploy.sh
hello

# try to execute 'deploy.sh' as user 'john'
john@a5cca4daea25:/home$ ./deploy.sh
bash: ./deploy.sh: Permission denied

# from the terminal of 'root', give the executable authorization to 'other' users
chmod o+x deploy.sh

# check:

ls -l
total 16
drwxr-x--- 2 bob  bob  4096 Nov 14 21:44 bob
-rwxr--r-- 1 root root   11 Nov 14 22:23 deploy.sh
drwxr-x--- 2 john john 4096 Nov 14 21:20 john
drwxr-x--- 2 mike mike 4096 Nov 14 22:07 mike


# from user 'john' terminal, execute 'deploy.sh'
./deploy.sh
hello

# other possible 'chmod' combination
chmod og+x+w-r deploy.sh
chmod og+x+w-r *.sh
etc
