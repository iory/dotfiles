#!/bin/sh

export DISTRIB_RELEASE=`cat /etc/lsb-release | grep DISTRIB_RELEASE | tr --delete DISTRIB_RELEASE=`

if [ ! -d ${HOME}/local ]; then
    mkdir ${HOME}/local
fi

EMACS_VERSION=24.5
# if [ ${DISTRIB_RELEASE} = "12.04" ]; then
#     sudo add-apt-repository -y ppa:cassou/emacs
#     sudo apt-get update
#     sudo apt-get install -y emacs24 emacs24-el
# else
#     sudo apt-get install -y emacs
# fi

# install emacs 24.5
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

sudo apt-get install -y cmigemo migemo
sudo apt-get install -y emacs-mozc
sudo apt-get install -y global
sudo apt-get install -y rlwrap
sudo apt-get install -y ssh
sudo apt-get install -y tmux
sudo apt-get install -y xsel
sudo apt-get install -y zsh
sudo apt-get install -y source-highlight

# sudo chsh -s `which zsh`
# sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

ln -sf ~/.dotfiles/.gdbinit ~/.gdbinit
ln -sf ~/.dotfiles/.pythonstartup ~/.pythonstartup
ln -sf ~/.dotfiles/.xmodmaprc ~/.xmodmaprc
ln -sf ~/.dotfiles/.zsh/.zshenv ~/.zshenv

# ipython settings
if [ ! -e $HOME/.ipython/profile_default/startup ]; then
    mkdir -p $HOME/.ipython/profile_default/startup
fi
ln -sf ~/.dotfiles/ipython-settings/00-first.py ~/.ipython/profile_default/startup/00-first.py

ln -sf ~/.dotfiles/.agignore ~/.agignore
ln -sf ~/.dotfiles/.gitignore_global ~/.gitignore
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/.xinitrc ~/.xinitrc

# percol settings
if [ ! -e $HOME/.percol.d ]; then
    mkdir $HOME/.percol.d
fi
ln -sf ~/.dotfiles/rc.py ~/.percol.d/rc.py

# for lisp
ln -sf ~/.dotfiles/completions/.roseus_completions ~/.roseus_completions

# for arduino
case ${OSTYPE} in
    linux*)
    sudo ln -sf ~/.dotfiles/udev-settings/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules
    sudo ln -sf ~/.dotfiles/udev-settings/10-arduino.rules /etc/udev/rules.d/10-arduino.rules
    sudo ln -sf ~/.dotfiles/udev-settings/11-arduino.rules /etc/udev/rules.d/11-arduino.rules
esac
