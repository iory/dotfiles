#!/bin/sh
ln -sf ~/.dotfiles/.gdbinit ~/.gdbinit
ln -sf ~/.dotfiles/.pythonstartup ~/.pythonstartup
ln -sf ~/.dotfiles/.xmodmaprc ~/.xmodmaprc
ln -sf ~/.dotfiles/.zshenv ~/.zshenv
ln -sf ~/.dotfiles/ipython-settings/00-first.py ~/.ipython/profile_default/startup/00-first.py
ln -sf ~/.dotfiles/.agignore ~/.agignore
ln -sf ~/.dotfiles/.gitignore_global ~/.gitignore
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf

# for arduino
case ${OSTYPE} in
    linux*)
    sudo ln -sf ~/.dotfiles/udev-settings/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules
    sudo ln -sf ~/.dotfiles/udev-settings/10-arduino.rules /etc/udev/rules.d/10-arduino.rules
    sudo ln -sf ~/.dotfiles/udev-settings/11-arduino.rules /etc/udev/rules.d/11-arduino.rules
esac
