#!/bin/bash

# Install Uptime Kuma
sudo docker volume create uptime_kuma_data
sudo docker run -d -p 3000:3000 --name=uptime-kuma --restart=always -v uptime_kuma_data:/app/data -v /var/run/docker.sock:/var/run/docker.sock uptimekuma/uptime-kuma
echo "Update Kuma installed"