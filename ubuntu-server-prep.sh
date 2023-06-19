#!/bin/bash
# Please use this script to install the requirements for Ubuntu 22.04 server

sudo apt update -y
sudo apt install -y --no-install-recommends genisoimage make rsync curl vim nginx net-tools

sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
sudo chmod +x /usr/bin/yq
sudo curl -L -o - "https://github.com/vmware/govmomi/releases/latest/download/govc_$(uname -s)_$(uname -m).tar.gz" | sudo tar -C /usr/local/bin -xvzf - govc

# Prepare nginx iso directory
sudo chmod 777 -R /usr/share/nginx/html

# Create new directory /usr/share/nginx/html/iso
sudo mkdir /usr/share/nginx/html/iso
sudo chmod 766 /usr/share/nginx/html/iso

sudo sed -i '/# pass PHP scripts to FastCGI server/i\        location /iso {\n                alias /usr/share/nginx/html/iso/; # directory to list\n                autoindex on;\n        }\n' /etc/nginx/sites-available/default

# Restart nginx
sudo systemctl restart nginx

# Install Ansible
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y

# Use make to execute the tasks

# Copy VMware installation ISO to /usr/share/nginx/html/iso e.g. with WinSCP
