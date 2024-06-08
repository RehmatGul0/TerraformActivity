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
sudo chmod 777 /var/run/docker.sock


# Install Node 20
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Create jenkins custom dockerfile
cat <<EOL > Dockerfile
#Dockerfile
FROM jenkins/jenkins:lts
USER root
RUN mkdir -p /tmp/download && \
 curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz | tar -xz -C /tmp/download && \
 rm -rf /tmp/download/docker/dockerd && \
 mv /tmp/download/docker/docker* /usr/local/bin/ && \
 rm -rf /tmp/download && \
 groupadd -g 999 docker && \
 usermod -aG staff,docker jenkins
USER jenkins
EOL

# Build the docker image using the Dockerfile
docker build -t jenkins-lab .

# Build the docker image 82 is the host port and 8080 is the container port, # 5000 is docker port
sudo docker run -dit --restart=always -p 82:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins-lab