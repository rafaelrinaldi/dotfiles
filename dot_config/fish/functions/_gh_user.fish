function _gh_user
    # Check directory-based config first (more specific)
    set -l user (git config --get github.user)

    # Fallback to global config
    if test -z "$user"
        set -l user (git config --global --get github.user)
    end

    # Final fallback: query GitHub API
    if test -z "$user"
        set -l user (gh api user | jq -r '.login')

        # Cache in global config as fallback
        git config --global github.user $user

        echo $user
    else
        echo $user
    end
end
