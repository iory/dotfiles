function ft -d "Switch tmux session"
    tmux list-sessions | fzf | awk '{print $1}' | tr -d ":" | xargs tmux switch-client -t
end
