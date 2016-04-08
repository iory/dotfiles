#!/bin/sh -eu

VIM_HOME=$HOME/.vim

[ ! -d $VIM_HOME ] && mkdir $VIM_HOME

# if [ ! -e $VIM_HOME/nerdtree ]
# git clone https://github.com/scrooloose/nerdtree.git ~/.vim

if [ ! -e $VIM_HOME/vim-hybrid ]; then
   git clone git@github.com:w0ng/vim-hybrid.git $VIM_HOME/vim-hybrid
   ln -sf $VIM_HOME/vim-hybrid/colors $VIM_HOME/colors
fi
