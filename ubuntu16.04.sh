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

# COLORS

RCol='\e[0m'    # Text Reset
# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';


clear
echo "${Red}Installing Dependencies!${RCol}"
sudo apt update -y
sudo apt install git-core python gnupg flex bison gperf libsdl1.2-dev libesd0-dev \
squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-8-jre openjdk-8-jdk pngcrush \
schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev \
gcc-multilib liblz4-* pngquant ncurses-dev texinfo gcc gperf patch libtool figlet \
automake g++ gawk subversion expat libexpat1-dev python-all-dev bc libcloog-isl-dev \
libcap-dev autoconf libgmp-dev build-essential gcc-multilib g++-multilib pkg-config libmpc-dev libmpfr-dev lzma* \
liblzma* w3m android-tools-adb maven ncftp htop -y
echo "${Red}Dependencies have been installed${RCol}"
echo "${Red}repo has been Downloaded!${RCol}"
if [ ! "$(which adb)" == "" ];
then
echo "${Red}Setting up USB Ports${RCol}"
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules
sudo chmod 644   /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
sudo service udev restart
adb kill-server
sudo killall adb
fi

echo "${Red}Configuring repo${RCol}"
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo "${Red}Setting up dotfiles${RCol}"
cd ~/dotfiles/
./setupdotfiles


echo -n "${Red}Do you wish to source new bashrcadditions (y/n)? ${RCol}"
read answer
if echo "$answer" | grep -iq "^y" ;then
    source ~/bashrcadditions.sh
else
    echo
fi

echo -n "${Red}Do you wish sync LineageOS and breakfast kenzo and hydrogen? (y/n)${RCol}"
read answer
if echo "$answer" | grep -iq "^y" ;then
    mkdir ~/lineage
    cd ~/lineage
    repo init -u git://github.com/LineageOS/android.git -b cm-14.1
    syncc -j12
    . build/envsetup.sh
    echo "${Red}syncing kenzo and hydrogen trees${RCol}"
    breakfast kenzo
    breakfast hydrogen
    echo "${Red}syncing xiaomi vendor${RCol}"
    git clone git@github.com:TheMuppets/proprietary_vendor_xiaomi.git -b cm-14.1 ~/lineage/vendor/xiaomi

    echo -n "${Red}Install ImageMagic? (y/n)${RCol}"
    read answer
    if echo "$answer" | grep -iq "^y" ;then
        echo "${Red}Installing ImageMagic from source (https://www.imagemagick.org/script/install-source.php)${RCol}"
        cd ~/
        wget "https://www.imagemagick.org/download/ImageMagick.tar.gz"
        tar xvzf ImageMagick.tar.gz
        rm ImageMagick.tar.gz
        ./configure
        make -j16
        sudo make install
        sudo ldconfig /usr/local/lib
        echo "${Red}Deleting ImageMagick*${RCol}"
        rm -rf ImageMagick*
    fi
else
    echo
fi
