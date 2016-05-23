#!/bin/sh

[ ! -d ${HOME}/local ] && mkdir ${HOME}/local
[ ! -d ${HOME}/bin ] && mkdir ${HOME}/bin

: "install emacs 24.5" && {
    EMACS_VERSION=24.5
    sudo apt-get install -y build-essential
    sudo apt-get build-dep -y emacs
    sudo apt-get install -y libgif-dev
    cd ${HOME}/local
    if [ ! -d emacs-${EMACS_VERSION}.tar.xz ]; then
        wget -O- http://ftp.gnu.org/gnu/emacs/emacs-${EMACS_VERSION}.tar.xz | tar xJf -
    fi
    (cd emacs-${EMACS_VERSION} \
            && ./configure \
            && make \
            && sudo make install;)
}

: "install apt package" && {
    sudo apt-get install -y cmigemo migemo
    sudo apt-get install -y curl
    sudo apt-get install -y emacs-mozc
    sudo apt-get install -y global
    sudo apt-get install -y rlwrap
    sudo apt-get install -y source-highlight
    sudo apt-get install -y ssh
    sudo apt-get install -y tmux
    sudo apt-get install -y xsel
    sudo apt-get install -y zsh
}

: "hub command install (github)" && {
    case ${OSTYPE} in
        darwin*)
            brew install hub
            ;;
        linux*)
            if [ ! -d ~/bin/hub ]; then
                curl https://hub.github.com/standalone -sLo ~/bin/hub
            fi
            chmod +x ~/bin/hub
            ;;
    esac
}

: "set zsh" && {
    sudo chsh -s `which zsh`
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

: "percol settings" && {
    if [ ! -e $HOME/.percol.d ]; then
        mkdir $HOME/.percol.d
    fi
    ln -sf ~/.dotfiles/rc.py ~/.percol.d/rc.py
}

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".travis.yaml" ]] && continue

    echo "$f"
    ln -sf `pwd`/"$f" ~/"$f"
done

: "ipython settings" && {
    if [ ! -e $HOME/.ipython/profile_default/startup ]; then
        mkdir -p $HOME/.ipython/profile_default/startup
    fi
    ln -sf ~/.dotfiles/ipython-settings/00-first.py ~/.ipython/profile_default/startup/00-first.py
}
