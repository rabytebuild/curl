#!/bin/bash

# Download ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz

# Extract ngrok
tar -xvf ngrok-v3-stable-linux-amd64.tgz

# Authenticate ngrok
./ngrok authtoken 2Hd7yeF4INCKbg2aP9rGMLnDqBX_5K7WhATjW8eUxS6UoHSRa

# Prompt user to select between http and tcp
echo "Select option for tunnel type:"
select tunnel_type in "http" "tcp"; do
    case $tunnel_type in
        http )
            break;;
        tcp )
            break;;
        * )
            echo "Invalid option. Please select 1 for http or 2 for tcp.";;
    esac
done

# Prompt user to enter port number
read -p "Enter port number: " port_number

# Start ngrok with the selected option and port number
./ngrok $tunnel_type $port_number
