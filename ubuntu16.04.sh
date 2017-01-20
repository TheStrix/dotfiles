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

clear
echo -e "${yellow}Installing Dependencies!${nc}"
sudo apt update -y
sudo apt install git-core python gnupg flex bison gperf libsdl1.2-dev libesd0-dev \
squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-8-jre openjdk-8-jdk pngcrush \
schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev \
gcc-multilib liblz4-* pngquant ncurses-dev texinfo gcc gperf patch libtool figlet \
automake g++ gawk subversion expat libexpat1-dev python-all-dev bc libcloog-isl-dev \
libcap-dev autoconf libgmp-dev build-essential gcc-multilib g++-multilib pkg-config libmpc-dev libmpfr-dev lzma* \
liblzma* w3m android-tools-adb maven ncftp htop -y
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
cd ~/dotfiles/
./setupdotfiles


echo -ne "${yellow}Do you wish to source new bashrcadditions (y/n)?${nc}"
read answer
if echo -e "$answer" | grep -iq "^y" ;then
    source ~/bashrcadditions.sh
else
    echo
fi

echo -ne "${yellow}Do you wish sync LineageOS and breakfast kenzo and hydrogen? (y/n)${nc}"
read answer
if echo -e "$answer" | grep -iq "^y" ;then
    mkdir ~/lineage
    cd ~/lineage
    repo init -u git://github.com/LineageOS/android.git -b cm-14.1
    syncc -j12
    . build/envsetup.sh
    echo -e "${yellow}syncing kenzo and hydrogen trees${nc}"
    breakfast kenzo
    breakfast hydrogen
    echo -e "${yellow}syncing xiaomi vendor${nc}"
    git clone git@github.com:TheMuppets/proprietary_vendor_xiaomi.git -b cm-14.1 ~/lineage/vendor/xiaomi

    echo -ne "${yellow}Install ImageMagic? (y/n)${nc}"
    read answer
    if echo "$answer" | grep -iq "^y" ;then
        echo -e "${yellow}Installing ImageMagic from source (https://www.imagemagick.org/script/install-source.php)${nc}"
        cd ~/
        wget "https://www.imagemagick.org/download/ImageMagick.tar.gz"
        tar xvzf ImageMagick.tar.gz
        rm ImageMagick.tar.gz
        ./configure
        make -j16
        sudo make install
        sudo ldconfig /usr/local/lib
        echo -e "${yellow}Deleting ImageMagick*${nc}"
        rm -rf ImageMagick*
    fi
else
    echo
fi
