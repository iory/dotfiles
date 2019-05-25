#!/bin/bash

function git-clone-or-update-with-check () {
    local REPO="$1"
    local DIR="$2"
    if [ ! -d $DIR ]; then
        git clone -q $REPO $DIR
    else
        pushd $DIR
        local repository=${3:-origin}
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            local branch=${4:-$(git rev-parse --abbrev-ref HEAD)}
            echo $repository $branch
            git pull $repository $branch
        else
            local branch=${4:-master}
            git init
            git remote add $repository $REPO
            git pull $repository $branch
        fi
        popd
    fi
}


DOTFILES_DIRECTORY=$HOME/.dotfiles
:  "install dotfiles" && {
    git-clone-or-update-with-check https://github.com/iory/dotfiles.git $DOTFILES_DIRECTORY
}

mkdir ~/.ssh
wget https://github.com/iory.keys -O- -q >> ~/.ssh/authorized_keys
$DOTFILES_DIRECTORY/bin/check-ssh


$DOTFILES_DIRECTORY/install.sh --all --fish-login
$HOME/.linuxbrew/bin/brew install fish
$HOME/.linuxbrew/bin/fish -c brewup
$HOME/.linuxbrew/bin/fish -c cuda-smi
