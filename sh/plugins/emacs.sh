#!/bin/bash -eu

alias emacs-shell='emacs -nw -q -f shell'

function ecd {
    local cmd="(let ((buf-name (buffer-file-name (window-buffer))))
                     (if buf-name (file-name-directory buf-name)))"

    local dir="$($EMACS_PLUGIN_LAUNCHER --eval $cmd | tr -d \")"
    if [ -n "$dir" ] ;then
        cd "$dir"
    else
        echo "can not deduce current buffer filename." >/dev/stderr
        return 1
    fi
}

# for junk file settings
function junk {
    cd $HOME/.emacs.d/.cache/junk/$(date +%Y/%m)
}
