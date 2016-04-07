#/bin/sh

# use emacs keybind on Ubuntu
case ${OSTYPE} in
    linux*)
        gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
        dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
        # gsettings set org.gnome.desktop.interface gtk-key-theme "Default"

        # fcitx
        sudo aptitude install fcitx fcitx-mozc
        gsettings set org.gnome.settings-daemon.plugins.keyboard active false

        # change CapsLock as ctrl
        dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
esac
