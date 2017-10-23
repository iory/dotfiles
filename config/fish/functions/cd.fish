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

abbr -a jj 'fzf-bcd-widget'
