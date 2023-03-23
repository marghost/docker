#!/bin/bash

# Install Speedtest Tracker
docker volume create speedtest_tracker_data
docker run -d -p 8080:80 -p 8443:443 -e PUID=1000 -e PGID=1000 --name=speedtest-tracker --restart=always -v speedtest_tracker_data:/app/data ajustesen/speedtest-tracker
echo "Good Speedtest Tracker installed"