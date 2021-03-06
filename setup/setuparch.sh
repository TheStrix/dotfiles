#!/usr/bin/env bash

# Script to setup an android build environment on Arch Linux and derivative distributions

clear
echo Installing Dependencies!

# Update
sudo pacman -Syyu

# Import PGP signatures for ncurses5-compat-libs and lib32-ncurses5-compat-libs
gpg --recv-keys 702353E0F7E48EDB

# Install packages for building android
yaourt -S bc bison ccache curl flex gcc-multilib git gnupg gperf jdk8-openjdk lib32-gcc-libs lib32-ncurses \
lib32-ncurses5-compat-libs lib32-readline lib32-zlib libxslt ncurses ncurses5-compat-libs \
perl-switch python2-virtualenv repo rsync schedtool sdl squashfs-tools unzip wxgtk zip zlib \
ffmpeg imagemagick lzop ninja pngcrush xml2 gradle maven cpio --noconfirm

# Export JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk

# Just a couple of other useful tools I use, others do too probably
yaourt -S hub neofetch fortune-mod figlet gvfs-mtp --noconfirm

# Setup dotfiles
echo -e "${yellow}Setting up dotfiles${nc}"
mkdir ~/bin
PATH=~/bin:$PATH
. $HOME/.dotfiles/setup/setupdotfiles.sh

# Source functions
source ~/.dotfiles/functions

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
