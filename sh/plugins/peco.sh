#!/bin/bash -eu

jj () {
    if [ $2 ]; then
        JUMP_DEPTH=$2
    else
        JUMP_DEPTH=1
    fi
    if [ $1 ]; then
        JUMPDIR=$(find . -maxdepth $JUMP_DEPTH -type d  | grep $1)
        JUMP_CANDIDATE_NUM=`echo "$JUMPDIR" | grep -c ""`
        if [ $JUMP_CANDIDATE_NUM -gt 1 ]; then
            JUMPDIR=$(find . -maxdepth $JUMP_DEPTH -type d  | grep $1 | peco)
        fi
        if [[ -d $JUMPDIR && -n $JUMPDIR ]]; then
            cd $JUMPDIR
        else
            echo "directory not found"
        fi
    fi
}

je () {
    if [ $2 ]; then
        JUMP_DEPTH=$2
    else
        JUMP_DEPTH=1
    fi
    if [ $1 ]; then
        JUMPDIR=$(find . -maxdepth $JUMP_DEPTH -xtype f | grep $1)
        JUMP_CANDIDATE_NUM=`echo "$JUMPDIR" | grep -c ""`
        if [ $JUMP_CANDIDATE_NUM -gt 1 ]; then
            JUMPDIR=$(find . -maxdepth $JUMP_DEPTH -xtype f | grep $1 | peco)
        fi
        if [[ -e $JUMPDIR && -n $JUMPDIR ]]; then
            $EDITOR $JUMPDIR
        else
            echo "file not found"
        fi
    fi
}


if [ -n "$ZSH_VERSION" ]; then
    function peco-select-history() {
        local tac
        if which tac > /dev/null; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(\history -n 1 | \
                        eval $tac | \
                        peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
    }

    function peco-cdr() {
        local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
        if [ -n "$selected_dir" ]; then
            BUFFER="cd ${selected_dir}"
            zle accept-line
        fi
        zle clear-screen
    }

    function peco-select-from-git-status(){
        git status --porcelain | \
            peco | \
            awk -F ' ' '{print $NF}' | \
            tr '\n' ' '
    }

    function peco-insert-selected-git-files(){
        LBUFFER+=$(peco-select-from-git-status)
        CURSOR=$#LBUFFER
        zle reset-prompt
    }

    function peco-git-branch-checkout () {
        local selected_branch_name="$(git branch -a | peco | tr -d ' ')"
        case "$selected_branch_name" in
            *-\>* )
                selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*->(.*?)\/(.*)$/\2/;print')";;
            remotes* )
                selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*?remotes\/(.*?)\/(.*)$/\2/;print')";;
        esac
        if [ -n "$selected_branch_name" ]; then
            BUFFER="git checkout ${selected_branch_name}"
            zle accept-line
        fi
        zle clear-screen
    }

    # peco find directory
    function peco-find() {
        local current_buffer=$BUFFER
        local search_root=""
        local file_path=""

        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            search_root=`git rev-parse --show-toplevel`
        else
            search_root=`pwd`
        fi
        file_path="$(find ${search_root} -maxdepth 5 | peco)"
        BUFFER="${current_buffer} ${file_path}"
        CURSOR=$#BUFFER
        zle clear-screen
    }

    # bind keys
    zle -N peco-find
    zle -N peco-cdr
    zle -N peco-git-branch-checkout
    zle -N peco-insert-selected-git-files
    zle -N peco-select-from-git-status
    zle -N peco-select-history
    # bindkey '^F' peco-find
    bindkey "^X^S" peco-insert-selected-git-files
    bindkey '^R' peco-select-history
    bindkey '^X^B' peco-git-branch-checkout
    bindkey '^X^F' peco-find

    function do_enter() {
        if [ -n "$BUFFER" ]; then
            zle accept-line
            return 0
        fi
        echo
        ls
        # ls_abbrev
        if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
            echo
            echo -e "\e[0;33m--- git status ---\e[0m"
            git status -sb
        fi
        zle reset-prompt
        return 0
    }
    zle -N do_enter
    bindkey '^m' do_enter

    setopt auto_cd
    function chpwd() { ls }

    function peco-ssh () {
        local selected_host=$(awk '
  tolower($1)=="host" {
    for (i=2; i<=NF; i++) {
      if ($i !~ "[*?]") {
        print $i
      }
    }
  }
  ' ~/.ssh/config | sort | peco --query "$LBUFFER")
        if [ -n "$selected_host" ]; then
            BUFFER="ssh ${selected_host}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N peco-ssh
    bindkey '^\' peco-ssh
fi
