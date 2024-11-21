#!/bin/bash

sudo -i
apt-get update
apt-get install nginx -y
#echo "This is UserData installation code" >/var/www/html/index.nginx-debian.html





#aws ec2 create-vpc --instance-tenancy "default" --cidr-block "10.0.0.0/16" 