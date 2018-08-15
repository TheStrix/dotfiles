#!/usr/bin/env bash

for f in ~/.bashrc; do
    echo "Adding local functions to ~/.bashrc"
    [ -e "$f" ] && sed -i "1 i\onLogin" ~/.bashrc || sudo sed -i "1 i\onLogin" /etc/bash.bashrc
    [ -e "$f" ] && sed -i "1 i\source ~/.dotfiles/functions" ~/.bashrc || sudo sed -i "1 i\source ~/.dotfiles/functions" /etc/bash.bashrc
    break
done
