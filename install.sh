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
        --zsh)
            INSTALL_ZSH=1
            shift # past argument=value
            ;;
        *)
            # unknown option
            ;;
    esac
done

DOTFILES_DIRECTORY=$HOME/.dotfiles
:  "install dotfiles" && {
    git-clone-or-update-with-check https://github.com/iory/dotfiles.git $DOTFILES_DIRECTORY
}

: "set zsh" && {
    if [ -n "$INSTALL_ZSH" ]; then
        green-echo "install zsh setings"
        ZDOTDIR=$DOTFILES_DIRECTORY
        mkdir -p $ZDOTDIR/zsh/plugins
        pushd $ZDOTDIR/zsh/plugins
        git-clone-or-update-with-check https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting
        git-clone-or-update-with-check https://github.com/zsh-users/zsh-autosuggestions.git zsh-autosuggestions
        git-clone-or-update-with-check https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        popd
    fi
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
        curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
    fi

    # fish as login shell
    [ -n "$INSTALL_FISH_LOGIN" ] && ln -sf `pwd`/config/fish/.profile ~/

    # for ranger
    case ${OSTYPE} in
        darwin*)
            unlink ~/.config/ranger/rifle.conf
            ln -sf `pwd`/config/ranger/rifle.mac.conf ~/.config/ranger/rifle.conf
            unlink ~/.config/ranger/rc.conf
            ln -sf `pwd`/config/ranger/rc.mac.conf ~/.config/ranger/rc.conf
        ;;
    esac

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

: "visual code settings install" && {
    # install extention
    if hash code 2>/dev/null; then
        cat config/Code/extensions | while read line
        do
            code --install-extension $line
        done
    fi
}

: "install applications" && {
    green-echo "install applications"

    # spacemacs
    green-echo "install/update spacemacs"
    git-clone-or-update-with-check https://github.com/syl20bnr/spacemacs.git $HOME/.emacs.d

    # pyenv
    green-echo "install/update pyenv"
    git-clone-or-update-with-check https://github.com/yyuu/pyenv.git $HOME/.pyenv

    case ${OSTYPE} in
        linux*)
            # exa
            if [ ! -f $HOME/.local/bin/exa ]; then
                green-echo "install exa"
                pushd /tmp
                wget -q "https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip" -O /tmp/exa-linux-x86_64-0.9.0.zip
                unzip /tmp/exa-linux-x86_64-0.9.0.zip
                mv exa-linux-x86_64 $HOME/.local/bin/exa
                rm -rf /tmp/exa-linux-x86_64-0.9.0.zip
                chmod +x $HOME/.local/bin/exa
                popd
            fi

            # gdrive
            if [ ! -f $HOME/.local/bin/gdrive ]; then
                green-echo "install gdrive"
                wget -q "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download" -O $HOME/.local/bin/gdrive
                chmod +x $HOME/.local/bin/gdrive
            fi

            # fzf
            if [ ! -f $HOME/.local/bin/fzf ]; then
                green-echo "install fzf"
                pushd /tmp
                wget -q "https://github.com/junegunn/fzf-bin/releases/download/0.20.0/fzf-0.20.0-linux_amd64.tgz" -O /tmp/fzf-0.20.0-linux_amd64.tgz
                tar xvzf /tmp/fzf-0.20.0-linux_amd64.tgz
                mv /tmp/fzf $HOME/.local/bin/fzf
                rm -rf /tmp/fzf-0.20.0-linux_amd64.tgz
                popd
            fi

            # ripgrep
            if [ ! -f $HOME/.local/bin/rg ]; then
                pushd /tmp
                RIPGREP=ripgrep-0.8.1-x86_64-unknown-linux-musl
                rm -rf /tmp/$RIPGREP.tar.gz
                wget https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/$RIPGREP.tar.gz
                tar xvzf $RIPGREP.tar.gz
                cp $RIPGREP/rg ~/.local/bin
                popd
            fi

            # ghs
            if [ ! -f $HOME/.local/bin/ghs ]; then
                GHS_RELEASE_VERSION="0.0.10"
                GHS_FILE="ghs-$GHS_RELEASE_VERSION-linux_amd64"
                pushd /tmp
                rm -rf $GHS_FILE.tar.gz
                wget https://github.com/sonatard/ghs/releases/download/$GHS_RELEASE_VERSION/$GHS_FILE.tar.gz
                tar xvzf $GHS_FILE.tar.gz
                cp $GHS_FILE/ghs ~/.local/bin
                popd
            fi
            ;;
        darwin*)
            # install from brew
            ;;
    esac

    # docker tools
    if [ ! -f $HOME/.local/bin/ctop ]; then
        wget https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64 -O $HOME/.local/bin/ctop
        chmod u+x $HOME/.local/bin/ctop
    fi
}

: "install jupyter and ipython extentions" && [ -n "$INSTALL_PYTHON" ] && {
    green-echo "install jupyter extentions"
    if type jupyter >/dev/null 2>&1; then
        mkdir -p $(jupyter --data-dir)/nbextensions
        git-clone-or-update-with-check https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding
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
