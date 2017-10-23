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
