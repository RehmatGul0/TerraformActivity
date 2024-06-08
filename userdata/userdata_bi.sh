#!/bin/bash

# Installing Nginx, Docker and Node 20 via teraform userdata

# Update the package list
sudo apt-get update -y

# Install Nginx
sudo apt-get install -y nginx
sudo systemctl start nginx # start the Nginx service
sudo systemctl enable nginx # enable Nginx to start on boot


# Install Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common
# Then add the GPG key for the official Docker repository to your system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# This will also update our package database with the Docker packages from the newly added repo.
# Make sure you are about to install from the Docker repo instead of the default Ubuntu repo
sudo apt-get update -y
# installing docke-ce
sudo apt-get install -y docker-ce
sudo systemctl start docker # start the Docker service
sudo systemctl enable docker # enable Docker to start on boot

# Pull the latest Metabase Docker image
sudo docker pull metabase/metabase:latest