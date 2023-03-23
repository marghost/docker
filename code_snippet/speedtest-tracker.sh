#!/bin/bash

# Install Speedtest Tracker
docker volume create speedtest_tracker_data
chmod -R 777 ./speedtest_tracker_data
docker run -d -p 8080:80 -p 8443:443 -e PUID=1001 -e PGID=1001 --name=speedtest-tracker --restart=always -v speedtest_tracker_data:/config ajustesen/speedtest-tracker
chmod -R 701 ./speedtest_tracker_data
echo "Good Speedtest Tracker installed"