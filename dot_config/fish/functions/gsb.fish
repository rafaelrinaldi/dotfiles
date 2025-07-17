function gsb --description "Git switch branch"
    set -l branches $(git for-each-ref --sort=-committerdate --format='%(refname:short) (last changed %(committerdate:relative))' refs/heads/)
    gum choose $branches --header "Switch working branch" --height 10 | awk '{print $1}' | xargs git switch
end
