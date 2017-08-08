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

function git-pull() {
    local repository=${1:-origin}
    local branch=${2:-$(git rev-parse --abbrev-ref HEAD)}
    git pull origin $branch
}

trap error ERR

for i in "$@"
do
    case $i in
        --fish)
            INSTALL_FISH=1
            shift # past argument=value
            ;;
        --fish-login)
            INSTALL_FISH=1
            INSTALL_FISH_LOGIN=1
            shift # past argument=value
            ;;
        --python)
            INSTALL_PYTHON=1
            shift # past argument=value
            ;;
        --all)
            INSTALL_FISH=1
            INSTALL_PYTHON=1
            shift # past argument=value
            ;;
        --clean)
            CLEAN=1
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
    green-echo "install zsh setings"
    ZDOTDIR=$DOTFILES_DIRECTORY
    mkdir -p $ZDOTDIR/zsh/plugins
    pushd $ZDOTDIR/zsh/plugins
    [ ! -d zsh-syntax-highlighting ] && git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git
    [ ! -d zsh-autosuggestions ] && git clone -q https://github.com/zsh-users/zsh-autosuggestions.git
    [ ! -d ~/.oh-my-zsh ] && git clone -q https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    popd
}

: "symbolic link for dotfiles" && {
    green-echo "symbolic link for dotfiles"
    cd $DOTFILES_DIRECTORY
    for f in .??*; do
        [[ "$f" == ".git" ]] && continue
        [[ "$f" == ".DS_Store" ]] && continue
        [[ "$f" == ".travis.yaml" ]] && continue
        [[ "$f" == ".ipython" ]] && continue
        [[ "$f" == ".jupyter" ]] && continue

        echo `pwd`/"$f" "->" ~/"$f"
        ln -sfn `pwd`/"$f" ~/"$f"
    done

    green-echo "symbolic link for .config files"
    for f in config/??*; do
        [ -z "$INSTALL_FISH" ] && [[ "$f" == "fish" ]] && continue
        [ -n "$CLEAN" ] && rm -rf ~/.config/$(basename "$f")
        pushd "$f"
        for file in $(git ls-files); do
            echo `pwd`/"$file" "->" ~/.config/$(basename "$f")/"$file"
            mkdir -p ~/.config/$(basename "$f")/$(dirname "$file")
            ln -sfn `pwd`/"$file" ~/.config/$(basename "$f")/"$file"
        done
        popd
    done
    if [ -n "$INSTALL_FISH" ] && [ -n "$CLEAN" ]; then
        rm -rf ~/.local/share/omf
        curl -L https://get.oh-my.fish > install-oh-my-fish.fish
        fish install-oh-my-fish.fish --noninteractive --yes --path=~/.local/share/omf --config=~/.config/omf
        rm -rf install-oh-my-fish.fish
    fi

    # fish as login shell
    [ -n "$INSTALL_FISH_LOGIN" ] && ln -sf `pwd`/config/fish/.profile ~/
}

: "vim settings install" && {
    pushd /tmp
    wget -q https://raw.githubusercontent.com/colepeters/spacemacs-theme.vim/master/colors/spacemacs-theme.vim
    mkdir -p $HOME/.config/nvim/colors
    mkdir -p $HOME/.vim/colors
    cp spacemacs-theme.vim $HOME/.config/nvim/colors/
    cp spacemacs-theme.vim $HOME/.vim/colors/
    rm -rf spacemacs-theme.vim
    popd
}

: "symbolic link for bin" && {
    green-echo "symbolic link for bin"
    mkdir -p $HOME/.local/bin
    for f in $HOME/.dotfiles/bin/*; do
        echo "$f" "->" $HOME/.local/bin/$(basename "$f")
        ln -sfn "$f" $HOME/.local/bin/$(basename $f)
    done
}

: "install applications" && {
    green-echo "install applications"
    case ${OSTYPE} in
        linux*)
            # linuxbrew
            if [ ! -d $HOME/.linuxbrew ]; then
                green-echo "install linxubrew"
                git clone https://github.com/Linuxbrew/brew.git $HOME/.linuxbrew
            else
                green-echo "update linxubrew"
                (cd $HOME/.linuxbrew && git-pull)
            fi

            # spacemacs
            if [ ! -d $HOME/.emacs.d ]; then
                green-echo "install spacemacs"
                git clone https://github.com/syl20bnr/spacemacs.git $HOME/.emacs.d
            else
                green-echo "update spacemacs"
                pushd $HOME/.emacs.d
                if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
                    git-pull
                else
                    git init
                    git remote add origin https://github.com/syl20bnr/spacemacs.git
                    git pull origin master
                fi
                popd
            fi

            # gdrive
            if [ ! -f $HOME/.local/bin/gdrive ]; then
                green-echo "install gdrive"
                wget -q "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download" -O $HOME/.local/bin/gdrive
                chmod +x $HOME/.local/bin/gdrive
            fi
            ;;
        darwin*)
            # install from brew
            ;;
    esac
}

: "install jupyter and ipython extentions" && [ -n "$INSTALL_PYTHON" ] && {
    green-echo "install jupyter extentions"
    if type jupyter >/dev/null 2>&1; then
        mkdir -p $(jupyter --data-dir)/nbextensions
        if [ ! -d $(jupyter --data-dir)/nbextensions/vim_binding ]; then
            git clone https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding
        else
            (cd $(jupyter --data-dir)/nbextensions/vim_binding && git pull origin master)
        fi
        jupyter nbextension enable vim_binding/vim_binding
    else
        red-echo 'jupyter not found\!';
        red-echo 'try to install jupyter.';
        red-echo 'pip install jupyter';
    fi

    green-echo "symbolic link for .jupyter and .ipython"
    [ -n "$CLEAN" ] && rm -rf ~/.ipython
    pushd ".ipython"
    for file in $(git ls-files); do
        echo `pwd`/"$file" "->" ~/.ipython/"$file"
        mkdir -p ~/.ipython/$(dirname "$file")
        ln -sfn `pwd`/"$file" ~/.ipython/"$file"
    done
    popd

    [ -n "$CLEAN" ] && rm -rf ~/.jupyter
    pushd ".jupyter"
    for file in $(git ls-files); do
        echo `pwd`/"$file" "->" ~/.jupyter/"$file"
        mkdir -p ~/.jupyter/$(dirname "$file")
        ln -sfn `pwd`/"$file" ~/.jupyter/"$file"
    done
    popd
}
