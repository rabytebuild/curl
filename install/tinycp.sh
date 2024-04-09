#!/bin/bash

# Set your desired username and password
TINYCP_USER="admin"
TINYCP_PASS="Rabiu2004@"

# Set TinyCP port (optional)
TINYCP_PORT="3003"

# Add TinyCP repository key
sudo apt install -y gnupg ca-certificates
sudo apt-key adv --fetch-keys http://repos.tinycp.com/ubuntu/conf/gpg.key

# Add TinyCP repository based on chosen version (Stable or Nightbuild)
# For Stable version
sudo echo "deb http://repos.tinycp.com/ubuntu all main" | sudo tee /etc/apt/sources.list.d/tinycp.list

# For Nightbuild version
# sudo echo "deb http://repos.tinycp.com/ubuntu all nightbuild" | sudo tee /etc/apt/sources.list.d/tinycp.list

# Update package lists
sudo apt-get update -y

# Install TinyCP without any interaction
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y tinycp

# Configure TinyCP with predefined username and password
sudo sed -i "s|TINYCP_USER=\"admin\"|TINYCP_USER=\"$TINYCP_USER\"|g" /etc/tinycp/config
sudo sed -i "s|TINYCP_PASS=\"secretpass\"|TINYCP_PASS=\"$TINYCP_PASS\"|g" /etc/tinycp/config

# Restart TinyCP service to apply changes
sudo service tinycp restart

# Optionally, display installation completion message
echo "TinyCP has been installed with username '$TINYCP_USER' and password '$TINYCP_PASS'."
