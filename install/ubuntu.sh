#!/bin/bash -eu

# install latest git
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update -qq
sudo apt-get install -qq -y git

# fonts install
(cd /tmp \
     && git clone https://github.com/powerline/fonts.git \
     && cd fonts \
     && ./install.sh \
     && rm -rf /tmp/fonts)

fc-cache -fv

# set font
gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "DejaVu Sans Mono for Powerline 12"

# ssh settings
sudo apt-get install -qq -y openssh-server
sudo sed -i 's/[# ]*PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# ignore apport
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport

# change keyboard layout
setxkbmap us

# workspace like a Mac
dconf read /org/compiz/profiles/unity/plugins/core/hsize
dconf read /org/compiz/profiles/unity/plugins/core/vsize

dconf write /org/compiz/profiles/unity/plugins/core/wsize 1
dconf write /org/compiz/profiles/unity/plugins/core/hsize 10

# disable pop up of dash by super key
dconf write /org/compiz/profiles/unity/plugins/unityshell/show-launcher '""'
