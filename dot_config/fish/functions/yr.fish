function yr --description "Yarn run"
    if not test -e package.json
        echo "No package.json found in the current directory"
        return 1
    end

    set -l scripts (jq -r '.scripts | keys[]' package.json)

    set -l script (gum choose --height 10 --header "Choose which script to run" $scripts)

    echo "Running script: '$script'"
    yarn run $script
    # history add "yarn run $script"
end
