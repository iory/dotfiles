function fzf-bcd-widget -d 'cd backwards'
    set --local DIR
    switch (uname)
        case Darwin
            pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tail -r | eval fzf +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
            set DIR "$result"
        case Linux
            pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | eval fzf +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
            set DIR "$result"
    end
    echo "$DIR"
    [ "$DIR" ]; and cd $DIR
    commandline -f repaint
end

function cdhf -d 'cd from prevdir'
    set --local DIR (echo $dirprev | xargs -n1 | sort -u | fzf)
    if test -n "$DIR"
        cd $DIR
    end
end

function cd-root-directory -d "cd to root-directory"
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
    if test $status -eq 0
        cd (git rev-parse --show-toplevel)
    else
        cd ~/
    end
end

abbr -a c cd-root-directory
abbr -a jj 'fzf-bcd-widget'
