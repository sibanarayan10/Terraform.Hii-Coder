#!/bin/bash

#################
# Author: Sibanarayan Choudhury
# Date: 23/09/26
# Version: 1.0.0
#################

set -euo pipefail

echo "Updating packages..."
sudo apt update

echo "Installing Docker..."
sudo apt install -y docker.io

sudo systemctl enable --now docker

sudo usermod -aG docker "$USER"

echo "Installing Nginx..."
sudo apt install -y nginx

echo "Copying Nginx configuration..."

sudo cp ./core-service.conf /etc/nginx/sites-available/hiicoders

echo "Enabling Nginx configuration..."

sudo ln -s /etc/nginx/sites-available/hiicoders \
           /etc/nginx/sites-enabled/hiicoders

echo "Removing default Nginx configuration..."

sudo rm -f /etc/nginx/sites-enabled/default

echo "Testing Nginx configuration..."

sudo nginx -t

echo "Reloading Nginx..."

sudo systemctl reload nginx

echo "Setup completed successfully."


