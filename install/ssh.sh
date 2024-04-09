#!/bin/bash

# Update package lists
sudo apt update

# Install SSH server
sudo apt install -y openssh-server

# Enable root login with password authentication
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Disable public key authentication
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication no/' /etc/ssh/sshd_config

# Allow tunneling and TCP forwarding
sudo sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config
sudo sed -i 's/#AllowAgentForwarding yes/AllowAgentForwarding yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitTunnel yes/PermitTunnel yes/' /etc/ssh/sshd_config

# Restart SSH service to apply changes
sudo systemctl restart ssh

# Optionally, display a message indicating that SSH server setup is complete
echo "SSH server has been installed and configured."
