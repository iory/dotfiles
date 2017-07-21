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

current_working_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

:  "install dotfiles" && {
    [ ! -d ${HOME}/.dotfiles ] && git clone https://github.com/iory/dotfiles.git ~/.dotfiles
}

: "vim install" && {
    mkdir -p $HOME/.config/nvim
    ln -sfh `pwd`/nvim/dein $HOME/.config/dein
    ln -sfh `pwd`/nvim/init.vim $HOME/.config/nvim/init.vim
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
    green-echo "symbolic link for dotfiles"
    cd $current_working_directory
    for f in .??*; do
        [[ "$f" == ".git" ]] && continue
        [[ "$f" == ".DS_Store" ]] && continue
        [[ "$f" == ".travis.yaml" ]] && continue
        [ -z "$INSTALL_PYTHON" ] && [[ "$f" == ".ipython" ]] && continue
        [ -z "$INSTALL_PYTHON" ] && [[ "$f" == ".jupyter" ]] && continue

        echo `pwd`/"$f" "->" ~/"$f"
        ln -sfh `pwd`/"$f" ~/"$f"
    done
    bash $current_working_directory/config/install.sh
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
