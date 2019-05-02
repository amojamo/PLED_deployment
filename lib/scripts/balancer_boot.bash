#!/bin/bash -v
apt update
apt install -y curl git haproxy 
service haproxy stop
apt install -y apache2
a2enmod ssl
systemctl restart apache2
openssl req -x509 -nodes -days 500 -newkey rsa:2048 -keyout /tmp/dbwebintf.key -out /tmp/dbwebintf.crt
cat /tmp/dbwebintf.crt /tmp/dbwebintf.key > /etc/ssl/private/dbweb-intf.pem
chmod 600 /etc/ssl/private/dbweb-intf.pem

git clone https://github.com/amojamo/PLED /home/ubuntu/

sleep 5
cp /home/ubuntupled/config/haproxy.cfg /etc/haproxy/
service haproxy restart

