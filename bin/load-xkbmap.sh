#!/bin/sh

if [ -s $HOME/.xkb/keymap/iory-keymap ]
then
    sleep 1
    xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/iory-keymap $DISPLAY 2>/dev/null
fi
