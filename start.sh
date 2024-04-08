#!/bin/bash

# Step 1: Update package lists
apt update -y

# Step 2: Install sudo
apt install sudo -y

# Step 3: Add user 'root' to sudo group
adduser root sudo

# Step 4: Install curl
sudo apt install curl -y

# Step 5: Install essential utilities
sudo apt install wget nano vim zip tar -y

# Step 6: Download and extract ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xvf ngrok-v3-stable-linux-amd64.tgz

# Step 7: Authenticate ngrok
./ngrok authtoken 2Hd7yeF4INCKbg2aP9rGMLnDqBX_5K7WhATjW8eUxS6UoHSRa

# Step 8: Install ttyd
sudo apt install ttyd -y

# Step 9: Start ttyd server
nohup ttyd -p 8090 bash &

# Step 10: Start ngrok HTTP tunnel
nohup ./ngrok http 8090 &
