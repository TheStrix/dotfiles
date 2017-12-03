#!/usr/bin/env bash

# Script to setup an android build environment on Arch Linux and derivative distributions

clear
echo Installing Dependencies!
# Update
sudo pacman -Syyu
# Install pacaur
sudo pacman -S pacaur
# Downgrade curl for now
#pacaur -S agetpkg-git --noconfirm
#agetpkg --install curl 7.55.1 1
#sudo sed -i '/\[options\]/a IgnorePkg = curl' /etc/pacman.conf
# Import PGP signatures for ncurses5-compat-libs and lib32-ncurses5-compat-libs
gpg --recv-keys 702353E0F7E48EDB
# Install aosp-devel (and lineageos-devel because quite a few probably build Lineage/Lineage based ROMs as well.
pacaur -S aosp-devel lineageos-devel --noconfirm
# Just a couple of other useful tools I use, others do too probably
pacaur -S hub neofetch fortune-mod figlet --noconfirm

echo "All Done :'D"
echo "Don't forget to run these commands before building, or make sure the python in your PATH is python2 and not python3"
echo "
virtualenv2 venv"

# ADB ports setup
if [ ! "$(which adb)" == "" ];
then
echo -e "${yellow}Setting up USB Ports${nc}"
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules
sudo chmod 644   /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
sudo udevadm control --reload-rules
adb kill-server
sudo killall adb
fi

# Setup dotfiles
echo -e "${yellow}Setting up dotfiles${nc}"
mkdir ~/bin
PATH=~/bin:$PATH
. $HOME/.dotfiles/setup/setupdotfiles.sh

echo -ne "${yellow}Do you wish to source new bashrcadditions (y/n)?${nc}"
read answer
if echo -e "$answer" | grep -iq "^y" ;then
    source ~/.dotfiles/customrcadditions
else
    echo
fi
