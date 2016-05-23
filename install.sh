#!/bin/bash

[ ! -d ${HOME}/local ] && mkdir ${HOME}/local
[ ! -d ${HOME}/local/src ] && mkdir ${HOME}/local/src
[ ! -d ${HOME}/bin ] && mkdir ${HOME}/bin

:  "settings for Ubuntu" && {
    case ${OSTYPE} in
        linux*)
            : "install apt package" && {
                sudo apt-get install -y aptitude
                sudo aptitude install -y cmigemo migemo
                sudo aptitude install -y curl
                sudo aptitude install -y emacs-mozc
                sudo aptitude install -y global
                sudo aptitude install -y rlwrap
                sudo aptitude install -y source-highlight
                sudo aptitude install -y ssh
                sudo aptitude install -y tmux
                sudo aptitude install -y xsel
                sudo aptitude install -y zsh
            }

            gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
            dconf reset /org/gnome/settings-daemon/plugins/keyboard/active
            dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
            # gsettings set org.gnome.desktop.interface gtk-key-theme "Default"

            # fcitx
            sudo aptitude install -y fcitx fcitx-mozc
            gsettings set org.gnome.settings-daemon.plugins.keyboard active false

            # change CapsLock as ctrl
            dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

            # fonts install
            (cd /tmp \
                    && git clone https://github.com/powerline/fonts.git \
                    && cd fonts \
                    && ./install.sh;)
            ;;
    esac
}

: "install for peco" && {
    (cd ${HOME}/local/src \
        && if [ ! -d peco_linux_amd64 ]; then
            wget https://github.com/peco/peco/releases/download/v0.1.12/peco_linux_amd64.tar.gz
            tar -C ${HOME}/local -xzf peco_linux_amd64.tar.gz
        fi;)
}

: "install emacs 24.5" && {
    EMACS_VERSION=24.5
    sudo aptitude install -y build-essential
    sudo aptitude build-dep -y emacs
    sudo aptitude install -y libgif-dev
    (cd ${HOME}/local \
        && if [ ! -d emacs-${EMACS_VERSION}.tar.xz ]; then
            wget -O- http://ftp.gnu.org/gnu/emacs/emacs-${EMACS_VERSION}.tar.xz | tar xJf -
            (cd emacs-${EMACS_VERSION} \
                    && ./configure \
                    && make \
                    && sudo make install;)
        fi;)
}

: "vim install" && {
    VIM_HOME=$HOME/.vim

    [ ! -d $VIM_HOME ] && mkdir $VIM_HOME

    # if [ ! -e $VIM_HOME/nerdtree ]
    # git clone https://github.com/scrooloose/nerdtree.git ~/.vim

    if [ ! -e $VIM_HOME/vim-hybrid ]; then
        git clone http://github.com:w0ng/vim-hybrid.git $VIM_HOME/vim-hybrid
        ln -sf $VIM_HOME/vim-hybrid/colors $VIM_HOME/colors
    fi

    ln -sf `pwd`/.vimrc $HOME/.vimrc
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | bash
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
    wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O- | sudo bash
    bash `pwd`/.zsh/install.sh
}

: "symbolic link for dotfiles" && {
    for f in .??*
    do
        [[ "$f" == ".git" ]] && continue
        [[ "$f" == ".DS_Store" ]] && continue
        [[ "$f" == ".travis.yaml" ]] && continue

        echo "$f"
        ln -sf `pwd`/"$f" ~/"$f"
    done
}

: "ipython settings" && {
    if [ ! -e $HOME/.ipython/profile_default/startup ]; then
        mkdir -p $HOME/.ipython/profile_default/startup
    fi
    ln -sf `pwd`/ipython-settings/00-first.py ~/.ipython/profile_default/startup/00-first.py
}
