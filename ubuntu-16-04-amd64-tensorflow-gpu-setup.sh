#!/bin/bash

# Setup for an Ubuntu 16.04 amd64 VM in azure to be able
# to work with TensorFlow using only on the CPU.
echo 'setting up '$(hostname)

# Set up the locale.
# NOTA: looks like Ubuntu VM in Azure have some problems
# with locale out-of-the-box.
echo 'export LC_ALL=C' >> ~/.bashrc
source ~/.bashrc

# Install the Azure CLI 2.0 (via apt-get)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install -y apt-transport-https
sudo apt-get update && sudo apt-get install -y azure-cli

# Install CUDA 8.0
wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo dpkg -i cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo apt-get update
sudo apt-get install -y cuda
rm cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb

# Install CuDNN 5.1
wget http://developer.download.nvidia.com/compute/redist/cudnn/v5.1/cudnn-8.0-linux-x64-v5.1.tgz
sudo tar -xzf cudnn-8.0-linux-x64-v5.1.tgz -C /usr/local
rm cudnn-8.0-linux-x64-v5.1.tgz
sudo ldconfig

# Setup environment variables in .bashrc
echo 'export CUDA_HOME=/usr/local/cuda-8.0' >> ~/.bashrc
echo 'export PATH=${CUDA_HOME}/bin:${PATH}'  >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:/usr/local/cuda/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc
source ~/.bashrc

# Install Pip, Pydev and TensorFlow-GPU 1.2.0
echo 'setting up the python environment'
sudo apt-get install -y python-dev libxml2-dev libxslt-dev
sudo apt-get install -y python3-dev
sudo apt-get install -y virtualenv
sudo apt-get install -y python-pip
sudo pip install --upgrade pip
echo 'setting up tensorflow (for GPU) 1.2.0'
sudo pip install tensorflow-gpu==1.2.0

# Setup complete.
echo 'finished setting up' $(hostname)
