#!/bin/bash

# Step 1: Install essential utilities
sudo apt install wget nano vim zip tar -y

# Install openssh-server package
# apt install -y openssh-server

# Enable root login and password authentication
# sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Restart SSH service
# sudo service ssh restart
echo Start Finished 
