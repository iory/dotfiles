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

for i in "$@"
do
    case $i in
        --python)
            INSTALL_PYTHON=1
            shift # past argument=value
            ;;
        *)
            # unknown option
            ;;
    esac
done

DOTFILES_DIRECTORY=$HOME/.dotfiles
:  "install dotfiles" && {
    [ ! -d ${HOME}/.dotfiles ] && git clone https://github.com/iory/dotfiles.git $DOTFILES_DIRECTORY
}

: "set zsh" && {
    ZDOTDIR=$DOTFILES_DIRECTORY
    mkdir $ZDOTDIR/zsh/plugins -p
    cd $ZDOTDIR/zsh/plugins -p
    [ ! -d zsh-syntax-highlighting ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    [ ! -d zsh-autosuggestions ] && git clone https://github.com/zsh-users/zsh-autosuggestions.git
    [ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
}

: "symbolic link for dotfiles" && {
    green-echo "symbolic link for dotfiles"
    cd $DOTFILES_DIRECTORY
    for f in .??*; do
        [[ "$f" == ".git" ]] && continue
        [[ "$f" == ".DS_Store" ]] && continue
        [[ "$f" == ".travis.yaml" ]] && continue
        [ -z "$PYTHON_INSTALL" ] && [[ "$f" == ".ipython" ]] && continue
        [ -z "$PYTHON_INSTALL" ] && [[ "$f" == ".jupyter" ]] && continue

        echo `pwd`/"$f" "->" ~/"$f"
        ln -sfh `pwd`/"$f" ~/"$f"
    done

    green-echo "symbolic link for .config files"
    for f in config/??*; do
        echo `pwd`/"$f" "->" ~/.config/$(basename "$f")
        ln -sfh `pwd`/"$f" ~/.config/$(basename "$f")
    done
}

: "vim settings install" && {
    cd /tmp
    wget -q https://raw.githubusercontent.com/colepeters/spacemacs-theme.vim/master/colors/spacemacs-theme.vim
    mkdir -p $HOME/.config/nvim/colors
    mkdir -p $HOME/.vim/colors
    cp spacemacs-theme.vim $HOME/.config/nvim/colors/
    cp spacemacs-theme.vim $HOME/.vim/colors/
    rm -rf spacemacs-theme.vim
}

: "symbolic link for bin" && {
    green-echo "symbolic link for bin"
    mkdir -p $HOME/.local/bin
    for f in $HOME/.dotfiles/bin/*; do
        echo "$f" "->" $HOME/.local/bin/$(basename "$f")
        ln -sfh "$f" $HOME/.local/bin/$(basename $f)
    done
}

: "install jupyter extentions" && [ -n "$INSTALL_PYTHON" ] && {
    green-echo "install jupyter extentions"
    if type jupyter >/dev/null 2>&1; then
        mkdir -p $(jupyter --data-dir)/nbextensions
        if [ ! -d $(jupyter --data-dir)/nbextensions/vim_binding ]; then
            git clone https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding
        else
            (cd $(jupyter --data-dir)/nbextensions/vim_binding && git pull)
        fi
        jupyter nbextension enable vim_binding/vim_binding
    else
        red-echo 'jupyter not found\!';
        red-echo 'try to install jupyter.';
        red-echo 'pip install jupyter';
    fi
}
