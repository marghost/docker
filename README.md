# Docker Install script

Docker installation and container configuration notes.  Tested on ubuntu lts 22.04.

```
#Get install script from docker repo
curl -fsSL get.docker.com -o get-docker.sh

#Test the script before the install
sudo sh ./get-docker.sh --dry-run

#Install
sudo sh get-docker.sh

#Update & Upgrade
sudo apt-get update && sudo apt-get upgrade

#add user to docker group
sudo usermod -aG docker $(whoami)
```
A backup of this specific version of get-docker.sh is available inside the snippet directory.

# Container installation scripts

List of installation methods and notes for container I use.

## Portainer
Install portainer inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/install-portainer.sh -o install-portainer.sh
#Install
sudo sh install-portainer.sh
```
## Uptime Kuma
Install Uptime Kuma inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/uptime-kuma.sh -o uptime-kuma.sh
#Install
sudo sh uptime-kuma.sh
```

## Speedtest-Tracker
Install Speedtest-Tracker inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/speedtest-tracker.sh -o speedtest-tracker.sh
#Install
sudo sh speedtest-tracker.sh
```
Note : In the current version (as of 2023-03-22) we need to adjust the perm when we install the container.  See install script for more details.

## Yacht
Install Yacht inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/yacht.sh -o yacht.sh
#Install
sudo sh yacht.sh
```
The templates for one click install inside Yacht can be found there : https://raw.githubusercontent.com/SelfhostedPro/selfhosted_templates/yacht/Template/template.json. 
You can add it manually in yacht template page.

## Transmission-Openvpn
Install Transmission-Openvpn inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/transmission-openvpn.sh -o transmission-openvpn.sh
#Install
sudo sh transmission-openvpn.sh
```
Dont forget to edit "LOCAL_NETWORK=X.X.0.0/16" variable to make the docker accessible.

### EDITH 2023-07-17
If you use Nordvpn : 
You need to generate the credentials needed by openvpn.  To do that you need to login to nordvpn website.  Then go to Services > Nordvpn.
Scroll to the "manual install" section.  
Click on the "manual nordvpn config" button.
Save the generated login and password.

## Pihole
Install pihole inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/pihole.sh -o pihole.sh
#Install
sudo sh pihole.sh
```

## Heimdall
Install heimdall inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/heimdall.sh -o heimdall.sh
#Install
sudo sh heimdall.sh
```

## LittleLink
Install littlelink inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/littlelink.sh -o littlelink.sh
#Install
sudo sh littlelink.sh
```

## Changedetection.io
Install changedetection inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/changedetection.sh -o changedetection.sh
#Install
sudo sh changedetection.sh
```
### SMTP email notification configuration
Here is a simple configuration using mailjet.
```
mailtos://username:password@domain.com?smtp=in-v3.mailjet.com&from=me@domain.com&to=X@gmail.com,Y@hotmail.com
```

## Rustdesk
Install rustdesk inside docker.  (Docker version 23.0.1)
```
#Get install script from this repo
curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/rustdesk.sh -o rustdesk.sh
#Install
sudo sh rustdesk.sh
```

## Shlink
### Requirement
We will shift things up and use docker compose for this one.  First of all create a directory to put the required files.
```
sudo mkdir -p /opt/shlink/db_data/
```
Download required files
```
#Get install script from this repo
sudo curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/shlink/shlink.sh -o /opt/shlink/shlink.sh
sudo curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/shlink/docker-compose.yml -o /opt/shlink/docker-compose.yml
```
### Edit docker-compose.yml file
Now open the downloaded docker-compose.yml file and edit the variables identified between the "<>"
```
#Edit docker-compose.yml
sudo nano /opt/shlink/docker-compose.yml
```

<DEFAULT_DOMAIN>: Select domain through which the Shlink instance will be accessible

<IS_HTTPS_ENABLED>: If needed, as I will front the service with cloudflare, it's not needed in my case I will set it to false

<GEOLITE_LICENSE_KEY>: Get a Geolite license key (www.maxmind.com)

<DB_PASSWORD>: Setup a secure password

<MARIADB_ROOT_PASSWORD>: Setup a secure password

<8888>: Choose a port to access the service from the web

### Install
```
#Install
cd /opt/shlink
sudo sh /opt/shlink/shlink.sh
```
Source : https://community.hetzner.com/tutorials/install-shlink-docker

## Shlink Web GUI
Now that the core system is installed, we will install the web GUI so we can control our instance.  Note that this step is not necessary, you could access your instance with https://app.shlink.io/

Before we setup the docker, we need to generate an api-key by running this command
```
docker exec -it shlink_shlink_1 shlink api-key:generate
```
Save the generated API key

Now we are going to download the Shlink web GUI script
```
#Get install script from this repo
sudo curl -fsSL raw.githubusercontent.com/marghost/docker/main/code_snippet/shlink-web-gui.sh -o shlink-web-gui.sh
```

Then edit those variables inside shlink-web-gui.sh : 

<SERVER_URL>: Your server url with the prefix "https://<URL>"

<GENERATED_API_KEY>: The API key we just generated


We are ready to install the image, we can do so by executing 
```
sudo sh shlink-web-gui.sh
```
The install is now complete!

# Firewall and Cloudflare Zero Trust (free)

## Firewall
Now let's set a secure way to access docker containers from the internet.  First I would suggest to setup a firewall and grant limited access to the environment hosting the docker service.  You could use ufw on ubuntu or could use firewall provided by cloud provider (NSG/Azure Firewall).

## Create Cloudflare account
Then you can create a free tier cloudflare account and use cloudflare zero trust "access" function to create a secure tunnel to reach your docker containers.  (https://one.dash.cloudflare.com)  

## Basic tunnel setup instructions
2023-04-19 : Better way to set the tunnel up (by installing cloudflared directly on the Ubuntu 22.04 server) : 
1. Go to the newly created account https://one.dash.cloudflare.com/
2. Then go to : access > Tunnels > + Create a tunnel
3. Select a tunnel name and then Save tunnel
4. Choose Debian > 64-bit
5. Run the command on your docker server (dont forget to add the TOKEN in the last command) :
```
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install TOKEN
```
6. Create an entry (Public Hostname) (> +Add a public hostname)
7. Add your first service by entering the right url "localhost:XX" (hostname:port)
8. **I strongly suggest you limit access to your public container with MFA**
9. Go to Access > Applications > +Add an application > Self-hosted
10. Inside Self-hosted section go to the create additional rules subsection, then select email and add your personnal email
11. (Optional) If self-signed certificate is used on the service go to Additional application settings > TLS > No TLS Verify.

~~The docker run command is then generated by cloudflare, dont forget the -d attribute before you execute the command on the docker server.  You will also need to setup a dns to use this service.~~
~~You need to use the docker private bridged address when setting up the tunnel.~~
~~If you use https with a self signed certificate, you need to go to Additional application settings > TLS > No TLS Verify.~~
~~Ref. : https://www.youtube.com/watch?v=5oJK4qG0Ll4~~

# Unified installation of docker and containers
WIP
