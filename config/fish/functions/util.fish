#!/bin/fish

# cd extend
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../../"
alias ..5="cd ../../../../.."
alias dc='cd'
function dot
    cd ~/.dotfiles
end

function mcd
    mkdir -p $argv
    cd $argv
end

function cdd
    cd (dirname $argv[1])
end
alias tmp='cd /tmp'

# ls extend
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias lsf='ls -F'
alias sl="ls"

# mkdir extend
alias mkdir='mkdir -p'

## set some other defaults ##
alias df='df -H'
alias du='du -ch'

alias cpwd='pwd | pbcopy'

# grep extend
alias ggrep='grep --color=always --with-filename --line-number'

# rmdir extend
# cleanup empty dir
function cleanup
    find . -type d -maxdepth 2 -empty -exec rmdir -v {} \; 2>/dev/null
    find . -type d -maxdepth 2 -empty -exec rmdir -v {} \; 2>/dev/null
end

# cat extend
alias ccat='pygmentize -g'

# diff extend
alias diff='colordiff -y'

# misc
alias chrome='google-chrome'
function dic
    w3m "http://ejje.weblio.jp/content/$argv" | grep "用例"
end

switch (uname)
    case Linux
        # os setting
        function f
            if count $argv > /dev/null
                gnome-open $argv 2>/dev/null
            else
                gnome-open $PWD 2>/dev/null
            end
        end
        alias o='gnome-open'
        alias open='gnome-open'
        alias pbcopy='xsel --clipboard --input'
        alias ls="ls --color=always"
    case Darwin
        # https://superuser.com/questions/834525/unable-to-launch-application-in-tmux
        alias open='reattach-to-user-namespace open'
        function f
            if count $argv > /dev/null
                open $argv
            else
                open $PWD
            end
        end
        alias o='open'
end

# for gdb
alias gdb='gdb -q'
alias gdb='rlwrap -c gdb'

# # python settings
alias py='ipython --no-confirm-exit'
alias ipy='ipython --no-confirm-exit'
alias ipyt='ipython --no-confirm-exit'
alias ipyth='ipython --no-confirm-exit'
alias ipytho='ipython --no-confirm-exit'
alias ipython='ipython --no-confirm-exit'

# for opencv
alias fcv='python -c "import cv2; print(\"\n\".join([item for item in dir(cv2)]))" | grep'


# ghq
function peco_select_ghq_repository
    set -l query (commandline)

    if test -n $query
        set peco_flags --query "$query"
    end
    ghq list | peco --initial-filter Fuzzy $peco_flags | read line

    if [ $line ]
        ghq root | read dir
        cd $dir/$line
        commandline -f repaint
    end
end

# weather
function weather
    curl wttr.in/tokyo
end

function emptytrash -d "Empty the trash and Quarantine on OS X"
    switch (uname)
        case Darwin
            sudo command rm -rfv "/Volumes/*/.Trashes"
            sudo command rm -rfv $HOME/.Trash
        case Linux
            rm -rf $HOME/.local/share/Trash
    end
end

function count_down -d "CountDown and execute command"
    switch (count argv)
        case '*'
            for i in (seq $argv[1] -1 1)
                echo $i
                sleep 1
            end
            eval $argv[2..-1]
    end
end
