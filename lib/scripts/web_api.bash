#!/bin/bash -v
apt update
apt install -y curl git

#Installing Docker and Docker-Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

git clone REPO /home/ubuntu/

#Mount attached backup volume
mkdir /backup
mkfs -t ext4 /dev/vdb
mount -t ext4 /dev/vdb /backup

docker-compose -f /home/ubuntu/pled/docker/docker-compose-df.yml up -d