#!/bin/bash

echo "Installing zsh"

# Install ZSH
if [[ ! -z $(which apt-get)  ]]; then
	sudo apt-get install zsh -y
elif [[ ! -z $(which pacaur) ]]; then
	pacaur -S zsh zsh-completions
elif [[ ! -z $(which pacman) ]]; then
	sudo pacman -S zsh zsh-completions
else
	echo "cannot detect package manager"
	exit 1
fi

if [[ -e /bin/zsh ]]; then
	chsh -s /bin/zsh
elif [[ -e /usr/bin/zsh ]]; then
	chsh -s /usr/bin/zsh
else
	echo "cannot find zsh binary path"
	exit 1
fi

# Install oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
env zsh
echo "Installing zsh-autosuggestions..."
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions

for f in ~/.zshrc; do
    echo "Adding customrcadditions to ~/.zshrc"
    [ -e "$f" ] && sed -i "1 i\source ~/.dotfiles/customrcadditions" ~/.zshrc
    break
done
for f in ~/.zshrc; do
    echo "Adding zshrc.local to ~/.zshrc"
    [ -e "$f" ] && sed -i "1 i\source ~/.dotfiles/zshrc.local" ~/.zshrc
    break
done

if [[ -f ~/.dotfiles/zshrc.local ]]; then
    echo -e "Deleting 'ZSH_THEME' and 'plugins' var from ~/.zshrc\nUse from ~/.dotfiles/zshrc.local"
    sed -i '/ZSH_THEME=/d' ~/.zshrc
    sed -i '/plugins=/d' ~/.zshrc
fi
