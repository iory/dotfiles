#!/bin/bash -eu

###############
# Git Aliases #
###############

# basic command
abbr -a grh! 'git reset --hard'
abbr -a grh~ 'git reset HEAD~'
abbr -a grh~1 'git reset HEAD~1'
abbr -a grh~2 'git reset HEAD~2'
abbr -a grh~3 'git reset HEAD~3'
abbr -a g1msg 'git log -1 --format="%s" | cat'
abbr -a g1sh 'git log -1 --format="%h" | cat'
abbr -a gram 'git remote add {$GITHUB_USER}; and git fetch {$GITHUB_USER}'

# Use hub as git client
# type hub &>/dev/null && abbr -a git=hub

abbr -a ga 'git add'
abbr -a ga. 'git add .'
abbr -a gap 'git add -p'
abbr -a gb 'git branch'
abbr -a gbD 'git branch -D'
abbr -a gba 'git branch -a'
abbr -a gcm 'git commit -m'
abbr -a gcaa 'git commit -a -m "Add"'
abbr -a gcma 'git commit -m "Add"'
abbr -a gca="git commit --amend"
abbr -a gco 'git checkout'
abbr -a gcop 'git checkout -p --'
abbr -a gcob 'git checkout -b'
abbr -a gcom 'git checkout master'
abbr -a gl 'git log --oneline'
abbr -a gln 'git log --name-only'
abbr -a glp 'git log -p'
abbr -a glg 'git log --graph --oneline --decorate --all'
abbr -a gld 'git log --pretty=format:"%h %ad %s" --date=short --all'

function _git_current_branch
    git branch ^/dev/null | sed -n '/\* /s///p'
end

abbr -a gbug 'git branch -u origin/(_git_current_branch)'
abbr -a gbum 'git branch -u $GITHUB_USER/(_git_current_branch)'
abbr -a gml 'git pull $GITHUB_USER (_git_current_branch)'
abbr -a gmpull 'git pull $GITHUB_USER (_git_current_branch)'
abbr -a gmpnp 'git pull --rebase $GITHUB_USER (_git_current_branch); and git push $GITHUB_USER (_git_current_branch)'
abbr -a gmpnpf 'git pull --rebase $GITHUB_USER (_git_current_branch); and git push $GITHUB_USER (_git_current_branch) -f'

abbr -a gbm 'git branch --all | command grep $GITHUB_USER | sed "s/ *//g"'

abbr -a gd 'git diff'
abbr -a gdw 'git diff -w'
abbr -a gdn 'git diff --name-only'
abbr -a gds 'git diff --staged'
abbr -a gda 'git diff HEAD'
# For example, gd5=git diff HEAD~5
for n in (seq 50)
    abbr -a gd$n 'git diff HEAD~$n'
    abbr -a gdn$n 'git diff --name-only HEAD~$n'
end
abbr -a first-commit 'git init; and git commit --allow-empty -m "First commit"'

abbr -a gs 'git status'
abbr -a gst 'git stash'
abbr -a gstp 'git stash pop'
abbr -a gstl 'git stash list'
abbr -a gstd 'git stash drop'

abbr -a gr 'git remote -v'
abbr -a grv 'git remote -v'

abbr -a gans="git diff -w --no-color | git apply --cached --ignore-whitespace"

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
abbr -a gpu git-branch-update

function git-pull
    switch (count $argv)
        case 0
            set repository origin
            set branch (git rev-parse --abbrev-ref HEAD)
        case 1
            set repository $argv[1]
            set branch (git rev-parse --abbrev-ref HEAD)
        case '*'
            set repository $argv[1]
            set branch $argv[2]
    end
    git pull $repository $branch
end
abbr -a gps git-pull

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
abbr -a gbw 'hub browse ^ /dev/null'

hub alias -s  >/dev/null 2>&1
abbr -a git 'hub'
