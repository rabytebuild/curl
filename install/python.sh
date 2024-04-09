#!/bin/bash

# Update package lists
sudo apt update

# Install Python and pip
sudo apt install -y python3 python3-pip

# Install additional Python packages as needed
pip3 install numpy pandas matplotlib scipy scikit-learn jupyter

# Optionally, display a message indicating that Python installation is complete
echo "Python installation with pip and additional packages is complete."
