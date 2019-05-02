#!/bin/bash -v
apt update

#Install HAproxy
apt install -y curl git haproxy 

#Stop HAproxy sevice
service haproxy stop

#Install Apache
apt install -y apache2

#Generate self-signed certificate with Apache
a2enmod ssl
service restart apache2
openssl req -x509 -nodes -days 500 -newkey rsa:2048 -keyout /tmp/dbwebintf.key -out /tmp/dbwebintf.crt
cat /tmp/dbwebintf.crt /tmp/dbwebintf.key > /etc/ssl/private/dbweb-intf.pem
chmod 600 /etc/ssl/private/dbweb-intf.pem

#Uninstall Apache
apt purge apache2 -y

#Clone PLED repoistory
git clone https://github.com/amojamo/PLED /home/ubuntu/pled

#Give clone some time, before copying the HAproxy config
sleep 5
cp /home/ubuntu/pled/config/haproxy.cfg /etc/haproxy/
service haproxy start

