#!/usr/bin/env bash

echo "Installing zsh"

# Install ZSH
if [[ -z $(which zsh) ]]; then
	if [[ ! -z $(which apt-get)  ]]; then
		sudo apt-get install zsh -y
	elif [[ ! -z $(which yaourt) ]]; then
		yaourt -S zsh zsh-completions --noconfirm
	elif [[ ! -z $(which pacman) ]]; then
		sudo pacman -S zsh zsh-completions --noconfirm
	else
		echo "cannot detect any known package manager"
		exit 1
	fi
fi

# Set zsh as default shell
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

# ZSH autosuggestions
echo "Installing zsh-autosuggestions..."
zsh -c 'git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions'

for f in ~/.zshrc; do
    echo "Adding local functions, zshrc.local to ~/.zshrc"
    [ -e "$f" ] && sed -i "1 i\onLogin" ~/.zshrc
    [ -e "$f" ] && sed -i "1 i\source ~/.dotfiles/functions" ~/.zshrc
    [ -e "$f" ] && sed -i "1 i\source ~/.dotfiles/zshrc.local" ~/.zshrc
    break
done

if [[ -f ~/.dotfiles/zshrc.local ]]; then
    #echo -e "Deleting 'ZSH_THEME' and 'plugins' var from ~/.zshrc\nUsed from ~/.dotfiles/zshrc.local"
    #sed -i '/ZSH_THEME=/d' ~/.zshrc
    #sed -i '/plugins=/d' ~/.zshrc

    echo -e "Delete ZSH_THEME' and 'plugins' var from ~/.zshrc\nUsed from ~/.dotfiles/zshrc.local"
fi

# Hub zsh_completion
echo -e "Setting hub zsh completion..."
mkdir -p ~/.zsh/completions
cp ~/.dotfiles/hub/etc/hub.zsh_completion ~/.zsh/completions/_hub
