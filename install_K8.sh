#!/bin/bash
# This is only to be used as a prep for a non Pure Test Drive Environment
# Brian Kuebler 4/17/20
# Bruce Modell 7/22/20
# Chris Crow 7/22/20

# Install necessary packages, only python2 installed

echo "#####################################"

#remove password requirement for sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
export DEBIAN_FRONTEND=noninteractive

echo "####  installing updates latest ansible/purestorage"
sudo apt-get update

sudo apt-get install ansible --assume-yes
sudo apt-get install python3-pip --assume-yes
echo "#### use pip3 to install purestorage"
pip3 install purestorage


echo "#### Installing the Purestorage Ansible Collection  ####"

ansible-galaxy collection install purestorage.flasharray


echo '#install Iscsi-tools'
sudo apt-get install open-iscsi --assume-yes

echo '#Install Multipath tools'
sudo apt-get install multipath-tools --assume-yes

echo '#install scsi tools'
sudo apt-get install -y scsitools --assume-yes



# Typing "ansible-playbook" everytime is a hassle...
echo "" >> ~/.bashrc
echo "alias ap='ansible-playbook'" >> ~/.bashrc
echo "alias P='cd ~/newstack_demo/ansible_playbooks'" >> ~/.bashrc


