function dark --description "Returns 0 if dark mode is on, 1 otherwise"
    defaults read -g AppleInterfaceStyle &>/dev/null && return 0 || return 1
end
