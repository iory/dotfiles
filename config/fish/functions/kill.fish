function fkill -d "kill wrapped by fzf"
    set --local pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
        echo $pid | xargs kill -9
    end
end

abbr -a fk 'fkill'
