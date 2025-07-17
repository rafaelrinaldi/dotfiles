function tn --description "tmux create session"
    set -l placeholder $(basename $PWD)

    tmux new-session -A -s $(gum input --header "Create new tmux session" --placeholder $placeholder)
end
