# Install Transmission-OpenVPN with NordVPN using a SOCKS5 proxy in Canada
docker volume create transmission_config
docker volume create transmission_downloads
docker run -d --name=transmission-openvpn -p 9091:9091 --log-driver json-file --log-opt max-size=10m --privileged --restart=always --cap-add=NET_ADMIN --device=/dev/net/tun -v transmission_config:/config -v transmission_downloads:/downloads -e "OPENVPN_PROVIDER=NORDVPN" -e "OPENVPN_OPTS=--inactive 3600" -e "LOCAL_NETWORK=10.22.0.0/16" -e "OPENVPN_SOCKS_PROXY=proxy.nordvpn.com:1080" haugene/transmission-openvpn

echo "Transmission-OpenVPN with NordVPN using a SOCKS5 proxy in Canada have been successfully installed!"
