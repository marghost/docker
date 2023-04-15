#!/bin/bash

# Installation doc : https://hub.docker.com/r/dgtlmoon/changedetection.io

# Create the volume for Speedtest Tracker
docker volume create changedetection-datastore-volume

# Install Speedtest Tracker
docker run -d --restart always -p 5000:5000 -v changedetection-datastore-volume:/datastore --name changedetection.io dgtlmoon/changedetection.io

echo "Changedetection.io Installed"
