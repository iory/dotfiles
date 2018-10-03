#!/bin/fish


function peco_select_catkin_workspace
    set -l query (commandline)

    if test -n $query
        set peco_flags --query "$query"
    end
    cq --list | peco $peco_flags | read line

    if [ $line ]
        cd $line
        commandline -f repaint
    end
end
