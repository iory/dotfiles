#!/bin/bash

ZDOTDIR=$HOME/.dotfiles/.zsh
mkdir $ZDOTDIR/plugins
cd $ZDOTDIR/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
