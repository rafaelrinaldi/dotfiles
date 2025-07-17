function tk --description "tmux kill session"
    set -l session $(tmux list-sessions | gum choose | cut -d : -f 1)

    if gum confirm "Kill tmux session '$session'?"
        tmux kill-session -t $session
    end
end
