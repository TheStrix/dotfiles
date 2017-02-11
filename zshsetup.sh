#!/bin/bash

echo "Installing zsh"
sudo apt-get install zsh
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
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

echo "COMMENT OUT 'ZSH_THEME' and 'plugins' from .zshrc for themes to work from zshrc.local!"

#!/usr/bin/env zsh
echo "Installing zsh-autosuggestions..."
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Installing spaceship-zsh-theme..."
curl -o - https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/install.sh | zsh
