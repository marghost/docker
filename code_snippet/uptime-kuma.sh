#!/bin/bash

# Install Uptime Kuma
docker volume create uptime_kuma_data
docker run -d -p 3001:3001 --name=uptime-kuma --restart=always -v uptime_kuma_data:/app/data louislam/uptime-kuma
echo "Update Kuma installed"