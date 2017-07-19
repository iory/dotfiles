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
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 1
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 10

# disable pop up of dash by super key
dconf write /org/compiz/profiles/unity/plugins/unityshell/show-launcher '""'

gconftool-2
gsettings --set /apps/gnome-terminal/profiles/Default/scrollback_unlimited --type bool true

# disable Alt key HUB
gsettings set org.compiz.integrated show-hud ['']

# screen off time (unlimited)
gsettings set org.gnome.desktop.session idle-delay uint32 0

# lock is enabled
gsettings set org.gnome.desktop.session idle-delay uint32 1

# show date
gsettings set com.canonical.indicator.datetime show-date true

# key repeat time
gsettings set org.gnome.desktop.peripherals.keyboard delay 144
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20

# default keybind as emacs
gsettings set org.gnome.desktop.interface gtk-key-theme Emacs

# caps as ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

# window resize
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Shift><Alt>k']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Shift><Alt>j']"

# switch workspace
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Primary>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Primary>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Primary>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Primary>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Primary>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Primary>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Primary>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Primary>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Primary>9']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Primary>0']"
