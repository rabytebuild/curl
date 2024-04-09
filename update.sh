#!/bin/bash

# Update package lists
sudo apt update -y

# Additional tools
sudo apt install -y build-essential  # for compiling software
sudo apt install -y git  # version control system
sudo apt install -y curl  # command line tool for transferring data with URL syntax
sudo apt install -y wget  # command line tool for downloading files from the web
sudo apt install -y unzip  # utility for unpacking zip archives
sudo apt install -y vim  # text editor
sudo apt install -y nano  # text editor
sudo apt install -y htop  # interactive process viewer
sudo apt install -y net-tools  # networking utilities
# sudo apt install -y openssh-server  # secure shell (SSH) server
sudo apt install -y python3  # Python 3 programming language interpreter
sudo apt install -y python3-pip  # Python package installer
sudo apt install -y virtualenv  # tool to create isolated Python environments
# sudo apt install -y default-jre  # default Java Runtime Environment

# Upgrade
sudo apt upgrade -y

#Clean up
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt upgrade -y
