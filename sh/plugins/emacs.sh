#!/bin/bash -eu

# setting default editor
export EDITOR="emacs"
if [[ ${DISPLAY} == ":0" ]] ; then
    export EDITOR="emacsclient"
    alias emacs-shell='emacs -nw -q -f shell'
    alias e='emacsclient -a ""'
fi
