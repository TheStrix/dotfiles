#!/bin/bash

adduser parth
usermod -aG sudo parth
echo -ne "${yellow}Do you have password login for username parth? (grep 'PasswordAuthentication' and change it to 'yes'${nc}"
read answer
if echo -e "$answer" | grep -iq "^y" ;then
	sudo nano /etc/ssh/sshd_config
	sudo systemctl restart sshd
fi
echo -ne "${yellow}login from username "parth" now${nc}"
