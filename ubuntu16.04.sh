#!/bin/bash
#
# Copyright � 2015-2016, Akhil Narang "akhilnarang" <akhilnarang.1999@gmail.com>
# Copyright (C) 2017. Parth Bhatia "TheStrix" <parthbhatia98@gmail.com>
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it
#

# Colors
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
purple='\e[0;35m'
brown='\e[0;33m'
lightgray='\e[0;37m'
darkgray='\e[1;30m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'
lightcyan='\e[1;36m'
lightred='\e[1;31m'
lightpurple='\e[1;35m'
yellow='\e[1;33m'
white='\e[1;37m'
nc='\e[0m'

clear
echo -e "${yellow}Installing Dependencies!${nc}"
sudo apt update -y
sudo apt install git-core python gnupg flex bison gperf libsdl1.2-dev libesd0-dev \
squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-8-jre openjdk-8-jdk pngcrush \
schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32ncurses5-dev \
gcc-multilib liblz4-* pngquant ncurses-dev texinfo gcc gperf patch libtool figlet \
automake g++ gawk subversion expat libexpat1-dev python-all-dev bc libcloog-isl-dev \
libcap-dev autoconf libgmp-dev build-essential gcc-multilib g++-multilib pkg-config libmpc-dev libmpfr-dev lzma* \
liblzma* w3m android-tools-adb maven ncftp htop -y
echo "${yellow}Installing ninja 1.7.2, please make sure your ROM includes the commit to use host ninja"
sudo install utils/ninja /usr/local/bin/
echo "${yellow}Installing ccache from source"
git clone git@github.com:ccache/ccache.git ~/ccache && cd ~/ccache && ./autogen.sh && ./configure && make
sudo cp ccache /usr/local/bin/
cd ~/.dotfiles
sudo ln -s ccache /usr/local/bin/gcc
sudo ln -s ccache /usr/local/bin/g++
sudo ln -s ccache /usr/local/bin/cc
sudo ln -s ccache /usr/local/bin/c++
ccache -V
echo "${yellow} ccache install completed... Deleting leftover installation files"
rm -rf ~/ccache
echo -e "${yellow}Dependencies have been installed${nc}"
echo -e "${yellow}repo has been Downloaded!${nc}"
if [ ! "$(which adb)" == "" ];
then
echo -e "${yellow}Setting up USB Ports${nc}"
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules
sudo chmod 644   /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
sudo service udev restart
adb kill-server
sudo killall adb
fi

echo -e "${yellow}Configuring repo${nc}"
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo -e "${yellow}Setting up dotfiles${nc}"
cd ~/.dotfiles/
./setupdotfiles


echo -ne "${yellow}Do you wish to source new bashrcadditions (y/n)?${nc}"
read answer
if echo -e "$answer" | grep -iq "^y" ;then
    source ~/.dotfiles/customrcadditions
else
    echo
fi
