#!/bin/bash -eu

# cd extend
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../../"
alias ..5="cd ../../../../.."
alias dc='cd'
mcd() {
    mkdir -p $1
    cd $1
}

# ls extend
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias lsf='ls -F'
alias sl="ls"
alias ls="ls --color=always"

# mkdir extend
alias mkdir='mkdir -p'

## set some other defaults ##
alias df='df -H'
alias du='du -ch'

alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias cpwd='pwd | pbcopy'

if [ -n "$ZSH_VERSION" ]; then
    # grep extend
    alias -g G='| grep --color'

    # less extend
    alias -g L='| less'
fi

# grep extend
alias ggrep='grep --color=always --with-filename --line-number'

# less extend
export LESS='-R'
alias less='less -R'

# rmdir extend
# cleanup empty dir
cleanup () {
    find . -type d -maxdepth 2 -empty -exec rmdir -v {} \; 2>/dev/null
    find . -type d -maxdepth 2 -empty -exec rmdir -v {} \; 2>/dev/null
}

# cat extend
alias ccat='pygmentize -g'

# diff extend
alias diff='colordiff -y'

# misc
alias chrome='google-chrome'
dic () {
    w3m "http://ejje.weblio.jp/content/$1" | grep "用例"
}
alias sha1='echo -n "${1}" | openssl sha1 | sed "s/^.* //"'

# os setting
case ${OSTYPE} in
    linux*)
        alias f='gnome-open .'
        alias o='gnome-open'
        alias open='gnome-open'
        alias pbcopy='xsel --clipboard --input'
        export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'

        # xmodmap
        if [ "$PS1" ]; then
            # Disables the bloody CapsLock button
            if [[ ${DISPLAY} == ":0" ]] && [[ -e "$HOME/.xmodmaprc" ]]; then
                xmodmap ~/.xmodmaprc
            fi
        fi
        ;;
    darwin*)
        alias f="open ."
        alias lsusb='system_profiler SPUSBDataType'
        alias o="open"
        export LESSOPEN='|/usr/local/bin/src-hilite-lesspipe.sh %s'
        alias ls='CLICOLOR_FORCE=1 ls -G'
        cdf () {
            target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
            if [ "$target" != "" ]
            then
                cd "$target"
                pwd
            else
                echo 'No Finder window found' >&2
            fi
        }
        ;;
esac

# for c++
alias methashell='rlwrap -c methashell'
export CPLUS_INCLUDE_PATH=$CPP_INCLUDE_PATH:$HOME/local/cpp/cmdline:$HOME/local/cpp/opencv_utils:$HOME/local/cpp/stopwatch:$HOME/local/random

# for gdb
alias gdb='gdb -q'
if [ "$EMACS" ]; then
    # pass
    :
else
    alias gdb='rlwrap -c gdb'
fi

# for haskell
if [ -x "`which stack`" ]; then
    eval "$(stack --bash-completion-script stack)"
    alias ghc='stack ghc'
    alias ghci='stack ghci'
    alias runhaskell='stack runhaskell'
fi

# for Lisp
if [ "$EMACS" ]; then
    # pass
    :
else
    alias clisp='rlwrap -c clisp'
fi

# python settings
export PYTHONSTARTUP=~/.pythonstartup
alias py='ipython --no-confirm-exit'
alias ipy='ipython --no-confirm-exit'
alias ipython='ipython --no-confirm-exit'
