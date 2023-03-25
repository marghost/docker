#!/bin/bash

echo "Please enter your puid/pgid:"
read puid

docker volume create heimdall

docker run -d --name=heimdall -e PUID=$puid -e PGID=$puid -e TZ=America/New_York -p 80:80 -p 443:443 -v heimdall:/config --restart unless-stopped lscr.io/linuxserver/heimdall:latest