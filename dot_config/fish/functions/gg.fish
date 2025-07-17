function gg --description "Git add/commit/push all at once"
    if not gum confirm
        return 1
    end

    set -l title $(gum input --value "WIP")

    git add .
    git commit . -m $title --no-verify
    git push
end
