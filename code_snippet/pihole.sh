#!/bin/bash

echo "Please enter your pihole web password:"
read password
echo "Please enter your local ip address : "
read publicip

echo "Free the port 53 from ubuntu"

# Set DNSStubListener option to "no"
sed -i 's/#DNSStubListener=.*/DNSStubListener=no/' /etc/systemd/resolved.conf

# Restart systemd-resolved service
systemctl restart systemd-resolved.service

echo "DNSStubListener is now set to 'no', systemd-resolved no longer binds to port 53"


# Create Docker volume for Pi-hole
docker volume create pihole

# Create Pi-hole Docker container with user-specified credentials
docker run -d --name pihole -e TZ=America/New_York -e WEBPASSWORD=$password -e FTLCONF_LOCAL_IPV4=$publicip -v pihole:/etc/pihole -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" -p 53:53/tcp -p 53:53/udp -p 8088:80 -p 4438:443 --restart=unless-stopped --dns=127.0.0.1 --dns=1.1.1.1 pihole/pihole:latest
echo "Pihole installed"