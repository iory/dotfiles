function ft -d "Switch tmux session"
    set LIST_SESSIONS (tmux list-sessions 2> /dev/null)
    if test $status -eq 0
        set N_LINE (tmux list-sessions | wc | awk '{print $1}')
        if test "$N_LINE" -eq 1
            if test -z "$TMUX"
                tmux attach
            else
                tmux list-sessions | awk '{print $1}' | tr -d ":" | xargs tmux switch-client -t
            end
        else if test "$N_LINE" -eq 2; and test -n "$TMUX"
            tmux ls -F "#{session_id}: #{?session_attached,attached,not attached}" | grep not | awk '{print $1}' | tr -d ':' | xargs tmux switch-client -t
        else
            if test -z "$TMUX"
                set SESSION_NUM (tmux list-sessions | fzf | awk '{print $1}' | tr -d ":")
                tmux a -t "$SESSION_NUM"
            else
                tmux list-sessions | fzf | awk '{print $1}' | tr -d ":" | xargs tmux switch-client -t
            end
        end
    else
        tmux
    end
end


function tmux-capture-pane -d "capture pane"
    set TMUX_LOG_DIR ~/.tmux/log/(date +%Y/%m)
    set TMUX_LOG_FILENAME $TMUX_LOG_DIR/(date +%d-%H%M%s).tmux
    mkdir -p $TMUX_LOG_DIR
    tmux capture-pane -S -100000000; and tmux show-buffer > $TMUX_LOG_FILENAME
    echo $TMUX_LOG_FILENAME
end


abbr -a ts 'tmux-capture-pane'
abbr -a tse 'eval $EDITOR (tmux-capture-pane)'

alias tp="tmux capture-pane -S -1000000000 -e; and tmux save-buffer - | less -r +Gk"
alias tv="tmux capture-pane -S -1000000000; and tmux save-buffer - | vim - +'set nonumber' +'norm G' -R"
alias te='tmux-capture-pane-edit'
