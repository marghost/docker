# Docker
How to install docker.  Tested on ubuntu lts 22.04.
```
#Get install script from docker repo
curl -fsSL get.docker.com -o get-docker.sh
#Test the script before the install
sudo sh ./get-docker.sh --dry-run
#Install
sudo sh get-docker.sh
#Update & Upgrade
sudo apt-get update && sudo apt-get upgrade
```
# Portainer
Install portainer inside docker.  (Docker version 23.0.1)
```
#Get install script from docker repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/install-portainer.sh -o install-portainer.sh
#Install
sudo sh install-portainer.sh
```
# Uptime Kuma
Install Uptime Kuma inside docker.  (Docker version 23.0.1)
```
#Get install script from docker repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/uptime-kuma.sh -o uptime-kuma.sh
#Install
sudo sh uptime-kuma.sh
```