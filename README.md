# DockerOnSynologyArm64
Install Docker on Synology NAS with ARM64 (Armv8-AArch64) CPU 

## Info before install

- DSM7.0 and above support bridge mode
- During the installation process, you need to enable the SSH function of Synology
- Working directory of docker is **/volume1/@docker**

# SCRIPT INSTALLATION

Execute the command ```sudo -i``` to become sudo

Download the script **install.sh** with the command 
``` wget https://github.com/ypkdani00/docker-on-synology-arm64/raw/main/install.sh```

Launch the script
```
chmod +x install.sh
./install.sh
```

Follow the last point **RUN DOCKER** her below

# MANUAL INSTALLATION

## 1. Check processor architecture

Check the Processor Architecture by ```uname -m``` command, for example, the processor architecture of DS218play is 'aarch64'

## 2. Become sudo

Execute the command ```sudo -i``` to become sudo

## 3. Download docker

Go to the Docker download page ```https://download.docker.com/linux/static/stable/aarch64/```

and replace the download address of the latest version according to the architecture

```curl "https://download.docker.com/linux/static/stable/aarch64/docker-xx.xx.x.tgz" | tar -xz -C /usr/bin --strip-components=1```

here i will use

```curl "https://download.docker.com/linux/static/stable/aarch64/docker-20.10.9.tgz" | tar -xz -C /usr/bin --strip-components=1```

the file unzipped will be placed in **/usr/bin**

## 4. Docker Install

Create the directory

```mkdir -p /volume1/@docker```

Create the config file

```
mkdir -p /etc/docker
```

edit the file with **vi** or **nano**
```
vi /etc/docker/daemon.json
```
```
nano /etc/docker/daemon.json
```

and past the configuration

```
{
  "storage-driver": "vfs",
  "iptables": false,
  "data-root": "/volume1/@docker"
}
```
**/volume1/@docker** is the docker working directory, which can be modified as needed

use **SHIFT Z Z** to save and exit

# Run Docker

Execute the command

```dockerd &```

if will be showed the line **API listen on /var/run/docker.sock** the docker is correctly running, press **CTRL+C** 

Create a scheduled task

Login in the Synology NAS web page and go to: 

```
DSM > Control Panel > Scheduled Tasks
Added > Triggered Tasks > User Defined Scripts
```

```
Task: Event Software
User: root
Event: start
Before mission: none
Run command: dockerd &
```

do a **reboot** of the NAS from the WEB GUI or with the command ```sudo reboot```

wait until the docker container go up, you can re-login with SSH and check this with the command

```
docker ps
```

in the column **STATUS** you need to wait **UP X minutes**, normally it take 2-3min before the docker container be completelly up.


**DONE**
