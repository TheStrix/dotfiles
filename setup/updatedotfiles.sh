#!/bin/bash

cd ~/bin
shopt -s extglob
rm !(repo)

cd ~/.dotfiles
cp -R bin/* $HOME/bin/.