#!/bin/fish

set fish_plugins emacs

function ecd
    set -l cmd '(let ((buf-name (buffer-file-name (window-buffer))))
    (if buf-name (file-name-directory buf-name)))'
    set -l dir (__launch_emacs --eval $cmd | tr -d '\"')

    if test -n "$dir"
        cd $dir
    else
        echo 'cannot deduce current buffer filename.' >/dev/stderr
    end
end

# setting default editor
set -x EDITOR "emacsclient"
alias emacs-shell 'emacs -nw -q -f shell'

function junk
    if [ ! -d $HOME/.emacs.d/.cache/junk/(date +%Y/%m) ]
        mkdir -p $HOME/.emacs.d/.cache/junk/(date +%Y/%m)
    end
        cd $HOME/.emacs.d/.cache/junk/(date +%Y/%m)
end
