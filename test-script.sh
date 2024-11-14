#!/bin/bash


sudo -i
apt-get update
apt-get install nginx -y
echo "This is automated code" /tmp/test.txt 
echo "this is from test-script file" > /var/www/html/index.nginx-debian.html
