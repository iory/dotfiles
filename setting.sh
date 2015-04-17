#/bin/sh

# use emacs keybind on Ubuntu
gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
# gsettings set org.gnome.desktop.interface gtk-key-theme "Default"
