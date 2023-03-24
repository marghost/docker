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

## Yacht
Install Yacht inside docker.  (Docker version 23.0.1)
```
#Get install script from my repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/yacht.sh -o yacht.sh
#Install
sudo sh yacht.sh
```
The templates for one click install inside Yacht can be found there : https://raw.githubusercontent.com/SelfhostedPro/selfhosted_templates/yacht/Template/template.json. 
You can add it manually in yacht template page.

## Transmission-Openvpn
Install Transmission-Openvpn inside docker.  (Docker version 23.0.1)
```
#Get install script from my repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/transmission-openvpn.sh -o transmission-openvpn.sh
#Install
sudo sh transmission-openvpn.sh
```
Dont forget to edit "LOCAL_NETWORK=X.X.0.0/16" variable to make the docker accessible.

## Pihole
Install pihole inside docker.  (Docker version 23.0.1)
```
#Get install script from my repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/pihole.sh -o pihole.sh
#Install
sudo sh pihole.sh
```

# Firewall and Cloudflare Zero Trust (free)

## Firewall
Now let's set a secure way to access docker containers from the internet.  First I would suggest to setup a firewall and grant limited access to the environment hosting the docker service.  

## Create Cloudflare account
Then you can create a free tier cloudflare account and use cloudflare zero trust "access" function to create a secure tunnel through a docker container.  (https://one.dash.cloudflare.com).  You will also need to setup a dns to use this service.  

## Basic tunnel setup instructions
You need to use the docker private bridged address when setting up the tunnel.  

If you use https with a self signed certificate, you need to go to Additional application settings > TLS > No TLS Verify.  

Ref. : https://www.youtube.com/watch?v=5oJK4qG0Ll4

# Unified installation of docker and containers
WIP
