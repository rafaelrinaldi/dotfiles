function ts --description "tmux switch session"
    tmux attach-session -t $(tmux list-sessions | gum choose | cut -d : -f 1)
end
