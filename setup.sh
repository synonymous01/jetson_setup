#!/bin/bash

# Update package list
sudo apt-get update

# Install essential packages
sudo apt-get install -y build-essential git dkms

# Clone the rtl8188fu repository
git clone https://github.com/kelebek333/rtl8188fu

# Add, build, and install the driver using DKMS
sudo dkms add ./rtl8188fu
sudo dkms build rtl8188fu/1.0
sudo dkms install rtl8188fu/1.0

# Copy firmware file
sudo cp ./rtl8188fu/firmware/rtl8188fufw.bin /lib/firmware/rtlwifi/

# Create modprobe configuration file
sudo mkdir -p /etc/modprobe.d/
echo "options rtl8188fu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/rtl8188fu.conf

# Download and run ROS Noetic installation script
wget -c https://raw.githubusercontent.com/qboticslabs/ros_install_noetic/master/ros_install_noetic.sh
chmod +x ./ros_install_noetic.sh
./ros_install_noetic.sh

source ~/.bashrc

# Install Python 3 pip and robomaster library
sudo apt-get install -y python3-pip
python3 -m pip install --upgrade pip
pip3 install scipy numpy
pip3 install cvxopt
pip3 install opencv-python
pip3 install robomaster

# Clone and install VS Code
git clone https://github.com/JetsonHacksNano/installVSCode.git
cd installVSCode
./installVSCode.sh
