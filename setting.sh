#/bin/sh

# use emacs keybind on Ubuntu
case ${OSTYPE} in
    linux*)
        gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
        dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
        # gsettings set org.gnome.desktop.interface gtk-key-theme "Default"
esac

# change CapsLock as ctrl
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
