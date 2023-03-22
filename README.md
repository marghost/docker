# docker
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
