#!/usr/bin/env bash
sudo apt-get install git -y
git config --global user.name "TheStrix"
git config --global user.email "parthbhatia98@gmail.com"
echo Setting ssh, enter password if you want to set one
ssh-keygen -t rsa
echo Your public ssh key is
echo
echo
cat ~/.ssh/id_rsa.pub
