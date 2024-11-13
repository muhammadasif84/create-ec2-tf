#!/bin/bash

sudo -i
apt-get update
apt-get install nginx -y
echo "This is UserData installation code" >/var/www/html/index.nginx-debian.html