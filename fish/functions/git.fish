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
alias gram='git remote add {$GITHUB_USER}; and git fetch {$GITHUB_USER}'

# Use hub as git client
# type hub &>/dev/null && alias git=hub

alias ga='git add'
alias ga.='git add .'
alias gap='git add -p'
alias gb='git branch'
alias gbD='git branch -D'
alias gba='git branch -a'
alias gcm='git commit -m'
alias gca="git commit --amend"
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gl='git log --oneline'
alias gln="git log --name-only"
alias glp="git log -p"
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'

function _git_current_branch
    git branch ^/dev/null | sed -n '/\* /s///p'
end

alias gbug='git branch -u origin/(_git_current_branch)'
alias gbum='git branch -u $GITHUB_USER/(_git_current_branch)'
alias gml='git pull $GITHUB_USER (_git_current_branch)'
alias gmpull='git pull $GITHUB_USER (_git_current_branch)'
alias gmpnp='git pull --rebase $GITHUB_USER (_git_current_branch); and git push $GITHUB_USER (_git_current_branch)'
alias gmpnpf='git pull --rebase $GITHUB_USER (_git_current_branch); and git push $GITHUB_USER (_git_current_branch) -f'

alias gbm='git branch --all | command grep $GITHUB_USER | sed "s/ *//g"'

alias gd='git diff'
alias gdw='git diff -w'
alias gdn='git diff --name-only'
alias gds='git diff --staged'
alias gda='git diff HEAD'
# For example, gd5=git diff HEAD~5
for n in (seq 50)
    alias gd$n="git diff HEAD~$n"
    alias gdn$n="git diff --name-only HEAD~$n"
end
alias first-commit='git init; and git commit --allow-empty -m "First commit"'

alias gs='git status'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'

alias gr='git remote -v'
alias grv='git remote -v'

alias gans="git diff -w --no-color | git apply --cached --ignore-whitespace"

###############
# Git Funcion #
###############

function git-branch-update
    set -l branch (git rev-parse --abbrev-ref HEAD)
    git fetch --all
    switch (count $argv)
        case 0
            git reset --hard origin/$branch
        case '*'
            git reset --hard $argv[1]/$branch
    end
end
alias gpu=git-branch-update

function git-pull
    switch (count $argv)
        case 0
            set -l repository origin
            set -l branch (git rev-parse --abbrev-ref HEAD)
        case 1
            set -l repository $argv[1]
            set -l branch (git rev-parse --abbrev-ref HEAD)
        case '*'
            set -l repository $argv[1]
            set -l branch $argv[2]
    end
    git pull $repository $branch
end
alias gps=git-pull

# # Git log find by commit message
function glf
    git log --all --grep=$argv[1]
end

function gis
    switch (count $argv)
        case 0
            hub browse -- issues >/dev/null 2>&1
        case 1
            hub browse $argv[1] issues >/dev/null 2>&1
        case '*'
            hub browse $argv[1] issues/$argv[2] >/dev/null 2>&1
    end
end
alias gbw='hub browse ^ /dev/null'

hub alias -s  >/dev/null 2>&1
alias git='hub'
