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
