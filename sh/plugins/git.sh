#!/bin/bash -eu

###############
# Git Aliases #
###############

# basic command
alias grh!='git reset --hard'
alias grh~='git reset HEAD~'
alias grh~1='git reset HEAD~1'
alias grh~2='git reset HEAD~2'
alias grh~3='git reset HEAD~3'
alias g1msg='git log -1 --format="%s" | cat'
alias g1sh='git log -1 --format="%h" | cat'
alias gram='git remote add ${GITHUB_USER} && git fetch ${GITHUB_USER}'

# Use hub as git client
type hub &>/dev/null && alias git=hub

alias ga='git add'
alias ga.='git add .'
alias gap='git add -p'
alias gb='git branch'
alias gbD='git branch -D'
alias gba='git branch -a'
alias gcm='git commit -m'
alias gca="git commit --amend"
alias gcmh='git commit -m "hoge"'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gl='git log --oneline'
alias gln="git log --name-only"
alias glp="git log -p"
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'

alias gbug='git branch -u origin/$(git_current_branch)'
alias gbum='git branch -u $GITHUB_USER/$(git_current_branch)'
alias gml='git pull $GITHUB_USER $(git_current_branch)'
alias gmpull='git pull $GITHUB_USER $(git_current_branch)'
alias gmpnp='git pull --rebase $GITHUB_USER $(git_current_branch) && git push $GITHUB_USER $(git_current_branch)'
alias gmpnpf='git pull --rebase $GITHUB_USER $(git_current_branch) && git push $GITHUB_USER $(git_current_branch) -f'

alias gbm='git branch --all | command grep $GITHUB_USER | sed "s/ *//g"'

alias gd='git diff'
alias gdw='git diff -w'
alias gdn='git diff --name-only'
alias gds='git diff --staged'
alias gda='git diff HEAD'
# For example, gd5=git diff HEAD~5
for n in $(seq 50); do
    alias gd$n="git diff HEAD~$n"
    alias gdn$n="git diff --name-only HEAD~$n"
done
alias first-commit='(git init && git commit --allow-empty -m "First commit")'

# alias gs='git status'
alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'

alias gr='git remote -v'
alias grv='git remote -v'

alias gf='git fetch'
alias gfa='git fetch --all'

alias gans="git diff -w --no-color | git apply --cached --ignore-whitespace"

###############
# Git Funcion #
###############

function git-branch-update() {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    git fetch --all
    git reset --hard ${1:-origin}/$branch
}
alias gpu=git-branch-update

function git-pull() {
    local repository=${1:-origin}
    local branch=${2:-$(git rev-parse --abbrev-ref HEAD)}
    git pull origin $branch
}
alias gps=git-pull

function git-pull-force() {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    git-checkout-force tmp 2> /dev/null
    if [ $? != 0 ]; then return 1; fi
    git branch -D $branch > /dev/null 2>&1
    if [ $? != 0 ]; then return 1; fi
    git fetch
    if [ $? != 0 ]; then return 1; fi
    git checkout $branch
}
alias gplf=git-pull-force

# Git log find by commit message
glf() {
    git log --all --grep="$1";
}

ggp () {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}" && git branch -u origin/${1}
  else
    [[ "$#" = 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}" && git branch -u origin/${b:=$1}
  fi
}
gmp () {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push $GITHUB_USER "${*}" && git branch -u $GITHUB_USER/${1}
  else
    [[ "$#" = 0 ]] && local b="$(git_current_branch)"
    git push $GITHUB_USER "${b:=$1}" && git branch -u $GITHUB_USER/${b:=$1}
  fi
}
ggp! () {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}" --force
  else
    [[ "$#" = 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}" --force
  fi
}
gmp! () {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push $GITHUB_USER "${*}" --force
  else
    [[ "$#" = 0 ]] && local b="$(git_current_branch)"
    git push $GITHUB_USER "${b:=$1}" --force
  fi
}
alias ggpush='git push origin $(current_branch) && git push -u origin/$(git_current_branch)'
alias ggpush!='git push origin $(current_branch) --force'
alias gmpush='git push $GITHUB_USER $(current_branch) && git branch -u $GITHUB_USER/$(git_current_branch)'
alias gmpush!='git push $GITHUB_USER $(current_branch) --force'

_is_option () {
  if [[ $1 =~ "^-.*" ]]; then
    return 0
  fi
  return 1
}

