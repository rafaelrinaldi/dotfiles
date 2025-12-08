function tn --description "tmux new session"
    set -l default_name (basename $PWD)
    set session_name (gum input \
    --value="$default_name" \
    --placeholder="$default_name" \
    --prompt="New tmux session: ")

    if test $status -ne 0
        echo "No tmux session was created"
        return 1
    end

    tmux new-session -A -s $session_name
end
