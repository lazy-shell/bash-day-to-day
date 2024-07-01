#!/bin/bash

# Function to remove MySQL on Debian-based systems
remove_mysql_debian() {
    echo "Stopping MySQL service..."
    sudo systemctl stop mysql

    echo "Uninstalling MySQL packages..."
    sudo apt-get remove --purge -y mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*

    echo "Removing MySQL configuration and data directories..."
    sudo rm -rf /etc/mysql /var/lib/mysql

    echo "Removing residual configuration files..."
    sudo apt-get autoremove -y
    sudo apt-get autoclean -y

    echo "MySQL has been removed from the system."
}

# Function to remove MySQL on Red Hat-based systems
remove_mysql_redhat() {
    echo "Stopping MySQL service..."
    sudo systemctl stop mysqld

    echo "Uninstalling MySQL packages..."
    sudo yum remove -y mysql-server mysql

    echo "Removing MySQL configuration and data directories..."
    sudo rm -rf /etc/my.cnf /var/lib/mysql

    echo "Removing residual configuration files..."
    sudo yum autoremove -y

    echo "MySQL has been removed from the system."
}

# Detecting the type of distribution
if [ -f /etc/debian_version ]; then
    echo "Debian-based system detected."
    remove_mysql_debian
elif [ -f /etc/redhat-release ]; then
    echo "Red Hat-based system detected."
    remove_mysql_redhat
else
    echo "Unsupported Linux distribution."
    exit 1
fi
