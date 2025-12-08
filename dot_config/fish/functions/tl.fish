function tl --description 'switch tmux session'
    set -l sessions (tmux list-sessions -F '#{session_name}' 2>/dev/null)

    if test (count $sessions) -eq 0
        echo "No active tmux sessions."
        return 1
    end

    set -l chosen (printf "%s\n" $sessions \
        | gum filter --height=12 --header="Select a tmux session" --limit=1)

    if test -z "$chosen"
        return 1
    end

    tmux attach -t $chosen
end
