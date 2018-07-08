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
set -x EDITOR "emacsclient --no-wait"
alias emacs-shell 'emacs -nw -q -f shell'

function junk
    if [ ! -d $HOME/.emacs.d/.cache/junk/(date +%Y/%m) ]
        mkdir -p $HOME/.emacs.d/.cache/junk/(date +%Y/%m)
    end
        cd $HOME/.emacs.d/.cache/junk/(date +%Y/%m)
end


function fe -d "edit selected file"
    set --local query $argv
    if test -n "$query"
        set flags --query "$query"
    end
    set --local dir (find . -path '*/\.*' -prune -o -print 2> /dev/null | fzf $flags +m  --preview 'highlight -O ansi -l {} 2> /dev/null | head -500')
    if test -n "$dir"
        e $dir
    end
end


function fel -d "edit selected file using locate"
    set --local query $argv
    if test -n "$query"
        set --local dir (locate "$query" 2> /dev/null | fzf +m  --preview 'highlight -O ansi -l {} 2> /dev/null | head -500')
        if test -n "$dir"
            e $dir
        end
    else
        set --local dir (find / -path '*/\.*' -prune -o -print 2> /dev/null | fzf +m  --preview 'highlight -O ansi -l {} 2> /dev/null | head -500')
        if test -n "$dir"
            e $dir
        end
    end
end
