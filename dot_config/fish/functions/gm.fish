function _git_switch_and_rebase
    git switch $argv
    git pull origin $argv --rebase --prune
end

function gm --description "Git switch to latest main/master"
    set -l git_branches (git branch)
    set -l has_main false
    set -l has_master false

    if echo $git_branches | rg -q main
        set has_main true
    end

    if echo $git_branches | rg -q master
        set has_master true
    end

    if $has_main
        _git_switch_and_rebase main
    else if $has_master
        _git_switch_and_rebase master
    else
        echo "No main or master branch found."
    end
end
