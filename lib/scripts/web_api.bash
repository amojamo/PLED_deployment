#!/bin/bash -v
apt update
apt install -y curl git

#Installing Docker and Docker-Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#Clone PLED repoistory
git clone https://github.com/amojamo/PLED /home/ubuntu/pled

#Mount attached data volume
mkdir /bitnami
mkfs -t ext4 /dev/vdb
mount -t ext4 /dev/vdb /bitnami

#Chwon folder in preparation for Bitnami Docker Image
sudo chown -R 1001:1001 /bitnami

#Create the needed volumes for Docker
docker volume create --driver local --opt type=ext4 --opt device=/dev/vdc dreamfactory_data
docker volume create --driver local --opt type=ext4 --opt device=/dev/vdc redis_data
docker volume create --driver local --opt type=ext4 --opt device=/dev/vdc mariadb_data
docker volume create --driver local --opt type=ext4 --opt device=/dev/vdc mongodb_data

#Start DreamFactory with docker-compose
docker-compose -f /home/ubuntu/pled/docker/docker-compose-df.yml up -d

#Couldn't connect to Docker daemon at http+docker://localhost - is it running?