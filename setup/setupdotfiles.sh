#!/bin/bash

for f in ~/.bashrc; do
    echo "Adding customrcadditions to ~/.bashrc"
    [ -e "$f" ] && sed -i "1 i\source ~/.dotfiles/customrcadditions" ~/.bashrc || sudo sed -i "1 i\source ~/customrcadditions" /etc/bash.bashrc
    break
done
