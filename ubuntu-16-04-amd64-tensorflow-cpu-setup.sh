#!/bin/bash

# Setup for an Ubuntu 16.04 amd64 VM in azure to be able
# to work with TensorFlow using only on the CPU.
echo 'setting up '$(hostname)

# Install the Azure CLI 2.0 (via apt-get)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install -y apt-transport-https
sudo apt-get update && sudo apt-get install -y azure-cli

# Install Pip, Pydev and TensorFlow 1.2.0
echo 'setting up the python environment'
sudo apt-get install -y python-pip python-dev virtualenv
sudo pip install --upgrade pip
echo 'setting up tensorflow (for CPU only) 1.2.0'
sudo pip install tensorflow==1.2.0

# Setup complete.
echo 'finished setting up'$(hostname)