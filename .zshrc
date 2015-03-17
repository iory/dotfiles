# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

plugins=(git hub)
eval "$(hub alias -s)"

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

source $ZSH/oh-my-zsh.sh
setopt histignorealldups sharehistory
autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
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

# zaw setting
source $ZDOTDIR/plugins/zaw/zaw.zsh

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 10000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

zstyle ':filter-select' case-insensitive yes
bindkey '^X^F' zaw-cdr
bindkey '^R' zaw-history
bindkey '^X^P' zaw-process
# bindkey '^X^F' zaw-git-files
# bindkey '^X^B' zaw-git-branches

case ${OSTYPE} in
     linux*)
     # ros setting
     source /opt/ros/indigo/setup.zsh
     source $HOME/catkin_ws/zshrc.ros
     rossetip
     source $HOME/catkin_ws/semi/devel/setup.zsh
     # xmodmap
     xmodmap ~/.xmodmaprc
esac

# zsh highlight
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# export PATH
export PATH=$PATH:~/bin/tools:~/.emacs.d/bin

# load .zshrc_setting file
[ -f $ZDOTDIR/.zshrc_alias ] && . $ZDOTDIR/.zshrc_alias
