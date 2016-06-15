# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

# encoding
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

# Path to my bin file
export PATH=$HOME/bin:/usr/local/bin:$PATH

# User configuration
[[ "$TERM" != "dumb" ]] && source $ZSH/oh-my-zsh.sh
setopt histignorealldups sharehistory
autoload -Uz compinit
compinit

autoload history-search-end
setopt list_packed


# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
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
function up() { cpath=./; for i in `seq 1 1 $1`; do cpath=$cpath../; done; cd $cpath; }

# zsh highlight
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

zstyle ':filter-select' case-insensitive yes
# bindkey '^X^P' zaw-process
# bindkey '^X^B' zaw-git-branches

source $ZDOTDIR/.zshrc.iory

# export PATH
export PATH=$PATH:$HOME/bin/tools/bin:$HOME/.emacs.d/bin


# for emacs on terminal settings
# http://dqn.sakusakutto.jp/2014/10/emacs_shell_iterm2_zsh.html
# oh-my-zsh
DISABLE_AUTO_TITLE="true"

# add python path
export PYTHONPATH=/usr/local/Cellar/opencv3/3.0.0/lib/python3.4/site-packages:$PYTHONPATH


# load .zshrc_setting file
[ -f $ZDOTDIR/.zshrc_alias ] && . $ZDOTDIR/.zshrc_alias

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH=$PATH:${HOME}/bin:${HOME}/local/peco_linux_amd64

source ~/.dotfiles/sh/plugins/ros.sh
export GITHUB_USER=iory
source ~/.dotfiles/sh/plugins/git.sh
source ~/.dotfiles/sh/plugins/emacs.sh
source ~/.dotfiles/sh/plugins/util.sh
source ~/.dotfiles/sh/plugins/peco.sh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
