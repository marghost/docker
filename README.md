# Docker Install script

Docker installation command.  Tested on ubuntu lts 22.04.

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
A backup of this specific version of get-docker.sh is available inside the snippet directory.

# Container installation scripts

List of individual installation methods of some containers I use.

## Portainer
Install portainer inside docker.  (Docker version 23.0.1)
```
#Get install script from my repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/install-portainer.sh -o install-portainer.sh
#Install
sudo sh install-portainer.sh
```
## Uptime Kuma
Install Uptime Kuma inside docker.  (Docker version 23.0.1)
```
#Get install script from my repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/uptime-kuma.sh -o uptime-kuma.sh
#Install
sudo sh uptime-kuma.sh
```

## Speedtest-Tracker
Install Speedtest-Tracker inside docker.  (Docker version 23.0.1)
```
#Get install script from my repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/speedtest-tracker.sh -o speedtest-tracker.sh
#Install
sudo sh speedtest-tracker.sh
```
Note : In the current version (as of 2023-03-22) we need to adjust the perm when we install the container.  See install script for more details.


# Unified installation of docker and containers
WIP
