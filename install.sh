#!/bin/bash -e

black-echo() { echo "$(tput setaf 0)$*$(tput setaf 9)"; }
red-echo() { echo "$(tput setaf 1)$*$(tput setaf 9)"; }
green-echo() { echo "$(tput setaf 2)$*$(tput setaf 9)"; }
yellow-echo() { echo "$(tput setaf 3)$*$(tput setaf 9)"; }
blue-echo() { echo "$(tput setaf 4)$*$(tput setaf 9)"; }
magenta-echo() { echo "$(tput setaf 5)$*$(tput setaf 9)"; }
cyan-echo() { echo "$(tput setaf 6)$*$(tput setaf 9)"; }
white-echo() { echo "$(tput setaf 7)$*$(tput setaf 9)"; }

function error {
    red-echo "Error occured"
    trap - ERR
    exit 1
}

trap error ERR

current_working_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

:  "install dotfiles" && {
    [ ! -d ${HOME}/.dotfiles ] && git clone https://github.com/iory/dotfiles.git ~/.dotfiles
}

: "vim install" && {
    VIM_HOME=$HOME/.vim

    [ ! -d $VIM_HOME ] && mkdir $VIM_HOME

    # if [ ! -e $VIM_HOME/nerdtree ]
    # git clone https://github.com/scrooloose/nerdtree.git ~/.vim

    if [ ! -e $VIM_HOME/vim-hybrid ]; then
        git clone http://github.com/w0ng/vim-hybrid.git $VIM_HOME/vim-hybrid
        ln -sf $VIM_HOME/vim-hybrid/colors $VIM_HOME/colors
    fi

    ln -sf `pwd`/.vimrc $HOME/.vimrc
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | bash

    mkdir -p $HOME/.config/nvim
    ln -sf `pwd`/nvim/dein $HOME/.config/dein
    ln -sf `pwd`/nvim/init.vim $HOME/.config/nvim/init.vim
}

: "set zsh" && {
    ZDOTDIR=$current_working_directory
    mkdir $ZDOTDIR/zsh/plugins -p
    cd $ZDOTDIR/zsh/plugins -p
    [ ! -d zsh-syntax-highlighting ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    [ ! -d zsh-autosuggestions ] && git clone https://github.com/zsh-users/zsh-autosuggestions.git
    [ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
}

: "symbolic link for dotfiles" && {
    cd $current_working_directory
    for f in .??*; do
        [[ "$f" == ".git" ]] && continue
        [[ "$f" == ".DS_Store" ]] && continue
        [[ "$f" == ".travis.yaml" ]] && continue

        echo "$f"
        ln -sf `pwd`/"$f" ~/"$f"
    done
    bash $current_working_directory/config/install.sh
}

: "symbolic link to bin" && {
    mkdir -p $HOME/.local/bin
    for f in $HOME/.dotfiles/bin/*; do
        echo "$f" "->" $HOME/.local/bin/$(basename "$f")
        ln -sf "$f" $HOME/.local/bin/$(basename $f)
    done
}

: "ipython settings" && {
    if [ ! -e $HOME/.ipython/profile_default/startup ]; then
        mkdir -p $HOME/.ipython/profile_default/startup
    fi
    ln -sf $current_working_directory/ipython-settings/00-first.py ~/.ipython/profile_default/startup/00-first.py
}
