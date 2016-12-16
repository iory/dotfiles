#!/bin/fish

# setting default editor
alias emacs 'emacs-snapshot'
set -x EDITOR "emacs"
set -x EDITOR "emacsclient"
alias emacs-shell 'emacs -nw -q -f shell'
function emacsclient_
    emacsclient -a "" $argv[1] &
end
alias e 'emacsclient_'
