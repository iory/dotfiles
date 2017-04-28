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

# ssh settings
sudo apt-get install -qq -y openssh-server
sudo sed -i 's/[# ]*PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# ignore apport
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport

# change keyboard layout
setxkbmap us
