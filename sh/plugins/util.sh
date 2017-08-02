#!/bin/bash -eu

# cd extend
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../../"
alias ..5="cd ../../../../.."
alias dc='cd'
alias dot='cd ~/.dotfiles'
mcd() {
    mkdir -p $1
    cd $1
}

mbuild() {
    mdkir -p build
    cd build
}

alias tmp='cd /tmp'

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
# export LESS='-i -M -R'
export LESS='-i -M -R -S -W -z-4 -x4'
alias less='less -R'

# colorize man
export PAGER=less
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

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
        alias f='gnome-open . 2>/dev/null'
        alias o='gnome-open'
        alias open='gnome-open'
        alias pbcopy='xsel --clipboard --input'
        if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
           export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
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
export CPLUS_INCLUDE_PATH=$CPP_INCLUDE_PATH:$HOME/local/cpp/cmdline:$HOME/local/cpp/opencv_utils:$HOME/local/cpp/stopwatch:$HOME/local/cpp/random:$HOME/local/cpp/pycpp

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
alias ipyt='ipython --no-confirm-exit'
alias ipyth='ipython --no-confirm-exit'
alias ipytho='ipython --no-confirm-exit'
alias ipython='ipython --no-confirm-exit'

# video to gif
function video2gif {
    mkdir -p frames
    ffmpeg -i $1 -r $2 'frames/frame-%03d.jpg'
    convert -delay 20 -loop 0 frames/*.jpg $1.gif
}

function mts2mp4() {
    filename=$(basename "$1")
    extension="${filename##*.}"
    filename="${filename%.*}"
    ffmpeg -i $1 -c:v copy -c:a aac -strict experimental -b:a 128k ${filename}.mp4
}

function video2png() {
    filename=$(basename "$1")
    extension="${filename##*.}"
    filename="${filename%.*}"
    mkdir -p $filename
    cd $filename
    ffmpeg  -i ../$1 -r 5 -f image2 $filename_%06d.png -q:v 1
}

# function Extract for common file formats
# from https://github.com/xvoland/Extract

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f "$1" ] ; then
        local nameInLowerCase=`echo "$1" | awk '{print tolower($0)}'`
        case "$nameInLowerCase" in
          *.tar.bz2)   tar xvjf ./"$1"    ;;
          *.tar.gz)    tar xvzf ./"$1"    ;;
          *.tar.xz)    tar xvJf ./"$1"    ;;
          *.lzma)      unlzma ./"$1"      ;;
          *.bz2)       bunzip2 ./"$1"     ;;
          *.rar)       unrar x -ad ./"$1" ;;
          *.gz)        gunzip ./"$1"      ;;
          *.tar)       tar xvf ./"$1"     ;;
          *.tbz2)      tar xvjf ./"$1"    ;;
          *.tgz)       tar xvzf ./"$1"    ;;
          *.zip)       unzip ./"$1"       ;;
          *.Z)         uncompress ./"$1"  ;;
          *.7z)        7z x ./"$1"        ;;
          *.xz)        unxz ./"$1"        ;;
          *.exe)       cabextract ./"$1"  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"
    fi
 fi
}

# for opencv
alias fcv='python -c "import cv2; print(\"\n\".join([item for item in dir(cv2)]))" | grep'


# for docker
alias dck="docker"
alias dckp='docker ps -a'
