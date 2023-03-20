#!/bin/bash

# Install Docker
sudo apt-get update
sudo apt-get install -y docker.io

# Add current user to docker group
sudo usermod -aG docker $(whoami)

# Prompt for usernames and passwords
echo "Please enter a username for Portainer, Uptime Kuma, Speedtest Tracker, Yacht, and Transmission-OpenVPN:"
read username
echo "Please enter a password for Portainer, Uptime Kuma, Speedtest Tracker, Yacht, and Transmission-OpenVPN:"
read -s password
echo "Please enter your NordVPN username:"
read nordvpn_username
echo "Please enter your NordVPN password:"
read -s nordvpn_password

# Install Portainer
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -e "ADMIN_PASSWORD=$password" -e "ADMIN_USERNAME=$username" portainer/portainer-ce

# Install Uptime Kuma
sudo docker volume create uptime_kuma_data
sudo docker run -d -p 3000:3000 --name=uptime-kuma --restart=always -v uptime_kuma_data:/app/data -v /var/run/docker.sock:/var/run/docker.sock -e "SERVER_USER=$username" -e "SERVER_PASSWORD=$password" uptimekuma/uptime-kuma

# Install Speedtest Tracker
sudo docker volume create speedtest_tracker_data
sudo docker run -d -p 5000:5000 --name=speedtest-tracker --restart=always -v speedtest_tracker_data:/app/data -e "USERNAME=$username" -e "PASSWORD=$password" ajustesen/speedtest-tracker

# Install Yacht Docker
sudo docker volume create yacht_data
sudo docker run -d -p 8001:8000 --name=yacht --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v yacht_data:/config -e "YACHT_USERNAME=$username" -e "YACHT_PASSWORD=$password" selfhostedpro/yacht:latest

# Install Transmission-OpenVPN with NordVPN using a SOCKS5 proxy in Canada
sudo docker volume create transmission_config
sudo docker volume create transmission_downloads
sudo docker run -d --name=transmission-openvpn --privileged --restart=always --cap-add=NET_ADMIN --device=/dev/net/tun -v transmission_config:/config -v transmission_downloads:/downloads -e "OPENVPN_PROVIDER=NORDVPN" -e "OPENVPN_USERNAME=$nordvpn_username" -e "OPENVPN_PASSWORD=$nordvpn_password" -e "OPENVPN_OPTS=--inactive 3600" -e "LOCAL_NETWORK=192.168.0.0/16" -e "OPENVPN_SOCKS_PROXY=proxy.nordvpn.com:1080" -e "OPENVPN_SOCKS_PROXY_USERNAME=$nordvpn_username" -e "OPENVPN_SOCKS_PROXY_PASSWORD=$nordvpn_password" -e "OPENVPN_CONFIG=ca519-udp.proxy-nl.serverlocation.co.ovpn" haugene/transmission-openvpn

echo "Docker, Portainer, Uptime Kuma, Speedtest Tracker, Yacht, and Transmission-OpenVPN with NordVPN using a SOCKS5 proxy in Canada have been successfully installed!"

# Set DNSStubListener option to "no"
sudo sed -i 's/#DNSStubListener=.*/DNSStubListener=no/' /etc/systemd/resolved.conf

# Restart systemd-resolved service
sudo systemctl restart systemd-resolved.service

echo "DNSStubListener is now set to 'no', systemd-resolved no longer binds to port 53"


# Create Docker volume for Pi-hole
sudo docker volume create pihole

# Create Pi-hole Docker container with user-specified credentials
sudo docker run -d \
  --name pihole \
  -e TZ=America/New_York \
  -e WEBPASSWORD=$password \
  -v pihole:/etc/pihole \
  -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
  -p 53:53/tcp \
  -p 53:53/udp \
  -p 8088:80 \
  -p 4438:443 \
  --restart=unless-stopped \
  --dns=127.0.0.1 \
  --dns=1.1.1.1 \
  pihole/pihole:latest

# Create Docker volume for filebrowser
sudo docker volume create filebrowser

# Install Filebrowser Docker container
echo "Installing Filebrowser Docker container..."
sudo docker run -d --name filebrowser \
    -p 8080:80 \
    -v /:/srv \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v filebrowser:/srv/filebrowser \
    --restart=always \
    --user $(id -u):$(id -g) \
    --env "FILEBROWSER_USERNAME=$username" \
    --env "FILEBROWSER_PASSWORD=$password" \
    --env "FILEBROWSER_SCOPE=/srv" \
    --env "FILEBROWSER_ALLOW_COMMANDS=true" \
    --env "FILEBROWSER_NO_AUTH=true" \
    filebrowser/filebrowser:latest

# Set permissions for all Docker volumes
echo "Setting permissions for all Docker volumes..."
for VOLUME in $(sudo docker volume ls -q)
do
    VOLUME_PATH=$(sudo docker volume inspect --format '{{ .Mountpoint }}' $VOLUME)
    sudo setfacl -R -m u:$(id -u):rwx $VOLUME_PATH
done

echo "Done! Filebrowser Docker container is now running."

# Create Heimdall volume
sudo docker volume create heimdall_data

# Install Heimdall Docker container
echo "Installing Heimdall Docker container..."
sudo docker run -d --name=heimdall \
    -p 80:80 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v heimdall_data:/config \
    --restart=always \
    linuxserver/heimdall

# Get list of running Docker containers
echo "Retrieving list of running Docker containers..."
CONTAINERS=$(sudo docker ps --format "{{.Names}}")

# Generate Docker container links for Heimdall
echo "Generating Docker container links for Heimdall..."
DOCKER_LINKS="{\"name\":\"Docker\",\"icon\":\"fa fa-docker\",\"color\":\"btn-secondary\",\"badge\":{\"variant\":\"light\",\"text\":\"$CONTAINERS\"},\"menu\":{\"links\":["

for CONTAINER in $CONTAINERS
do
    CONTAINER_IP=$(sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER)
    DOCKER_LINKS+="{\"name\":\"$CONTAINER\",\"url\":\"http://$CONTAINER_IP\",\"icon\":\"fa fa-box\"},"
done

DOCKER_LINKS=${DOCKER_LINKS::-1} # Remove trailing comma
DOCKER_LINKS+="]}}"

# Write Docker container links to Heimdall config file
echo "Writing Docker container links to Heimdall config file..."
sudo docker exec heimdall sed -i "s/\"links\":\[\]/$DOCKER_LINKS/" /config/config.json

echo "Done! Heimdall Docker container is now running with Docker container links added."
