#!/bin/bash -eu

# cd extend
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../../"
alias ..5="cd ../../../../.."
alias dc='cd'
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
alias ls="ls --color=always"

# mkdir extend
alias mkdir='mkdir -p'

## set some other defaults ##
alias df='df -H'
alias du='du -ch'

alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias cpwd='pwd | pbcopy'

# grep extend
alias ggrep='grep --color=always --with-filename --line-number'

# less extend
# export LESS='-i -M -R'
export LESS='-i -M -R -S -W -z-4 -x4'
alias less='less -R'

# colorize man
set -x PAGER less
set -x LESS_TERMCAP_mb '\E[01;31m'      # Begins blinking.
set -x LESS_TERMCAP_md '\E[01;31m'      # Begins bold.
set -x LESS_TERMCAP_me '\E[0m'          # Ends mode.
set -x LESS_TERMCAP_se '\E[0m'          # Ends standout-mode.
set -x LESS_TERMCAP_so '\E[00;47;30m'   # Begins standout-mode.
set -x LESS_TERMCAP_ue '\E[0m'          # Ends underline.
set -x LESS_TERMCAP_us '\E[01;32m'      # Begins underline.

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

# alias sha1='echo -n "${1}" | openssl sha1 | sed "s/^.* //"'

# os setting
alias f='gnome-open .'
alias o='gnome-open'
alias open='gnome-open'
alias pbcopy='xsel --clipboard --input'
export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'

# xmodmap
xmodmap ~/.xmodmaprc

# # for c++
# alias methashell='rlwrap -c methashell'
# export CPLUS_INCLUDE_PATH=$CPP_INCLUDE_PATH:$HOME/local/cpp/cmdline:$HOME/local/cpp/opencv_utils:$HOME/local/cpp/stopwatch:$HOME/local/cpp/random:$HOME/local/cpp/pycpp

# for gdb
alias gdb='gdb -q'
# if [ "$EMACS" ]; then
#     # pass
#     :
# else
alias gdb='rlwrap -c gdb'
# fi

# # # for haskell
# # if [ -x "`which stack`" ]; then
# #     eval "(stack --bash-completion-script stack)"
# #     alias ghc='stack ghc'
# #     alias ghci='stack ghci'
# #     alias runhaskell='stack runhaskell'
# # fi

# # # for Lisp
# # if [ "$EMACS" ]; then
# #     # pass
# #     :
# # else
# #     alias clisp='rlwrap -c clisp'
# # fi

# # python settings
# set -x PYTHONSTARTUP ~/.pythonstartup
alias py='ipython --no-confirm-exit'
alias ipy='ipython --no-confirm-exit'
alias ipyt='ipython --no-confirm-exit'
alias ipyth='ipython --no-confirm-exit'
alias ipytho='ipython --no-confirm-exit'
alias ipython='ipython --no-confirm-exit'

# function Extract for common file formats
# from https://github.com/xvoland/Extract

# function extract {
#  if [ -z "$1" ]; then
#     # display usage if no parameters given
#     echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
#  else
#     if [ -f "$1" ] ; then
#         local nameInLowerCase=`echo "$1" | awk '{print tolower($0)}'`
#         case "$nameInLowerCase" in
#           *.tar.bz2)   tar xvjf ./"$1"    ;;
#           *.tar.gz)    tar xvzf ./"$1"    ;;
#           *.tar.xz)    tar xvJf ./"$1"    ;;
#           *.lzma)      unlzma ./"$1"      ;;
#           *.bz2)       bunzip2 ./"$1"     ;;
#           *.rar)       unrar x -ad ./"$1" ;;
#           *.gz)        gunzip ./"$1"      ;;
#           *.tar)       tar xvf ./"$1"     ;;
#           *.tbz2)      tar xvjf ./"$1"    ;;
#           *.tgz)       tar xvzf ./"$1"    ;;
#           *.zip)       unzip ./"$1"       ;;
#           *.Z)         uncompress ./"$1"  ;;
#           *.7z)        7z x ./"$1"        ;;
#           *.xz)        unxz ./"$1"        ;;
#           *.exe)       cabextract ./"$1"  ;;
#           *)           echo "extract: '$1' - unknown archive method" ;;
#         esac
#     else
#         echo "'$1' - file does not exist"
#     fi
#  fi
# }

# for opencv
alias fcv='python -c "import cv2; print(\"\n\".join([item for item in dir(cv2)]))" | grep'
