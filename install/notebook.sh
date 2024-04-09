#!/bin/bash

# Install Python and pip (if not already installed)
sudo apt update
sudo apt install -y python3 python3-pip

# Install Jupyter Notebook using pip
pip3 install jupyter

# Optionally, create a directory to store notebooks
mkdir -p ~/jupyter_notebooks

# Optionally, configure Jupyter Notebook settings (e.g., specify notebook directory)
# jupyter notebook --generate-config
# sed -i "s|#c.NotebookApp.notebook_dir = ''|c.NotebookApp.notebook_dir = '~/jupyter_notebooks'|g" ~/.jupyter/jupyter_notebook_config.py

# Start Jupyter Notebook and capture port and access token
port=$(jupyter notebook list | grep -oP '(?<=http://127.0.0.1:)\d+')
token=$(jupyter notebook list | grep -oP '(?<=token=)[0-9a-f]+')

# Display port and access token to the terminal
echo "Jupyter Notebook has been installed and started."
echo "Access it at: http://127.0.0.1:$port/?token=$token"
