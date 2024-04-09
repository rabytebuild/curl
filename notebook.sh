#!/bin/bash

# Install Jupyter Notebook
python3 -m pip install notebook

# Download and extract ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xvf ngrok-v3-stable-linux-amd64.tgz

# Authenticate ngrok
./ngrok authtoken 2Hd7yeF4INCKbg2aP9rGMLnDqBX_5K7WhATjW8eUxS6UoHSRa

# Start ngrok to expose Jupyter Notebook port
./ngrok http 8888 &

# Start Jupyter Notebook with root access
python3 -m notebook --allow-root
