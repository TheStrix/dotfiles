#------------------------------------///
# CUSTOM BASHRC SHIT
#------------------------------------///

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

function upinfo ()
{
echo -ne "${yellow}$(hostname) ${lightred}uptime is ${lightblue} \t ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
}

#------------------------------------------////
# System Information:
#------------------------------------------////
clear
echo -e "${LIGHTGRAY}";figlet "TheStrix";
echo ""
echo -ne "${lightred}Today is:\t\t${lightblue}" `date`; echo ""
echo -e "${lightred}Kernel Information: \t${lightblue}" `uname -smr`
echo -ne "${cyan}";upinfo;echo ""

#------------------------------------------///
# EXPORTS:
#------------------------------------------///
export KBUILD_BUILD_USER=ParthB
export USE_CCACHE=1

#------------------------------------------////
# ALIAS:
#------------------------------------------////
alias shutdown='sudo shutdown -P now'
alias gtcp='git cherry-pick'
alias grev='git revert'
alias node1='ssh parthb@104.236.248.224'
alias node3='ssh parth@198.199.71.201'
alias yufastboot='fastboot -i 0x2A96'
alias kernelarm64='export ARCH=arm64 && export CROSS_COMPILE=~/cm/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-'

# LOGs
alias kenzologcat='adb shell logcat > ~/Desktop/rn3log/log.txt'
alias kenzoradiologcat='adb shell logcat -b radio > ~/Desktop/rn3log/radio.txt'
alias kenzodmesg='adb shell dmesg > ~/Desktop/rn3log/dm.txt'
alias kenzodenial="adb shell dmesg | grep -a 'avc: ' > ~/Desktop/rn3log/denial.txt"

alias hydrogenlogcat='adb shell logcat > ~/Desktop/maxlog/log.txt'
alias hydrogenradiologcat='adb shell logcat -b radio > ~/Desktop/maxlog/radio.txt'
alias hydrogendmesg='adb shell dmesg > ~/Desktop/maxlog/dm.txt'
alias hydrogendenial="adb shell dmesg | grep -a 'avc: ' > ~/Desktop/maxlog/denial.txt"
