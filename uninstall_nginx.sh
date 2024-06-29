#!/bin/bash

# Stop the Nginx service
echo "Stopping Nginx service..."
sudo systemctl stop nginx

# Uninstall Nginx
echo "Uninstalling Nginx..."
sudo apt remove -y nginx nginx-common

# Purge Nginx
echo "Purging Nginx..."
sudo apt purge -y nginx nginx-common

# Remove unnecessary dependencies
echo "Removing unnecessary dependencies..."
sudo apt autoremove -y

# Remove Nginx directories and files
echo "Removing Nginx directories and files..."
sudo rm -rf /etc/nginx
sudo rm -rf /var/log/nginx
sudo rm -rf /var/lib/nginx
sudo rm -rf /var/www/html

# Verify removal
if ! command -v nginx &> /dev/null; then
    echo "Nginx has been successfully removed."
else
    echo "Nginx removal failed or Nginx is still present."
fi
