#!/bin/bash

# Installation doc : https://haugene.github.io/docker-transmission-openvpn/provider-specific/

echo "Please enter your NordVPN username:"
read nordvpn_username
echo "Please enter your NordVPN password:"
read nordvpn_password

# Install Transmission-OpenVPN with NordVPN using a SOCKS5 proxy in Canada
docker volume create transmission_config
docker volume create transmission_downloads
docker run -d --name=transmission-openvpn -p 9091:9091 --log-driver json-file --log-opt max-size=10m --privileged --restart=always --cap-add=NET_ADMIN --device=/dev/net/tun -v transmission_config:/config -v transmission_downloads:/downloads -e "OPENVPN_USERNAME=$nordvpn_username" -e "OPENVPN_PASSWORD=$nordvpn_password" -e "OPENVPN_PROVIDER=NORDVPN" -e "NORDVPN_CATEGORY=legacy_p2p" -e "LOCAL_NETWORK=10.22.0.0/16" -e "NORDVPN_COUNTRY=CA" -e "NORDVPN_PROTOCOL=tcp" haugene/transmission-openvpn

echo "Transmission-OpenVPN with NordVPN using a SOCKS5 proxy in Canada have been successfully installed!"
