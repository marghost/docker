#!/bin/bash

# Installation doc : https://docs.speedtest-tracker.dev/getting-started/installation

# Create the volume for Speedtest Tracker
docker volume create speedtest_tracker_data

# Need to adjust perm to install the container.  Ref : https://github.com/alexjustesen/speedtest-tracker/issues/498
chmod -R 777 /var/lib/docker/volumes/speedtest_tracker_data/_data

# Install Speedtest Tracker
docker run -d -p 8080:80 -p 8443:443 -e PUID=1001 -e PGID=1001 --name=speedtest-tracker --restart=always -v speedtest_tracker_data:/config ajustesen/speedtest-tracker

# Wait for the DB setup before adjusting perms on the volume
sleep 15s

# Ajust permissions back when the db is created
chmod -R 701 /var/lib/docker/volumes/speedtest_tracker_data/_data

echo "Updated speedtest Tracker installed"
echo "Dont forget to change default username : admin@example.com password : password"