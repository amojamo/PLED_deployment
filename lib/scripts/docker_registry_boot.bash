#!/bin/bash -v
apt update
apt install -y curl git

#Installing Docker and Docker-Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#clone git repo with config files
git clone https://github.com/amojamo/PLED.git /home/ubuntu/

#set docker-registry as working directory
cd /home/ubuntu/pled/docker/docker-registry

#create basic credentials
mkdir -p /home/ubuntu/htpasswd_backup
docker run --rm --entrypoint htpasswd registry:2 -Bbn root "poot" >~/htpasswd_backup/htpasswd

#run compose and start registry stack 
docker-compose -f docker-compose.yml -f docker-compose.auth.yml up -d --build

