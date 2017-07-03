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

function junk
    if [ ! -d $HOME/.emacs.d/.cache/junk/(date +%Y/%m) ]
        mkdir -p $HOME/.emacs.d/.cache/junk/(date +%Y/%m)
    end
        cd $HOME/.emacs.d/.cache/junk/(date +%Y/%m)
end
