#!/bin/bash

# Step 1: Install essential utilities
sudo apt install wget nano vim zip tar -y

# Install openssh-server package
apt install -y openssh-server

# Enable root login and password authentication
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Restart SSH service
service ssh restart

# Download the latest release of ttyd
TTYD_VERSION=$(wget -qO- https://api.github.com/repos/tsl0922/ttyd/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
wget https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.x86_64 -O /usr/local/bin/ttyd

# Make ttyd executable
chmod +x /usr/local/bin/ttyd

# Check if ttyd installation was successful
if command -v ttyd &>/dev/null; then
    echo "ttyd is installed successfully."
    # Step 9: Start ttyd server
    nohup ttyd -p 8080 bash &
else
    echo "Failed to install ttyd."

# Step 6: Download and extract ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xvf ngrok-v3-stable-linux-amd64.tgz

# Step 7: Authenticate ngrok
./ngrok authtoken 2Hd7yeF4INCKbg2aP9rGMLnDqBX_5K7WhATjW8eUxS6UoHSRa


# Step 10: Start ngrok HTTP tunnel
nohup ./ngrok http 8080 &
