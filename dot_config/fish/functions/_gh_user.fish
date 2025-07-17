function _gh_user
    set -l user (git config --global --get github.user)

    if test -z "$user"
        set -l user (gh api user | jq -r '.login')

        git config --global github.user $user

        echo $user
    else
        echo $user
    end
end
