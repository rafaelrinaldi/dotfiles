function k --description "kill running process"
    set -l servers (lsof -iTCP -sTCP:LISTEN -Pn 2>/dev/null | tail -n +2 | \
    awk '{print $2, $1, $9}' | sort -u)

    if test (count $servers) -eq 0
        gum style --foreground 1 \
            "No listening TCP servers found."
        return 1
    end

    set -l options

    for s in $servers
        set -l parts (string split ' ' $s)
        set -l pid $parts[1]
        set -l port (string match -r ':[0-9]+$' $parts[3] | string sub -s 2)
        set -l pname (ps -p $pid -o comm= 2>/dev/null | string trim | xargs basename)
        if test -n "$pname"
            set -l desc "$pname (pid: $pid, port: $port)"
            set options $options $desc
        end
    end

    set -l selection (printf "%s\n" $options | gum filter \
    --placeholder "Select server to kill (search by port, name, or address)..." \
    --height 12)

    if test -z "$selection"
        gum style --foreground 3 "No process selected."
        return 1
    end

    set -l pid (string match -r 'pid: (\d+)' "$selection")[2]
    set -l port (string match -r 'port: (\d+)' "$selection")[2]
    set -l pname (string replace -r ' \(pid: \d+, port: \d+\)$' '' "$selection")
    set -l process "$pname ($pid) on port $port"

    gum confirm "Kill $process?"

    if test $status -eq 0
        kill -9 $pid
        and gum style --foreground 2 "Killed $process"
        or gum style --foreground 1 "Failed to kill $process"
    else
        gum style --foreground 3 "Aborted."
    end
end
