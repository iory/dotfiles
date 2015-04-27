# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

# encoding
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

# Path to my bin file
export PATH=$HOME/bin:/usr/local/bin:$PATH

if [ \command -v hub >/dev/null 2>&1 ]; then # if hub command exists ...
    plugins=(git hub)
    eval "$(hub alias -s)"
fi

# User configuration

[[ "$TERM" != "dumb" ]] && source $ZSH/oh-my-zsh.sh
setopt histignorealldups sharehistory
autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install

# if executed time is longer than 3 seconds, print information.
RERORTTIME=3

setopt auto_cd
setopt pushd_ignore_dups
setopt hist_ignore_space
zstyle ':completion:*:default' menu select=1

setopt hist_ignore_dups
setopt share_history
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt nobeep
function up(){ cpath=./; for i in `seq 1 1 $1`; do cpath=$cpath../; done; cd $cpath;}

# zsh highlight
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zaw setting
source $ZDOTDIR/plugins/zaw/zaw.zsh

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

zstyle ':filter-select' case-insensitive yes
bindkey '^X^F' zaw-cdr
bindkey '^R' zaw-history
bindkey '^X^P' zaw-process
bindkey '^X^F' zaw-git-files
bindkey '^X^B' zaw-git-branches
# bindkey '^A' zaw-tmux

# load .zshrc_setting file
[ -f $ZDOTDIR/.zshrc_alias ] && . $ZDOTDIR/.zshrc_alias


# export PATH
export PATH=$PATH:$HOME/bin/tools/bin:$HOME/.emacs.d/bin

# setting only Ubuntu
if [ -e /opt/ros ]; then # if ros exists ...
    case ${OSTYPE} in
        linux*)
            # ros setting
            VER=$(lsb_release -sr)
            case ${VER} in
                14.04)
                    source /opt/ros/indigo/setup.zsh
                    source $HOME/catkin_ws/semi/devel/setup.zsh ;;
                12.04)
                    source /opt/ros/hydro/setup.zsh ;;
            esac
            source $HOME/catkin_ws/zshrc.ros
            rossetip
            # xmodmap
            if [[ ${DISPLAY} == ":0" ]] ; then
                xmodmap ~/.xmodmaprc
            fi

            if [ -d "$HOME/.local/bin" ]; then
                PATH="$HOME/.local/bin:$PATH"
            fi
            # if [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
            #     source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
            # fi
    esac
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
