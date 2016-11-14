#!/bin/bash -eu

# setting default editor
alias emacs='emacs-snapshot'
export EDITOR="emacs"

export EDITOR="emacsclient"
alias emacs-shell='emacs -nw -q -f shell'
function emacsclient_ () {
    emacsclient -a "" $1 &
}
alias e='emacsclient_'
