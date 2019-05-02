#!/bin/bash -v
apt update
apt install -y curl git

#Installing Docker and Docker-Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#Clone PLED repository
git clone https://github.com/amojamo/PLED /home/ubuntu/pled

#Mount attached backup volume
mkdir /backup
mkfs -t ext4 /dev/vdb
mount -t ext4 /dev/vdb /backup

#Adding cronjob for backup of DreamFactory
crontab -l > customcron
echo "0 0 * * * /usr/bin/ssh ubuntu@192.168.180.103 '/bin/bash /home/ubuntu/pled/config/backup_dfvol.sh'" >> customcron
crontab -u ubuntu customcron

#Adding cronjob for backup of MongoDB
crontab -l | { cat; echo "* * * * * /usr/bin/mongodump --username root --password poot --authenticationDatabase admin --host 192.168.180.108 --port 27017 --db pled --forceTableScan -o /backup/mongodb_$(date +\%Y_\%m_\%d) --gzip
"; } | crontab -