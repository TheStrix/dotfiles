#!/bin/bash

echo "Installing zsh"
sudo apt-get install zsh -y
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
env zsh
echo "Installing zsh-autosuggestions..."
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

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
