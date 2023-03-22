# docker
How to install docker inside must distro
```
#Get install script from docker repo
curl -fsSL get.docker.com -o get-docker.sh
#Test the script before the install
sudo sh ./get-docker.sh --dry-run
#Install
sudo sh get-docker.sh
#Update
sudo apt-get update && upgrade
```