grbg () {
  local branch arg
  local -a opts args
  for arg in $@; do
    if _is_option $arg; then
      opts=($arg $opts)
    else
      args=($arg $args)
    fi
  done
  if [ ${#args} -eq 0 ]; then
    branch="master"
  else
    branch=${args[1]}
  fi
  git rebase origin/$branch $opts
}
if which compdef &>/dev/null; then
  compdef _git grbg=git-checkout 2>/dev/null
fi
alias grbgi='grbg --interactive'
if which compdef &>/dev/null; then
  compdef _git grbgi=git-checkout 2>/dev/null
fi

alias gcsmg='gcmsg'

# for hub command
alias gpr='hub pull-request'
alias gfork='hub fork'
gpl () {
  if [ "$1" = "" ]; then
    hub browse -- pulls/$2 >/dev/null 2>&1
  else
    hub browse $1 pulls/$2 >/dev/null 2>&1
  fi
}
gis () {
  if [ "$1" = "" ]; then
    hub browse -- issues/$2 >/dev/null 2>&1
  else
    hub browse $1 issues/$2 >/dev/null 2>&1
  fi
}
alias gbw='hub browse $@ 2>/dev/null'
#}}}

# alias gbd='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
gbdra () {
  local remote
  if [ $# -eq 0 ]; then
    remote=$GITHUB_USER
  else
    remote=$1
  fi
  git branch -r --merged origin/master | grep "$remote\\/" | sed "s/$remote\\///" | egrep -v "HEAD|master|develop|release" | xargs git push $remote --delete
}
gbdr () {
  local remote branch
  if [ $# -eq 0 ]; then
    remote=$GITHUB_USER
    branch=$(current_branch)
  elif [ $# -eq 1 ]; then
    remote=$GITHUB_USER
    branch=$1
  else
    remote=$1
    branch=$2
  fi
  git push $remote $branch --delete
}
if which compdef &>/dev/null; then
  compdef _git gbdr=git-checkout 2>/dev/null
fi

git_remote_to_local () {
  local branches
  branches=(`git branch --all | grep $GITHUB_USER | egrep -v 'HEAD|master|develop|release' | sed "s@^ *remotes/$GITHUB_USER/@@"`)
  for br in $branches; do
    git branch $br --track $GITHUB_USER/$br 2>/dev/null
  done
}
alias gremote2local=git_remote_to_local

# commit each file
_git_commit_each_file () {
  [ "$1" != "" ] && {
    pushd `pwd` &>/dev/null
    cd $1
  }
  changed_files=`git status -s | grep "^[A-Z]" | sed 's/^...//g' | sed 's/ -> /,/g'`
  changed_files=(`echo $changed_files`)
  for file in $changed_files; do
    msg=`echo ${file} | sed "s/.*,//g"`
    echo "[${msg}]" > /tmp/git_commit_message_template
    files=`echo ${file} | tr ',' ' '`
    git commit --only ${files} --verbose --template /tmp/git_commit_message_template || break
  done
  [ "$1" != "" ] && popd &>/dev/null
}
alias gceach=_git_commit_each_file

_what_ros_package () {
  looking_path=$(pwd)
  found=$(find $looking_path -maxdepth 1 -iname package.xml | wc -l)
  while [ $found -eq 0 ]; do
    looking_path=$(dirname $looking_path)
    [ "$looking_path" = "/" ] && return
    found=$(find $looking_path -maxdepth 1 -iname package.xml | wc -l)
  done
  echo $(basename $looking_path)
}
# _git_commit_verbose () {
#   tmp_file=$(mktemp -t XXXXXX)
#   ros_package=$(_what_ros_package)
#   if [ "${ros_package}" != "" ]; then
#     echo "[${ros_package}] " > ${tmp_file}
#     git commit --verbose --template ${tmp_file}
#   else
#     git commit --verbose
#   fi
# }
# alias gc='_git_commit_verbose'
alias gc='git commit --verbose'

if which hub >/dev/null 2>&1; then
    if [ -n "$ZSH_VERSION" ]; then
        alias git='hub'
        compdef hub=git
    elif [ -n "$BASH_VERSION" ]; then
        eval "$(hub alias -s)"
    else
        :
    fi
fi

if [ -n "$ZSH_VERSION" ]; then
    # gibo: automatically generating gitignore tools
    if [ -e $HOME/bin/gibo/gibo-completion.zsh ]; then
        export PATH=$PATH:$HOME/bin/gibo/
        source $HOME/bin/gibo/gibo-completion.zsh
    fi
elif [ -n "BASH_VERSION" ]; then
    :
fi
