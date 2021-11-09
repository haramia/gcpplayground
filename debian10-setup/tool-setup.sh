# This script installs Docker and Helm on the Debian 10 VM.

#!/bin/bash

#General update
sudo apt update
sudo apt upgrade -y

#Install base tools
sudo apt install -y \
  apt-transport-https \
  ca-certificates \
  gnupg \
  lsb-release \
  mc

#Install Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $(ls /home/)

# Install Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -

echo "deb https://baltocdn.com/helm/stable/debian/ all main" | \
sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

sudo apt update
sudo apt install -y helm
