#!/bin/bash

#If needed to clean previous install
sudo apt-get remove docker docker-ce docker-engine docker.io containerd runc

# Update packages
sudo apt-get update

# Install Docker dependancies
sudo apt-get install ca-certificate curl gnupg lsb-release apt-transport-https gnupg-agent


#Add docker repo
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu | $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group
sudo usermod -aG docker $(whoami)
