#!/bin/fish

# setting default editor
alias emacs 'emacs-snapshot'
set -x EDITOR "emacs"
set -x EDITOR "emacsclient"
alias emacs-shell 'emacs -nw -q -f shell'
alias e 'emacsclient -a ""'
