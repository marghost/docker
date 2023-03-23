#!/bin/bash

# Install Speedtest Tracker
docker volume create speedtest_tracker_data
chmod -R 777 /var/lib/docker/volumes/speedtest_tracker_data/_data
docker run -d -p 8080:80 -p 8443:443 -e PUID=1001 -e PGID=1001 --name=speedtest-tracker --restart=always -v speedtest_tracker_data:/config ajustesen/speedtest-tracker
sleep 15s
chmod -R 701 /var/lib/docker/volumes/speedtest_tracker_data/_data
echo "Updated speedtest Tracker installed"
echo "Dont forget default username : admin@example.com password : password"